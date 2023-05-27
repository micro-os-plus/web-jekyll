---
layout: page
lang: en
permalink: /cmsis-plus/
title: APIs
author: Liviu Ionescu

date: 2016-03-09 12:04:00 +0300

---

## Overview

The µOS++ APIs implement a portable, vendor-independent hardware abstraction
layer intended for embedded applications, but designed with special
consideration for the industry standard ARM Cortex-M processor series.

## Components

The µOS++ components are:

* **µOS++ Core** - C++ API and implementation for the Cortex-M processors core and peripherals;
* **µOS++ Startup** - portable C/C++ API and implementation for the processor startup code, replacing non-portable vendor assembly code;
* [**µOS++ RTOS APIs**]({{ site.baseurl }}/cmsis-plus/rtos/) - a collection of C++ and C APIs for Real-Time operating systems, based on a POSIX inspired C++ layer;
* **µOS++ ISO Standard Threads** - an implementation of the **C++ Standard ISO/IEC 14882:2011(E)** Thread library, on top of the µOS++ RTOS threads;
* **µOS++ Drivers** - defines generic peripheral driver interfaces for middleware making it reusable across supported devices
* **µOS++ POSIX I/O** - a compatibility layer bringing together access to terminal devices, files and sockets, via a unified and standard API;
* **µOS++ Diagnostics** - a C++/C API providing support for diagnostics and instrumentation.

## Portability

Although designed with both the 32-bits Cortex-M architectures and the
`arm-none-eabi-gcc` compiler in mind, most µOS++ components are highly
portable and can be compiled with any ISO C++ 11 compiler for other
platforms too, for example the µOS++ RTOS can run on 64-bits Intel
based POSIX desktops, greatly improving components testability.

## Motivation

In µOS++ IIIe, the APIs were called CMSIS++, which were created
both as a proposal for a future CMSIS, and to overcome the
limitations/problems of the current CMSIS design, among them
the lack of proper C++ support.

The original ARM Keil name stands for **Cortex Microcontroller Software
Interface Standard**, and the CMSIS++ design inherits the good things
from ARM CMSIS but goes one step further into the world of C++;
it is not a C++ wrapper on top of ARM CMSIS, but **a completely
new design in C++**, with several C APIs as wrappers on top of
the native C++ APIs.

In µOS++ IVe, the name CMSIS was dropped.

## License

The **µOS++ APIs** are provided **free of charge** under the terms
of the [MIT License](https://opensource.org/licenses/MIT).

This means you can use µOS++ in any commercial or open source projects
without any limitations except preserving the included copyright notice.
