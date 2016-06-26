---
layout: old-wiki-page
permalink: /micro-os-plus/i/Classes_overview/
title: Classes overview
author: Liviu Ionescu

date: 2011-03-08 23:38:17 +0000

---

Core classes
============

OSCPU
-----

The class [OSCPU]({{ site.baseurl }}/micro-os-plus/i/Class_OSCPU "wikilink") groups all CPU related calls and functionality. Here should be defined all CPU specifics, like

OSCPUImpl
---------

The [OSCPUImpl]({{ site.baseurl }}/micro-os-plus/i/Class_OSCPUImpl "wikilink") class is a portability helper for the **OSCPU** class.

Here are defined the non-portable methods, specific to each architecture or family.

OS
--

Without having any specific functionality, the [OS]({{ site.baseurl }}/micro-os-plus/i/Class_OS "wikilink") class is a placeholder for all µOS++ related members and methods that did not find their way in other classes.

The non-portable methods are based on the **OSImpl** class, where the actual implementation is defined.

OSImpl
------

The [OSImpl]({{ site.baseurl }}/micro-os-plus/i/Class_OSImpl "wikilink") class is a portability helper for the **OS** class.

Here are defined the non-portable methods, specific to each architecture or family.

OSScheduler
-----------

The [OSScheduler]({{ site.baseurl }}/micro-os-plus/i/Class_OSScheduler "wikilink") class implements the main µOS++ functionality, i.e. the preemptive scheduler.

The non portable methods are based on the **OSSchedulerImpl** class, where the actual implementation is defined.

OSSchedulerImpl
---------------

The [OSSchedulerImpl]({{ site.baseurl }}/micro-os-plus/i/Class_OSSchedulerImpl "wikilink") class is a portability helper for the **OSScheduler** class.

Here are defined the non-portable methods, specific to each architecture or family.

OSTask
------

The [OSTask]({{ site.baseurl }}/micro-os-plus/i/Class_OSTask "wikilink") class is the parent class for all tasks running in the µOS++ environment.

OSTaskIdle
----------

The [OSTaskIdle]({{ site.baseurl }}/micro-os-plus/i/Class_OSTaskIdle "wikilink") class is the implementation of the µOS++ idle task, i.e. the lowest priority task that gets control when no other task is running.

It has several functionalities:

-   to make the processor enter the idle mode, waiting for the next interrupt
-   to execute a yield(), to guarantee that tasks that were waken by non-rescheduling interrupts are scheduled for execution

OSTimer
-------

The [OSTimer]({{ site.baseurl }}/micro-os-plus/i/Class_OSTimer "wikilink") class is the parent class of all system timer classes.

OSTimerTicks
------------

The [OSTimerTicks]({{ site.baseurl }}/micro-os-plus/i/Class_OSTimerTicks "wikilink") class implements the main timer functionality in µOS++.

As the name implies, all timing intervals of this timer are expressed in ticks, more precisely in scheduler ticks.

OSTimerSeconds
--------------

The [OSTimerSeconds]({{ site.baseurl }}/micro-os-plus/i/Class_OSTimerSeconds "wikilink") class implements the second system timer functionality, intended to measure longer intervals.

As the name implies, all timing intervals of this timer are expressed in seconds.

For systems equipped with a Real Time Clock, this timer runs completely independently, even when the device is in sleep or deep sleep mode.

For systems not equipped with a RTC, this time is derived from the existing **OSTimerTicks**.

Timer
-----

The [Timer]({{ site.baseurl }}/micro-os-plus/i/Class_Timer "wikilink") class is the parent class of all custom timer classes.

OSMutex
-------

The [OSMutex]({{ site.baseurl }}/micro-os-plus/i/Class_OSMutex "wikilink") class implements a mutual exclusion (mutex) inter-task synchronisation mechanism.

OSEventFlags
------------

The [OSEventFlags]({{ site.baseurl }}/micro-os-plus/i/Class_OSEventFlags "wikilink") class implements an inter-task synchronisation mechanism allowing a task to wait for multiple events, defined as separate flags in a structure.

Device classes
==============

OSDeviceDebug
-------------

The [OSDeviceDebug]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceDebug "wikilink") class is the parent class of all debug classes used for displaying trace messages.

DeviceDebugI2C
--------------

The [DeviceDebugI2C]({{ site.baseurl }}/micro-os-plus/i/Class_DeviceDebugI2C "wikilink") class is the implementation of **OSDeviceDebug** where the output device is implemented as a master I2C using two generic IP pins via bit-banging.

The main advantage of such a mechanism is independence from processor speed and from specific hardware.

OSDeviceCharacter
-----------------

The [OSDeviceCharacter]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceCharacter "wikilink") class is the parent class of all character devices in µOS++. A *character* device is defined as a device having the transfer unit as low as one ASCII character.

Example of such devices are USART, CDC USB.

OSDeviceCharacterBuffered
-------------------------

The [OSDeviceCharacterBuffered]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceCharacterBuffered "wikilink") class is derived from OSDeviceCharacter and implements circular buffers for RX and TX.

DeviceCharacterBufferedBase
---------------------------

The [OSDeviceCharacterBufferedBase]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceCharacterBufferedBase "wikilink") class is derived from OSDeviceCharacterBuffered and contain generic implementation for all USART's.

DeviceCharacterBufferedUsart0
-----------------------------

The [OSDeviceCharacterBufferedUsart0]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceCharacterBufferedUsart0 "wikilink") class is derived from OSDeviceCharacterBase and contain specific implementation for USART0.

DeviceCharacterBufferedUsart1
-----------------------------

The [OSDeviceCharacterBufferedUsart1]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceCharacterBufferedUsart1 "wikilink") class is derived from OSDeviceCharacterBase and contain specific implementation for USART1.

Type definitions
================

OSTimerStruct_t
----------------

The [OSTimerStruct_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerStruct_t "wikilink") type definition is used in OSTimer for storing the timeout set for a certain task.

OSTimerTicks_t
---------------

The [OSTimerTicks_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSTimerTicks_t "wikilink") type definition is used in ... (TBD)

OSEventWaitReturn_t
--------------------

The [OSEventWaitReturn_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventWaitReturn_t "wikilink") type definition is used in ... (TBD)

OSEvent_t
----------

The [OSEvent_t]({{ site.baseurl }}/micro-os-plus/i/Type_OSEvent_t "wikilink") type definition is used in ... (TBD)

OSEventFlagsBits_t
-------------------

The [OSEventFlagsBits_t]({{ site.baseurl }}/micro-os-plus/i/Typedef_OSEventFlagsBits_t "wikilink") type definition is used in [OSEventFlags]({{ site.baseurl }}/micro-os-plus/i/Class_OSEventFlags "wikilink") inter-task synchronization.

Classes hierarchy
=================

The class inheritance is depicted with multilevel bulleted lists:

-   Base class
    -   Derived class

Classes from "portable/kernel/include"
--------------------------------------

-   OSCPUImpl
    -   OSCPU
-   OSImpl
    -   OS
-   OSScheduler
-   OSSchedulerImpl
-   OSTask
    -   OSTaskIdle
-   OSTimer
    -   OSTimerTicks
    -   OSTimerSeconds
-   Timer
-   OSMutex
-   OSEventFlags

Classes from "portable/devices/character/include"
-------------------------------------------------

-   OSDeviceDebug (may be optionally derived from streambuf)
-   OSDeviceCharacter (may be optionally derived from streambuf)
    -   OSDeviceCharacterBuffered
        -   DeviceCharacterBufferedUsartBase
            -   DeviceCharacterBufferedUsart0
            -   DeviceCharacterBufferedUsart1
    -   DeviceCharacterUsb

Classes from "portable/devices/usb/include"
-------------------------------------------

-   OSUsbDevice

Classes from "portable/misc/include"
------------------------------------

-   ASCII

-   CircularBlockBuffer

-   CircularByteBuffer

-   Parser

-   SimpleCli
