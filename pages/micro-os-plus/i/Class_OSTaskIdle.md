---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSTaskIdle/
title: Class OSTaskIdle
author: Liviu Ionescu

date: 2011-02-16 16:26:10 +0000

---

OSTaskIdle

Constructors
============

OSTaskIdle(void)
----------------

**Description**


Initialize the task object. The function executed by this task is set to the taskMain.

**Parameters**

:\* none

**Return value**

:\* none

Methods
=======

virtual void taskMain(void)
---------------------------

**Description**


Main function task. If this function run, it means that no other task needs the MCU. It will try to put the MCU to sleep. After that (when the MCU is waked up) a yield is made to give the control to other task, if there is another task which in the meantime needs the MCU.

**Parameters**

:\* none

**Return value**

:\* none

virtual bool enterSleep(void)
-----------------------------

**Description**


Check if the MCU can be put at sleep. If the sleep is allowed put the MCU to sleep.

**Parameters**

:\* none

**Return value**

:\* true if the MCU can be put to sleep, false otherwise
