---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Advanced_(Custom)_Timers/
title: Advanced (Custom) Timers
author: Liviu Ionescu

date: 2011-02-13 15:09:30 +0000

---

In addition to system timers functionality, µOS++ custom timers can provide:

-   periodic timers
-   custom actions

µOS++ custom timers are objects that must be defined by the application. The constructor should specify the system timer to be used.

Custom actions can be defined by overriding the callback used by the timer (the **timerEvent()** method).

* * * * *

Constructor
-----------

    Timer(OSTimer *pTimer);

Construct the timer based on a pointer to a system timer.

Methods
-------

    void start(OSTimerTicks_t ticks, bool periodic=false);

Start the timer to trigger an event after the given number of ticks. If periodic is true, the event will periodically be triggered.

    void stop();

Stop a periodic timer after the pending event is completed, i.e. do not reschedule another event. The number of ticks will be set to zero and periodic to false.

    void cancel(OSEventWaitReturn_t ret=OSEventWaitReturn::OS_CANCELED);

Cancel the pending event, by notifying it with the given return value.

    void eventSet(OSEvent_t event, OSEventWaitReturn_t ret=OSEventWaitReturn::OS_VOID);

Set the event to be triggered by the timer and the return value.

    OSEventWaitReturn_t eventWait(void);

Wait for the trigger event to occur.

    bool isPeriodic();

Return true if the timer is set to periodic mode.

    OSTimerTicks_t getTicksStart();

Return the number of ticks set by start(). If the timer is stopped, the returned value is zero.

    OSTimerTicks_t getTicks();

Return the current ticks counter of the associated timer.

    // callback
    virtual void timerEvent(void);

This is the callback invoked by the timer interrupt. The default action is notify the event programmed by eventSet().

* * * * *

Examples
--------

### Periodic Timer

    //...
    Timer myTimerSeconds(&os.sched.timerSeconds);
    //...

    void TaskBlink::taskMain(void)
      {
        //...
        myTimerSeconds.eventSet((OSEvent_t)this); // set event on this task
        myTimerSeconds.start(m_rate, true);       //start periodic timer

        // task endless loop
        for (;;)
          {
            myTimerSeconds.eventWait();
            if (os.isDebug())
              {
                debug.putChar('.');
              }
          }
      }

The advanced timer is created with a reference to the system timer counting seconds. The event associated with this timer is the current task pointer. Later the timer is started with a given number of seconds as rate and the periodic flag set to true. The efect is that the timer will continuously trigger an event every 'rate' seconds.

### Custom Action Timer

    class myTimer : public Timer
      {
    public:
        myTimer();
        virtual ~myTimer();
        virtual void timerEvent(void);
      };


    myTimer::myTimer() : Timer(&os.sched.timerSeconds)
      {
        ;
      }

    myTimer::~myTimer()
      {
        ;
      }

    void myTimer::timerEvent(void)
      {
        if (os.isDebug())
          {
            debug.putChar('.');
          }
      }

A custom timer is defined based on the advanced timer that references the system timer counting seconds. The **timerEvent()** method is overriden with a custom version that displays a dot on the debug device.
