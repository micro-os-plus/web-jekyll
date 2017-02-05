---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSEventFlags/
title: Class OSEventFlags
author: Liviu Ionescu

date: 2011-02-25 13:06:54 +0000

---

OSEventFlags

The class OSEventFlags requires the definition of **OS_INCLUDE_OSEVENTFLAGS**.

Constructors
============

OSEventFlags()
--------------

**Description**


Initialize the internal members.

**Parameters**

:\* none

Methods
=======

[OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t) notify([OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t) bits)
----------------------------------------------------------------------------------------------------------------------------------------

**Description**


Set bits and send an internally identified event. Return the new flags.

**Parameters**

:\* bits - input, the mask of flags which must be set

**Return value**

:\* the new flags

[OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t) get(void)
-----------------------------------------------------------------------

**Description**


Return the current flags value.

**Parameters**

:\* none

**Return value**

:\* the current flags value

[OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t) clear([OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t) bits)
---------------------------------------------------------------------------------------------------------------------------------------

**Description**


Clear the given flags.

**Parameters**

:\* bits - input, the flags which must be cleared

**Return value**

:\* the new flags

== [OSReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSReturn_t) wait([OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t) bits, bool isStrict = true) == **Description**


Loop until one the requested bits are set. If isStrict is true all the requested bits must be set, in order to return. If isStrict is false just one of the requested bits must be set, in order to return. If any flag is already set, return immediately (with code OSReturn::OS_IMMEDIATELY). For timeouts please set timers to send events; this function will return the timer event.

**Parameters**

:\* bits - input, the mask of bits which is waiting for

:\* isStrict - input, specifies is all bits or just one bit must be waited for

**Return value**

:\* OSReturn::OS_IMMEDIATELY - code returned if any flag is already set

:\* OSReturn::OS_OK - code returned if the requested bits were set

[OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEvent_t) getEvent(void)
----------------------------------------------------------

**Description**


Return the event used for notification.

**Parameters**

:\* none

**Return value**

:\* the event used for notification

Variables
=========
