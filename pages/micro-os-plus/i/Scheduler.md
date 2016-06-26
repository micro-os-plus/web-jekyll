---
layout: old-wiki-page
permalink: /micro-os-plus/i/Scheduler/
title: Scheduler
author: Liviu Ionescu

date: 2011-03-03 13:35:53 +0000

---

Overview
========

As for most embedded operating systems, the scheduler is the heart of µOS++.

The two main requirements behind the design of the µOS++ scheduler are:

-   conveniently and efficiently run multiple execution threads at the same time
-   help conserve power

Why multiple threads?
=====================

The [Java Threads](http://www.amazon.com/Java-Threads-Scott-Oaks/dp/0596007825/) book (one of the inspiration source for this project) states:


*Historically, threading was first exploited to make certain programs easier to write: if a program can be split into separate tasks, it's often easier to program the algorithm as separate tasks or threads... while it is possible to write a single-threaded program to perform multiple tasks, it's easier and more elegant to place each task in its own thread.*

As a multitasking system, µOS++ allows several independent threads to run in the context of a shared common memory space (for simplicity, in µOS++ the threads are named **tasks**).

Task states
===========

From the scheduler point of view, at any moment of time, tasks can be in one of the following states:

-   running
-   active
-   waiting
-   suspended

On a single core CPU, there is only one task in the **running** state at a given moment, and this is the task currently using the CPU. From **running**, a task may voluntarily change to **waiting**, or may be turned to **active** by a rescheduling interrupt.

**Active** tasks are all other tasks actively competing for the CPU. From the implementation point of view, active tasks are those present in the list of active tasks, or in other words tasks ready to run. The task with the highest priority becomes **running** after the next rescheduling moment.

When a task needs some data that is not currently available, it calls eventWait(), and the task status is changed to **waiting**, until the new data is available.

The last state, **suspended**, although not so widely used, represents the condition when a task is completely isolated from the scheduler. It is still present in the system, it still occupies a task slot, but regardless of its priority, it is never inserted in the active list and it is never notified for any events.

Blocking I/O
============

One of the most encountered scenario when implementing tasks, is to wait for some kind of input data, for example by performing a **read()**, then process the data and most of the time proceed in a loop. When the system executes the read(), the thread needs to wait for the required data to become available before it can continue to the next statement. This type of I/O is called *blocking I/O:* the thread blocks until some data is available to satisfy the read() method. One possible implementation is to simply loop until the data becomes available, but this type of behaviour simply wastes resources (CPU cycles and implicitly power) and should be avoided by all means.

Well behaved applications should never enter (long) busy loops waiting for conditions to occur, but instead arrange for an event to be triggered and put the task to a special mode, while waiting for the event to occur. During this period the task releases the CPU, so the CPU will be fully available for the other active tasks. Another names for this special mode are idle/waiting/blocked/sleeping. You might encounter them equally in the µOS++ documentation, all with the same meaning when referring to tasks.

For the sake of completeness, it should be noted that the only exception to the rule applies to short delays, where short means delays with durations comparable with the multitasking overhead (i.e. interrupt enter, context save, interrupt service routine, event notify, context restore and interrupt exit). On most processors this is usually in the range of some tens of microseconds.

Idle/Sleep modes
================

Please note that a waiting/sleeping task does not immediately mean the entire CPU is put to sleep (technically enter either the **idle** mode or a **deeper sleep** mode), it just means that the task will no longer be scheduled to use the CPU until the event will be triggered. When all tasks enter the waiting state and there is nothing else to do, the special idle task will usually arrange for the CPU to enter idle mode, waiting for an interrupt to occur.

In idle mode the processor is fully functional, with all internal peripherals active, except that it does not run any instructions, so it is able to save a certain amount of power.

If the application has relatively long inactive moments, further savings are possible, i.e. power down all peripherals except a low frequency real time timer, usually triggered once a second. In this case the idle task can arrange for the CPU to enter a deep sleep mode, saving a significantly higher amount of power.

As a summary, the multilevel strategy used to reduce power consumption implies:

-   if nothing to do, each task should enter the idle/waiting state as soon as possible, and release the CPU to the other active tasks
-   if no active tasks are available, the idle task should arrange for the CPU to enter the idle mode as soon as possible
-   if all tasks know they will be inactive for a longer period, the idle task should arrange for the CPU to enter a deep sleep mode

In conclusion, by providing a wide range of power management features, µOS++ can be successfully used in very low power applications.

Scheduling strategies
=====================

Althought in a well behaved system most of the time the CPU is idle waiting for events and there are no tasks scheduled to run, there are moments when multiple events occur in parallel and thus multiple tasks may be scheduled to run in parallel.

The main criterion the scheduler uses to order the tasks waiting for execution is a static priority, ranging from 0x01 to 0xFF, with higher values representing higher priorities, i.e. faster execution. If no special priority policies are needed, all tasks are created with equal (default) priority.

Round-robin scheduling
======================

When multiple tasks with equal priorities are detected, µOS++ uses a **round robin** policy to schedule them, i.e. after loosing the CPU, a task will always be inserted in the running list **after** all existing tasks with equal priority. There are many scheduling policies available, but for simple embedded applications it is considered that by using such a policy, tasks with equal priority are given a more or less fair access to the CPU.

Cooperative multitasking
========================

This is the simplest multitasking method, speculating the usual behaviour of applications to politely wait for events to occur. Each time such a wait is needed, the application releases the CPU to the next waiting task. When all tasks are waiting, execution reaches the idle task, where the entire CPU is put to idle/sleep until an interrupt occurs. When an interrupt is triggered, the interrupt service routine notifies the waiting task about the event, and the scheduler inserts it back into the active tasks list, so that sooner or later the task will be given a chance to process the event. If there are no active tasks, the idle task will automatically release the CPU to the new task, so the reaction is immediate. If the interrupt occurs when the processor is executing code for another task, even with lower priority, this task will continue to run until explicitly releasing the CPU. With a careful design (like properly sized buffers where interrupts store the incoming data), for usual short tasks this delay is not a problem.

However, in case of very long computational sequences, the applications should be polite and explicitly release the CPU, to give the other tasks a fair chance to run and process the incoming data.

In general cooperative multitasking is easier to implement, and, since the CPU is release under the application control, inter-task synchronisation race conditions are avoided. However, at a more thorough analysis, this is not necessarily a feature, but a subtle way to hide other application synchronisation bugs, like the lack of explicit critical sections. In other words, a well behaved application should protect a shared resource by use of a critical section anyway, since although another task cannot execute inside another task, interrupt service routines can, and without the critical section it is very likely that a race condition may occur.

As disadvantages of cooperative multitasking, we can name the delay between the moment when the event occurs and the moment the corresponding task is scheduled to process it, entirely at the mercy of the other running applications.

Preemptive multitasking
=======================

This is an enhancement to cooperative multitasking, intended to reduce the reaction time to notified events. From the implementation point of view, preemptive multitasking implies the existence of a mechanism to be used in the interrupt that generate the events that require faster reaction.

This mechanism should allow to perform a full context save at the beginning of the interrupt, and a context switch to select the task with the highest priority, followed by a full restore of the context at the end of the interrupt.

By using such a mechanism, if the interrupt notifies a high priority task, at the end of the interrupt the CPU is no longer continuing the interrupted task, but automatically executes the code of the notified task.

There can be many interrupts using the context save/restore code, at the limit all of them.

Traditionally, most multitasking systems use a periodical system timer interrupt for time services, like performing timer sleep(), or counting timeouts. Adding the context save/restore code to this interrupt has several additional benefits:

-   no task can grab the CPU for more than the system timer period, since at the end of each interrupt the system will reschedule the CPU to the task with the highest priority at that moment
-   since the rescheduling occurs automatically no later than the system timer period, it is not mandatory for the other interrupts to include the context save/restore code (except those that require faster reaction time than the system timer period)

ISR vs. yield() context layout
==============================

One obvious condition in order for the preemptive multitasking to co-exist with cooperative multitasking is to use a common context layout, i.e. the order for saving the registers on the stack when entering a rescheduling interrupt service routine should be identical with the order used when entering yield(), so yield() will be able to restore contexts saved by interrupts, and interrupts will be able to return to contexts saved by yield().

As a metter of personal preferences, one of the criteria I use to measure the elegance of a microprocessor design is the required effort to implement the context saving/restoring code for the given architecture. From this point of view, my preffered design is the ARM Cortex-M3, which provides not only a unified context layout for both ISRs and yield(), but also hardware support for ISR context switch, a very elegant and easy to use solution.

On the other side of the spectrum, the Avr32 is the architecture requiring the most effort to implement the scheduler, with three different context restore routines and the need to rewrite the context saved by yield() to match that needed by interrupts.

Preemptive vs. cooperative
==========================

Based on our experience, applications should be written portably, i.e. do not rely on a specific implementation and do all synchronisation with system event primitives.

The µOS++ scheduler can work both in cooperative and in preemptive mode. The decision can be made at build time, by using the OS_EXCLUDE_PREEMPTION definition. Even more, when built in preemptive mode, the µOS++ can be dynamically configured to work in cooperative mode, by using the setPreemptive() method.

For most applications, the recommended mode is the default one, i.e. the preemptive multitasking mode. The cooperative mode might be used for special applications, but we cannot refer to something special here.

One special useful application of the cooperative mode is for debugging possible inter-task race conditions. In case of strange behaviours that might be associated with synchronisation problems, if building the entire application in cooperative mode solves the problem, then an inter-task race condition is highly probable. It the problem is still present in cooperative mode, than most probably the race condition involves the interrupt service routines. In both cases, the cure is to use critical sections where needed.

Rescheduling moments
====================

A task may release the CPU to other tasks (technically perform a context switch) when:

-   it needs to wait for an external event by calling **eventWait()**
-   upon explicit request by calling **yield()**
-   a processor interrupt occurs and the interrupt service routine is equipped with a context handler, that calls the scheduler

If preemptive scheduling is available, a context switch is performed at least on each system timer interrupt, usually 1000 times per second, plus on faster interrupts; at the limit, context switch can be performed on all interrupts, excluding the Real Time interrupts.

Critical sections
=================

Scheduler critical sections are regions of code that are guaranteed for not being interrupted by regular interrupts (excluding Real Time interrupts).

They represent the only safe synchronisation mechanism between task code and interrupt code, and also between nested interrupts code.

By default, the µOS++ scheduler implements the critical sections with a full interrupts disable/enable pair. When Real Time interrupts are needed, the system critical sections are implemented with a mask, to disable only the non Real Time interrupts.

Critical sections nesting
=========================

By design, the µOS++ critical sections can nest, at any depth.

For this to be possible, the µOS++ critical sections implementation is based on using the stack for storing the interrupts mask:

-   the interrupt mask is pushed onto the stack at **criticalEnter()** and interrupts disabled
-   the interrupt mask is poped from the stack and restored to the system at **criticalExit()**

The implementation is very light, but using the stack has a minor drawback, the flow should be linear and always a a criticalEnter() must be matched by a criticalExit() within the same context; it is not possible to return from within a critical section.

Task priorities
===============

µOS++ uses a static priority mechanism. Static does not mean the values are set at build time, but that once **setPriority()** is called for a task, the importance of this value when the scheduler determines the order of the tasks, is static, i.e. is not influenced by other conditions, like the processor load, time waiting, time running, and other such values. In other words, the actual priority does not vary according to other parameters, but it is always equal to the static priority.

The task priority is used only in one place, in the scheduler code used to insert tasks in the running list. This code guarantees that any newly inserted task with a priority higher than any existing task in the list, will always be in the top of the list.

If tasks with higher priorities are already in the list, the new task will be inserted after all tasks with higher priority and before all tasks with lower priorities.

A special case occurs when one or several tasks with identical priorities are already in the list, and in this case, to satisfy the round-robin policy, the task is inserted after the last task with identical priority and before any tasks with lower priorities.

Usually the task priority is set when the task constructor is called and does not change durring the task lifetime, but µOS++ does not impose any restrictions for setting the priorities, and **setPriority()** can be called at any time. However, when changing the priorities on the fly, the usual precautions should be be taken to avoid scheduling problems.

Obviously any application may have unique requirements, and µOS++ can be tuned to meet most of them, but in order to avid problems, the first approach would be to start with all tasks using the default priority, and adjust if needed.

Priority inversion
==================

When sharing resources between tasks with different priorities, one special case that should always be considered, is avoiding [priority inversions](http://en.wikipedia.org/wiki/Priority_inversion).

In order to avoid additional complexity, special solutions like priority ceiling or priority inheritance are currently not included in the OSMutex implementation, but support for dynamically changing task priorities is available, so custom versions of any synchronised object can always be added, if needed.

Strategies for reordering the active tasks list
===============================================

As mentioned before, the scheduler maintains a list of all active tasks, and each time a context switch is performed, the top priority task is selected for execution.

There might be many possible strategies regarding when to do these operations, but we considered only the following:

-   always insert tasks at the end of the list and when the context switch is performed, enumerate the list and determine the task with the highest priority
-   always keep the list of active tasks ordered, and when the context switch is performed just peek the top of the list

In the first strategy, inserting tasks to the list is extremely fast, but determining the top priority task requires a complete list enumeration.

In the second strategy, inserting in an ordered structure is more expensive, but determining the top priority task is extremely light.

For a better decision, it should be noted that determining the top priority task is done at each and every context switch, while inserting taks in the active list is done when notifying events and when performing the round-robin algorithm. Also to be noted that for the round robin algorithm, the task is inserted close to the end of the list.

Given the current µOS++ implementation and case usage, we considered that the second strategy is more appropriate. However alternate strategies might be considered for future implementations.

Strategies for implementing the active task list
================================================

Assuming that most of the time tasks are in waiting mode, it is expected that the active list is usually short, most of the time with a single entry, the Idle task.

For very short lists, one of the most efficient implementations is a simple array. Given the µOS++ case usage, the most frequent operations are reinserting the current task before the last element of the list and getting the top of the list, and both operations are quite fast on short arrays. However alternate strategies might be considered for future implementations.

Task interruption/cancellation
==============================

In real life applications, there are certain cases when due to special conditions, some tasks, otherwise perfectly functioning, should be cancelled.

µOS++ tasks include support for interruption, but this support is cooperative, i.e. tasks that might be interrupted should check for interruption requests and quit inner loops in an ordered manner.

Things are complicated by the fact that tasks may be waiting for events that no longer occur, so the scheduler should artificially notify tasks to force them return from eventWait(). Even worse, these notifications should be repeated until the task positively acknowledges that it reached a stable status.

TODO: write a detailed explanation of the mechanism on a separate page

Methods overview
================

TODO: this sections needs to be updated, content moved to the API section and here only a short summary kept.

Starting methods
----------------

    void start(void);

Enable the scheduler to run and start the task with the highest priority. This function is automatically called in the default **main()** function, called after all static constructors were executed.

    bool isRunning(void);

Return true if the the scheduler was started. Please note that once started, the scheduler cannot be stopped, so this function will return false before **main()** (i.e. while running static constructors) and true after **main()**.

Locking methods
---------------

    void lock(void);

Lock the scheduler to the current task, i.e. do not allow the scheduler to switch to another task. Please note that interrupts are not affected, the interrupt service routines will be executed normally and event notifications might wakeup tasks with higher priorities, but switching to another task will be permited only after **unlock()**. While locked, **yield()** will immediately return to the same task, and **eventWait()** will immediately return with OSEventWaitReturn::OS_LOCKED.

    void unlock(void);

Unlock the scheduler, so at the next rescheduling moment another task might get the CPU.

    bool isLocked(void);

Return true if the scheduler is locked.

    void setLock(bool flag);

Lock the scheduler if the flag is true, unlock otherwise.

Preemption methods
------------------

    bool isPreemptive(void);

Return true if the scheduler runs in preemptive mode.

    void setPreemptive(bool flag);

Set the scheduler to run in cooperative mode if flag is false, set to preemptive mode if flag is true (default).

Task management methods
-----------------------

    OSTask *getTaskCurrent(void);

Return a pointer to the task currently running on the CPU.

    OSTask *getTaskIdle(void);

Return a pointer to the Idle task.

    int getTasksCount(void);

Return the number of tasks registered to the scheduler.

    OSTask *getTask(int i);

Return the i-th task registered to the scheduler, or **OS_TASK_NONE** for illegal index.

System critical section methods
-------------------------------

    void criticalEnter(void);

Enter a critical section, i.e. a section where interrupts are not allowed. It is mandatory to be braced by a **criticalExit()**, failure to do so leads to unexpected results. The usual implementations save the current status of the interrupt flag and disable interrupts.

    void criticalExit(void);

Exit critical section. Usual implementations restore the interrupt flag to the value saved by **criticalEnter()**.

Yield method
------------

    void yield(void);

Suspend the current task and reschedule the CPU to the next task.

* * * * *

Examples
========

Althoght most of the scheduler methods are static, for both portability and aestetic reasons, the recommended way to call them in application code is by prefixing with **os.sched.** like **os.sched.yield();**. However, in system code it is recommended to avoid references to application objects like **os.** so calls are to be written like **OSScheduler::yield()**.

Using application critical sections
-----------------------------------

    // ...
    os.sched.lock();
      {
        // ...
        // ...
      }
    os.sched.unlock();
    // ...

Application critical sections are required for syncronization events triggered by other application tasks. The braced code is guaranteed to be executed atomically within the current task, without sharing the CPU with other tasks. However interrupts remain active and interrupts services routines are normally executed; for synchronization events triggered by interrupts please use system critical sections.

Using system critical sections
------------------------------

    // ...
    os.sched.criticalEnter();
      {
        // ...
        // ...
      }
    os.sched.criticalExit();
    // ...

System critical sections are required for syncronization events triggered by interrupt service routines. The braced code is guaranteed to be executed atomically with interrupts disabled. Should be used with caution, since long critical sections may degrade system performance.

Enumerating registered tasks
----------------------------

    // ...
    os.sched.lock();
      {
        int i;
        for (i = 0; i < os.sched.getTasksCount(); ++i)
          {
            OSTask *pTask;
            pTask = os.sched.getTask(i);

            if (os.isDebug())
              clog << (*pTask);    // dump task data on debug device

            // ...
          }
      }
    os.sched.unlock();
    // ...

Enumerate all registered tasks, including the idle task.
