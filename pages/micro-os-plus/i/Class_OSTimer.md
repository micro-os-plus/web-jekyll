---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSTimer/
title: Class OSTimer
author: Liviu Ionescu

date: 2011-02-16 12:47:57 +0000

---

OSTimer

Constructors
============

OSTimer([OSTimerStruct_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerStruct_t "wikilink") \*pArray, int size)
-----------------------------------------------------------------------------------

**Description**


Initialize the internal members with the given array.

**Parameters**

:\* \*pArray - input, the array of timeouts which are going to be used

:\* size - input, the size of pArray

Methods
=======

==[OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") sleep([OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") ticks, [OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEvent_t "wikilink") event = 0)== **Description**


Put a task to sleep for the given number of ticks. If the given event is not null, when the timeout expires, it is notified. Else the task is resumed.

**Parameters**

:\* ticks - input, the number of ticks while the current task is put to sleep

:\* event - input, the event which should be notified when the sleep expires, if present and not null

**Return value**

:\* OSEventWaitReturn::OS_VOID - if normal execution

:\* OSEventWaitReturn::OS_IMMEDIATELY - if no sleep is required (ticks input parameter is null)

void eventNotify([OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") ticks, [OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEvent_t "wikilink") event,[OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") ret)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Description**


Schedule the timer to notify the event after the number of ticks. If the event is OSEvent::OS_CUSTOM_TIMER, the ret value is the address of the custom timer.

**Parameters**

:\* ticks - input, the number of ticks after which the event is notified

:\* event - input, the event which is notified when the ticks expires

:\* ret - input, it is the address of the custom timer; used only if the event is OSEvent::OS_CUSTOM_TIMER

**Return value**

:\* none

int eventRemove([OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEvent_t "wikilink") event)
------------------------------------------------------------------

**Description**


Remove the scheduled timer notifications associated with the given event.

**Parameters**

:\* event - input, the event which is associated with the scheduled timer notifications

**Return value**

:\* n - the number of removed scheduled timer notifications

[OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") getTicks(void)
--------------------------------------------------------------------

**Description**


Return the current number of ticks.

**Parameters**

:\* none

**Return value**

:\* n - the current number of ticks

int getCount(void)
------------------

**Description**


Return the number of scheduled timers.

**Parameters**

:\* none

**Return value**

:\* n - the current number of scheduled timers

void interruptTick(void)
------------------------

**Description**


Update and notify the scheduled time events. It is called from the interrupt routine.

**Parameters**

:\* none.

**Return value**

:\* none

void incrementTicks(void)
-------------------------

**Description**


Update the current ticks number. This function is called from the interrupt routine.

**Parameters**

:\* none

**Return value**

:\* none

Variables
=========
