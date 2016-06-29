---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSTimerSeconds/
title: Class OSTimerSeconds
author: Liviu Ionescu

date: 2011-02-16 13:06:56 +0000

---

[OSTimer]({{ site.baseurl }}/micro-os-plus/i/Class_OSTimer "wikilink")


OSTimerSeconds

This class requires the definition of **OS_INCLUDE_OSSCHEDULER_TIMERSECONDS**.

For systems equipped with a Real Time Clock (and **OS_INCLUDE_32KHZ_TIMER** defined), this timer runs completely independently, even when the device is in sleep or deep sleep mode. For systems not equipped with a RTC (and **OS_INCLUDE_32KHZ_TIMER** not defined), this time is derived from the existing OSTimerTicks.

Constructors
============

OSTimerSeconds()
----------------

**Description**


Initializes the internal members.

**Parameters**

:\* none

Methods
=======

static [OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") getSchedulerTicks(void)
----------------------------------------------------------------------------------

**Description**


Return the current number of ticks within the current second.

**Parameters**

:\* none

**Return value**

:\* n - the number of ticks

void interruptServiceRoutine(void)
----------------------------------

**Description**


Interrupt service routine called each second.

**Parameters**

:\* none

**Return value**

:\* none

static void incrementUptime(void)
---------------------------------

**Description**


Increment the current seconds number. It requires definition of OS_INCLUDE_OSTIMERSECONDS_UPTIME.

**Parameters**

:\* none

**Return value**

:\* none

static unsigned long getUptime(void)
------------------------------------

**Description**


Return the current seconds number. It requires definition of OS_INCLUDE_OSTIMERSECONDS_UPTIME.

**Parameters**

:\* none

**Return value**

:\* n - current number of seconds

static void checkVirtualWatchdogs(void)
---------------------------------------

**Description**


Check for every task if the software watchdog (counter) expired. If any software watchdog expired, the CPU is forced to be restarted by the hardware watchdog. It is periodically called in the OSTimerSeconds::interruptServiceRoutine. It requires definition of OS_INCLUDE_OSTASK_VIRTUALWATCHDOG.

**Parameters**

:\* none

**Return value**

:\* none

Variables
=========

static [OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") ms_schedulerTicks
-----------------------------------------------------------------------------

**Description**


The number of OS ticks within current second.
