---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSMutex/
title: Class OSMutex
author: Liviu Ionescu

date: 2011-03-10 10:20:04 +0000

---

OSMutex

The mechanism implemented by this class is tested by the project [mutexStress]({{ site.baseurl }}/micro-os-plus/i/Sample_Mutex_Stress "wikilink").

Constructors
============

OSMutex()
---------

**Description**


Initialize the internal members.

**Parameters**

:\* none

Methods
=======

== int acquire(bool doNotBlock = false) == **Description**


Try to acquire mutex. If doNotBlock is false, the task is blocked (using eventWait) until this mutex is released, by other task.

**Parameters**

:\* doNotBlock - input, if it is false, the task is blocked until this mutex is released

**Return value**

:\* OK - ok, this mutex is successfully acquired

:\* ERROR_EVENT- error, the event failed in waiting for this mutex to become available

:\* ERROR_WOULD_BLOCK - error, the mutex is already acquired and noBlock is true

== int release([OSTask]({{ site.baseurl }}/micro-os-plus/i/Class_OSTask "wikilink") \* pTask = 0) == **Description**


Release owned mutex.

**Parameters**

:\* pTask - input, the task which should own the mutex

**Return value**

:\* OK - ok, this mutex is successfully released

:\* ERROR_NOT_OWNER - error, the pTask, input parameter, is not the task which acquired the mutex

:\* ERROR_NOT_ACQUIRED - error, this mutex is not acquired

[OSTask]({{ site.baseurl }}/micro-os-plus/i/Class_OSTask "wikilink") \* getOwnerTask(void);
---------------------------------------------------------

**Description**


Return the task owner of the mutex.

**Parameters**

:\* none

**Return value**

:\* the (pointer to) the task which owns the mutex

[OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Type_OSEvent_t "wikilink") getEvent(void);
--------------------------------------------------------

**Description**


Return the event used for notification the acquire and release of the mutex.

**Parameters**

:\* none

**Return value**

:\* the event used for notification the acquire and release of the mutex

void setEvent([OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Type_OSEvent_t "wikilink") event)
-------------------------------------------------------------

**Description**


Set the given event used for notification the acquire and release of the mutex.

**Parameters**

:\* event - input, the event

**Return value**

:\* none

[OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") getEventReturn(void)
------------------------------------------------------------------------------------

**Description**


Return the event return value used for notification.

**Parameters**

:\* none

**Return value**

:\* the event return value used for notification

Variables
=========

== static const int OS_OK = 1== == static const int OS_NOT_OWNER = -1== == static const int OS_NOT_ACQUIRED = -2== == static const int OS_OTHER_EVENT = -3 == == static const int OS_WOULD_BLOCK = -4== **Description**


All are used as result code for acquire and release methods.
