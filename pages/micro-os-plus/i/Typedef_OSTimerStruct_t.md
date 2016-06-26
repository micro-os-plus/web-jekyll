---
layout: old-wiki-page
permalink: /micro-os-plus/i/Typedef_OSTimerStruct_t/
title: Typedef OSTimerStruct t
author: Liviu Ionescu

date: 2011-02-17 13:05:20 +0000

---

Structure used in OSTimer for storing a timeout, after which an event is notified.

Members
=======

OSTimerTicks_t ticks
---------------------


Store the actual interval, after which the event is notified.

OSEvent_t event
----------------


The event which is notified.

union u
-------

### OSEventWaitReturn_t ret


The return value of the event.

### [Timer]({{ site.baseurl }}/micro-os-plus/i/Class_Timer "wikilink") \*pTimer


Pointer to an advanced timer used to extend the capabilities of the OSTimer. Using this member the timeout could be set as periodic, or even a custom one.

