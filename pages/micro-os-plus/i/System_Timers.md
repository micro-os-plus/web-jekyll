---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/System_Timers/
title: System Timers
author: Liviu Ionescu

date: 2010-11-10 16:19:54 +0000

---

The main function of µOS++ system timers is to schedule the generation of events after a number of ticks.

There are at least two timers, one using scheduler ticks and the other using seconds. The variables used to store ticks should be of type **OSTimerTicks_t**. Usually this is an unsigned short, giving a range of max 65535 ticks. For the timer counting seconds this means about 18 hours, and for the timer counting scheduler ticks, at, let's say, 1000 ticks/second, this means about 65 seconds.

If a hardware 32 KHz oscillator is available, the timer counting seconds will run independently of the scheduler timer, and eventually will run even when the processor is put to a deep sleep. Otherwise the second event is triggered every OS_CFGINT_TICK_RATE_HZ ticks, which, due to roundings when setting the registers of the hardware timer, might be slightly inacurate.

The two timers are static members of the **os.sched** object and the recommended way to access them is:

    os.sched.timerTicks
    os.sched.timerSeconds

Please note that the seconds timer is optional. To include it in the build please add the following line to the system configuration header:

    #define OS_INCLUDE_OSSCHEDULER_TIMERSECONDS                1

Since specifying scheduler ticks might not be as intuitive as usual time units, the following macro was defined in OS.h and can be used whenever needed. However two issues should be considered: first, the result is aproximative, the higher the tick rate the better the approximation, and second, the result should fit the range of **OSTimerTicks_t**, otherwise results are erroneous. To increase precission it is recommended to define the parameter of this macro as long (by using the L suffix, like 15000L).

    #define OS_MICROS_TO_TICKS(x) (((x)+(OS_CFGINT_TICK_RATE_HZ-1))/OS_CFGINT_TICK_RATE_HZ)

If the above excessive rounding is not necessarry, the user can always define and use a customized version of this macro.

Methods
-------

### Sleep method

    OSEventWaitReturn_t sleep(OSTimerTicks_t ticks);

Put the current task to sleep for the number of ticks. A value of 1 means 'next' tick, so it might be less than one full tick.

Return: OS_EVENT_WAIT_RETURN_VOID if the call ended normally, or the value notified by eventNotify().

### Event methods

    void eventNotify(OSTimerTicks_t ticks, OSEvent_t event, OSEventWaitReturn_t ret);

Schedule a notification after a number of ticks. It is functionally equivalent with os.sched.eventNotify(event, ret) executed exactly after the given number of ticks.

    int eventRemove(OSEvent_t event);

Remove all notifications scheduled for the given event, regardless the task that issued them. Usefull when a timeout is set and the expected event occurs, making the timeout useless or even harmfull.

Return: the number of notifications removed.

### Get Ticks method

    OSTimerTicks_t getTicks(void);

Return the current value of the ticks counter. Ticks are automatically counted by the interrupt service routine. Due to the nature of unsigned arithmetic, you can safely compute the duration of an operation by subtracting the counter at the begining of the operation from the counter at the end of the operation, as long as the duration is not higher than the max range of the OSTimerTicks_t (usually an unsigned short).

* * * * *

Examples
--------

    // ...
    os.sched.timerTicks.sleep(OS_MICROS_TO_TICKS(15000L)); // 15 ms
    // ...

Put the current task to sleep for 15 miliseconds.

    // ...
    os.sched.timerSeconds.sleep(3); // 3 sec
    // ...

Put the current task to sleep for 3 seconds.

    // ...
    OSEventWaitReturn_t startSeconds;
    startTicks = os.sched.timerSeconds.getTicks();
      {
        // ...
      }
    OSEventWaitReturn_t durationSeconds;
    durationSeconds = os.sched.timerSeconds.getTicks() - startSeconds;
    // ...

Compute the duration in seconds of a block of code.

    // ...
    OSEvent_t event;
    event = ...;
    os.sched.timerTicks.eventNotify(OS_MICROS_TO_TICKS(25000L), event, OS_EVENT_WAIT_RETURN_TIMEOUT);
    OSEventWaitReturn_t ret;
    ret = os.sched.eventWait(event);
    if (ret != OS_EVENT_WAIT_RETURN_TIMEOUT)
      os.sched.timerTicks.eventRemove(event);
    // ...

Add a 25 miliseconds timeout to an **eventWait()**.
