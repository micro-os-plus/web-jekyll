---
layout: old-wiki-page
permalink: /micro-os-plus/i/Synchronisation_events/
title: Synchronisation events
author: Liviu Ionescu

date: 2011-03-08 22:24:45 +0000

---

Synchronisation primitives are required to avoid busy waits; instead of looping until a condition is met, it is far more efficient to put the given task to sleep and to wake it up when the condition is fulfilled.

µOS++ synchronisation primitives are based on Unix sleep/wakeup mechanism; the semantics are more or less preserved, however, in an attempt to increase readability, the functions were renamed to **eventWait()/eventNotify()**.

In addition to the Unix save/restore roots, the design of µOS++ was also inspired by Java Threads, at least the wait/notify names were used. One difference from the Java implementation is that in µOS++ the wait/notify methods are linked only to tasks, not to all objects as in Java.

What wait/notify is not?
========================

The wait/notify mechanism does not include any condition that the program is waiting for; i.e. if the waiting task is notified, this does not necessarily mean that the condition was met, and the reverse, if the task was not notified, this does not mean that the condition was not met.

From a more general point of view, the wait/notify mechanism is not a communication mechanism, since it is not designed to carry any information payload between objects in general or not even between tasks in particular.

The wait/notify mechanism is also not a full synchronisation mechanism, since it does not include critical sections or any other mechanisms to protect variables from being accessed simultaneously from multiple tasks.

What wait/notify is?
====================

The **eventWait()**/**eventNotify()** methods represent the µOS++ basic bricks for building complete synchronisation objects, like blocked I/O, mutex, event flags, etc.

From the scheduler point of view, the truly basic operations would be **yield()** and **setWaiting(true)**/**setWaiting(false)**; these are the absolute minimum requirements for a highly general design; using these and external data structures, any other mechanism could be designed.

However, we decided that implementing the event mechanism outside the scheduler would be less efficient, and trading efficiency for generality would not be worth in an embedded system. Based on the success of the Unix sleep/wakeup mechanism, we considered that it should also be enough for µOS++, and the need for other mechanisms would be quite remote.

Based on the above, we decided to incorporate the event synchronisation mechanism into the task and scheduler classes, so that a task cannot just wait in general, but always wait for an event.

How does it work?
=================

At the first glance, for eventWait(), the behaviour seems quite straightforward, the event is stored in the current task structure, the task is marked as **waiting** and the CPU is released to other tasks with a yield().

As expected, eventNotify() does the oposite, if the task is waiting and the and the notified event matches the event the ask is waiting for, the task is marked as no longer waiting and it is inserted in the list with active tasks.

What happens if a task is notified several times?
=================================================

When a waiting task is notified, it changes status to active and it is no longer able to receive any further notifications.

So only the first notification is accounted for, all other are silently ignored.

To inform the user that the task was notified, the task method eventNotify() returns 1, otherwise returns 0.

What happens if there is no task waiting for the given event?
=============================================================

As we can foresee from the above section... nothing happens. The call is silently ignored and eventNotify() returns 0.

The race condition between wait and notify
==========================================

Although the mechanism seems straightforward, *the Devil is in the details*.

The usual scenario when using wait and notify is:

1.  one task tests the condition and decides it must wait, so it arranges for another task or an interrupt service routine to notify it when the condition is met
2.  this first task calls eventWait() and releases the CPU
3.  another task, or an interrupt service routine, calls the eventNotify()
4.  the first task is marked as active, and scheduled when possible

What if, for one reason or another, the first task is interrupted exactly between step 1 and 2, i.e. before having the chance to perform the eventWait()?

The scenario in this case would be the following:

1.  one task tests the condition and decides it must wait
2.  another task, or an interrupt service routine, calls the eventNotify()
3.  this first task performs eventWait()

The correct answer is: a possible deadlock. When the eventNotify() is called, since the first task did not have the chance to call the eventWait(), the notified event is ignored. Later on, after the first task calls eventWait(), probably there will be no task to notify it, since the task originating the event already notified the event.

For periodic events, like those generated by a timer, the problem might pass unnoticed if the next tick will notify the task, but the timer precision is affected.

Also for devices that receive streams of bytes and generate interrupts for each byte, the race condition may occur on the first interrupt, but if the byte is buffered, it might also pass unnoticed, the reading task being notified by the next interrupts.

However, this is a potentially serious problem, and well behaved programs should always avoid race conditions, by using critical sections.

Solutions to the race condition
===============================

The first and simplest solution for the race condition is to include both the test of the condition and the eventWait() in a critical section

    os.sched.criticalEnter();
    {
      if (!isAvailable())
        eventWait(event);
    }
    os.sched.criticalExit();

For applications that decide to squeeze every cycle from the CPU by minimising the critical sections, µOS++ also provides a finer grain access to the eventWait() internals: the eventWaitPrepare() and eventWaitPerform() methods.

The rationale behind this is that within eventWait() only the code required to register the event in the system structures needs to run in a critical section with the code testing the condition; the code that performs the yield() is imune to race conditions.

So, a more elaborate solution for the race condition would look like

    bool doWait;
    doWait = false;

    setEventWaitReturn(OSEventWaitReturn::OS_IMMEDIATELY);

    os.sched.criticalEnter();
    {
      doWait = (!isAvailable()) && eventWaitPrepare(event);
    }
    os.sched.criticalExit();

    if (somethingWrong)
    {
      eventWaitClear();
      return;
    }

    if (doWait)
      eventWaitPerform();

    OSEventWaitReturn_t ret;
    ret = getEventWaitReturn();

Scheduler vs. task notifications
================================

One interesting characteristic of the original Unix sleep/wakeup mechanism was that one single wakeup() call was able to wake multiple threads waiting for the same event.

Although this seems more of a theoretical problem than a practical need, one classical example where multiple tasks should be notified by a single call is the mutex implementation, or any similar synchronisation object used by multiple tasks to serialise access to a common resource. The keyword here is **multiple**: if several tasks are competing for a common resource, when one releases the resource, it should notify **all** tasks waiting for the resource.

µOS++ provides such a functionality, in the OSScheduler class. When calling the OSScheduler::eventNotify(), all tasks are enumerated, and those waiting for the given event are notified.

In fact, using OSScheduler::eventNotify() is the recommended way of sending notifications. The alternative of sending notifications directly to the tasks should be used as an optimisation, but only when it is absolutely obvious there is only one task waiting for the given event.

Notifying all tasks
===================

µOS++ implements a special case when a single eventNotify() can be automatically addressed to all waiting tasks. For this case µOS++ reserves a special event code, defined as OSEvent::OS_ALL.

The reasons for notifying all tasks may vary, one of them being the case when there are more than one conditions to wait for, on multiple tasks. Each of the events notify all tasks, and the first task that gets the CPU may acquire a shared resource.

When using this feature, it is recommended to explicitly set the return value to OSEventReturn::OS_ALL.

    os.sched.eventNotify(OSEvent::OS_ALL, OSEventReturn::OS_ALL);

Waiting for any event
=====================

Similarly, a task can arrange to be waken by all incoming events. For this, the same OSEvent::OS_ALL can be used.

    os.sched.eventWait(OSEvent::OS_ALL);

Obviously, after waking up, the task should check for the condition it is expecting, and if not fulfilled, to loop to eventWait().

However It should be noted that this is not an optimal use of the multitasking mechanisms.

Why is eventWait() returning a value?
=====================================

As already mentioned, a returning eventWait() does not guarantee that the condition it was waiting for really occurred. It just means someone called an eventNotify() on the same event, or even worse, called an eventNotify(OSEvent::OS_ALL). Possible reasons for someone to call eventNotify() even when the condition is not true can be timeouts or task cancellation requests.

In order to differentiate between all these possible cases, µOS++ provides an additional argument to eventNotify(event, ret). When the eventNotify() is processed, this value is simply passed as a return value for eventWait(). The default for this value is defined as OSEventReturn::OS_VOID, but it is recommended to duplicate the event as the event return value.

    os.sched.eventNotify(event, (OSEventReturn_t)event);

Other special values for OSEventReturn are defined for timeouts (OSEventReturn::OS_TIMEOUT), cancelled tasks (OSEventReturn::OS_CANCELLED and other cases. It is recommended to use these values for similar functionality.

In addition, depending on the application's specifics, it is recommended to check the value returned by eventWait() and if needed, loop to eventWait().

Methods overview
================

TODO: this sections needs to be updated, content moved to the API section and here only a short summary kept.

Wait for event
--------------

    OSEventWaitReturn_t eventWait(OSEvent_t event);

Block the current task and wait for the event to occur (task is *put to sleep*). The task is removed from the running list and will no longer be scheduled to run until the event occurs. The first notification addressed to the given event will unblock the task and the specified value will be returned (*wake up* the task).

In addition to application managed return values, it is recommended to consider processing the following special return values:

-   OSEventWaitReturn::OS_LOCKED: the scheduler is locked and the call returned immediatelly
-   OSEventWaitReturn::OS_TIMEOUT: a timeout event occured (usually triggered by a timer)
-   OSEventWaitReturn::OS_CANCELED: another task cancelled this wait
-   OSEventWaitReturn::OS_ALL: a notification was sent to all tasks

Return: the value used by the nofitication call.

Notify event
------------

    int eventNotify(OSEvent_t event, OSEventWaitReturn_t ret=OSEventWaitReturn::OS_VOID);

Notifies all tasks waiting on the given event. Notified tasks are inserted into the running list (in the order they were registered to the schedulers) and will wait their turn for the CPU. Only the first notification addresed to a blocked task is significative, i.e. only the 'ret' value of the first notification will be returned by corresponding **evenWait()** functions; all further notifications addressed to a task waiting to run or running will be silently discarded.

A special case is when the event is OSEvent::OS_ALL since all waiting tasks are notified, regardless of the event they are waiting for (in other words, OSEvent::OS_ALL acts like a wildcard matching all events). For a consistent processing, it is recommended to pair this special event with the special return value OSEventWaitReturn::OS_ALL.

Return: the number of tasks notified.
