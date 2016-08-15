---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/History/
title: History
author: Liviu Ionescu

date: 2010-11-10 14:06:59 +0000

---

The Beginning
-------------

Work on the µOS++ started by the end of 2006, when I decided to upgrade the Flight Data Recorder and 'Glue Avionics' used in my light airplane. (CAN devices, currently based on multiple old PIC 16F877 microcontrollers, developped during 2002).

The decision for C++ came quite early and was a tough one. During the initial phase I studied several other implementations (like µC/OS-II, FreeRTOS, eCos). An in-deep previous experience with eCos reminded me that C++ was used in embedded systems, but eCos was from the *big-boys ligue*, and I was under the common misconception that C++ cannot be used for small embedded projects.

A 'contributing factor' was reading Michael Barr's "Programming Embedded Systems in C and C++" (O'Reillly 1999, ISBN 1-56592-354-5); his approach looked reasonable, his code looked quite readable and well structured, and by the end of the book I also discovered a referrence to the Embedded C++ Standard, so I decided there are enough reasons to give it a try. The main concerns were related to GCC C++ readiness for embedded projects, both from the code generation point of view and from the run-time support. After extensive tests with AVR-GCC it looked like none of these concerns were real, AVR-GCC had full support to compile C++ and the heavy run-time features (exceptions, dynamic object allocation, etc) can be disabled.

The only inconvenient I found was that Atmel AVR Studio had no support for C++; since I already used Eclipse for other Java projects, with good results, the decision for Eclipse CDT (C Development Tools) was natural.

I am aware that the decision to go for C++ might be a discouraging factor in the adoption of µOS++, but I think the inherent modularity of the C++ code that leads to a much better discipline in writing code than in C, can be translated into a better maintenability and finally in lowering the TCO.

The first version was µOS++ was functional in the spring of 2007, running on the Atmel STK525 development board, using an AVR at90usb1287 microcontroller. Development went to the point when I could run multiple shell instances, with I/O via USB CDC and USART, and read data blocks from MMC/SD cards, so I was able to download data from my Flight Recorder storage via USB, at much higher speed than by previous serial link.

Discussions with colleagues and friends led me to the conclussion that µOS++ might be of interest for others too, so in April 2007 the full source code tree of the project was published on SourceForge.

July 2007
---------

µOS++ was also ported on a board running with Atmel AVR atmega324p and used to build commercial SDI-12 sensors.

v1.2 - September 2007
---------------------

Once the requirements of running on multiple boards and processors were obvious and easier to test, the code was restructured to increase portability and portable stubs were added in the hal to include specific code.

Synchronization mechanisms were expanded with **OSFlags**. In order to allow timers to interract with any synchronization objects, the functionality of the timers was increased; in addition to standard sleep(), timers notify standard events and can be expanded by the application to invoke a customized callback via the **Timer** class.

v2.0 - March 2008
-----------------

A major code restructuring and cleanup, done after the first commercial/production grade products based on it were released. Two SDI-12 sensors were built using µOS++, each including a bootloader allowing full remote upgrade via X commands over the SDI-12 bus.

v3.0 - June 2009
----------------

The first port on a different microprocessor architecture, the ARM Cortex M3, with code restructuring and cleanup for the core scheduler. The implementation fully supports the specific features, like pending exceptions used to simplify context switches triggered by interrupts.
