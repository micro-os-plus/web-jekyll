---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSTimerTicks/
title: Class OSTimerTicks
author: Liviu Ionescu

date: 2011-02-16 12:48:18 +0000

---

[OSTimer]({{ site.baseurl }}/micro-os-plus/i/Class_OSTimer "wikilink")


OSTimerTicks

Constructors
============

OSTimerTicks()
--------------

**Description**


Initialize the internal members.

**Parameters**

:\* none

Methods
=======

static [OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks "wikilink") microsToTicks(unsigned short micros)
-----------------------------------------------------------------------------------------------

**Description**


Transform the microseconds number into ticks number. However two issues should be considered: first, the result is approximative, the higher the tick rate the better the approximation, and second, the result should fit the range of OSTimerTicks_t, otherwise results are erroneous. To increase precission it is recommended to define the parameter of this macro as long (by using the L suffix, like 15000L).

**Parameters**

:\* micros - input, the number of msecs

**Return value**

:\* n - the number of ticks

void interruptServiceRoutine(void)
----------------------------------

**Description**


This interrupt service routine is called each time a tick expire; it increments the current ticks number, and calls the OSTimer::interruptTick.

**Parameters**

:\* none

**Return value**

:\* none

Variables
=========