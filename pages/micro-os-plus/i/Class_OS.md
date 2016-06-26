---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OS/
title: Class OS
author: Liviu Ionescu

date: 2011-02-21 13:10:45 +0000

---

OS

Constructors
============

OS(void)
--------

**Description**


Constructor for this class.

**Parameters**

:\* none

**Return value**

:\* none

Methods
=======

static void nakedEarlyInit(void)
--------------------------------

**Description**


Naked version for the earlyInit function. It requires definition of OS_INCLUDE_NAKED_INIT.

**Parameters**

:\* none

**Return value**

:\* none

static void earlyInit(void)
---------------------------

**Description**


Performs early initialisations. Must be called before all constructors.

**Parameters**

:\* none

**Return value**

:\* none

inline static bool isDebug()
----------------------------

**Description**


Return true if debug is active, false otherwise.

**Parameters**

:\* none

**Return value**

:\* true if debug is active, false otherwise

static void busyWaitMillis(unsigned int n)
------------------------------------------

**Description**


Busy waiting for n milliseconds. It requires definition of OS_INCLUDE_OS_BUSYWAITMILLIS.

**Parameters**

:\* n - number of milliseconds to wait for

**Return value**

:\* none

static void busyWaitMicros(unsigned int n)
------------------------------------------

**Description**


Busy waiting for n microseconds. It requires definition of OS_INCLUDE_OS_BUSYWAITMICROS.

**Parameters**

:\* n - number of microseconds to wait for

**Return value**

:\* none

static OSResetBits_t getResetBits(void)
----------------------------------------

**Description**


Return the reset bits status, used to know the reset reason.

**Parameters**

:\* none

**Return value**

:\* the reset bits status

Variables
=========

OSScheduler sched
-----------------

**Description**


Scheduler object used by this class.

