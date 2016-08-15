---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_Timer/
title: Class Timer
author: Liviu Ionescu

date: 2011-02-21 11:59:34 +0000

---

Timer

Constructors
============

Timer()
-------

**Description**


Initialize the internal members.

**Parameters**

:\* none

Destructor
==========

virtual \~Timer()
-----------------

**Description**


Destroy the custom timer.

Methods
=======

== void start([OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") ticks, bool periodic=false) == **Description**


Start the timer to trigger an event after the given number of ticks. If periodic is true, the event will periodically be triggered.

**Parameters**

:\* ticks - input, the number of ticks after which the event is triggered

:\* periodic - input, if true the event will periodically be triggered

**Return value**

:\* none

void stop()
-----------

**Description**


Stop a periodic timer after the pending event is completed, i.e. do not reschedule another event. The number of ticks will be set to zero and periodic to false.

**Parameters**

:\* none

**Return value**

:\* none

== void cancel([OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") ret=OSEventWaitReturn::OS_CANCELED) == **Description**


Cancel the pending event, by notifying it with the given return value.

**Parameters**

:\* ret - input, the event wait return value, used for notifying the pending event

**Return value**

:\* none

== void eventSet([OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEvent_t "wikilink") event, [OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") ret=OSEventWaitReturn::OS_VOID) == **Description**


Set the event, which is going to be triggered by the timer, and the return value.

**Parameters**

:\* event - input, the event which is going to be set

:\* ret - input, the return value which is transmitted to the event

**Return value**

:\* none

[OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") eventWait(void)
-------------------------------------------------------------------------------

**Description**


Wait for the trigger event to occur.

**Parameters**

:\* none

**Return value**

:\* event return value

bool isPeriodic()
-----------------

**Description**


Return true if the timer is set to periodic mode.

**Parameters**

:\* none

**Return value**

:\* true if the timer is periodic

[OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") getTicksStart()
---------------------------------------------------------------------

**Description**


Return the number of ticks set by start(). If the timer is stopped, the returned value is zero.

**Parameters**

:\* none

**Return value**

:\* the number of ticks set by start

[OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") getTicks()
----------------------------------------------------------------

**Description**


Return the current ticks counter of the associated timer.

**Parameters**

:\* none

**Return value**

:\* the current number of ticks

virtual void timerEvent(void)
-----------------------------

**Description**


This is the callback invoked by the timer interrupt. The default action is notify the event programmed by eventSet().

**Parameters**

:\* none

**Return value**

:\* none
