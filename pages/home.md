---
layout: main
lang: en
permalink: /
title: The µOS++ Project
author: Liviu Ionescu

date: 2016-03-03 22:35:00 +0300

---

The **µOS++ IIIe** _(micro oh ɛs plus plus third edition)_ project is the third iteration of µOS++, a POSIX-like, portable, open source, royalty-free, multi-tasking real-time framework intended for 32/64-bits embedded applications, written in C++. The project is hosted on GitHub as [micro-os-plus](https://github.com/micro-os-plus). It has a comprehensive [User's manual]({{ site.baseurl }}/user-manual/). The APIs are documented in the [µOS++ reference]({{ site.baseurl }}/reference/cmsis-plus/).

The **µOS++ IVe** (micro oh ɛs plus plus fourth edition) project
(affectionately called _Yves_, with the French pronunciation [iv],
like in Yves Montand) is the next edition, modularised and
with updated APIs. This is currently work in progress, with a
tentative release date by the end of 2023.

**POSIX++** is another point of view of the project; with most system APIs using the POSIX semantics, but being written in C++, the **µOS++** APIs can also be seen as a C++ version of POSIX, thus the name **POSIX++**.

## Multiple identities

The **µOS++** project can be considered from several points of view.

### The µOS++ framework/APIs

Although generally associated with its RTOS, **µOS++** is actually a framework, a collection of APIs, components and technologies.

One of the main APIs is the µOS++ RTOS API, but applications based on µOS++ may run very well without a RTOS, or even use a different RTOS.

For a better portability, the entire framework is layered, the µOS++ RTOS API provides a common public interface to the applications, but the implementation is separate, it might be that of its own µOS++ RTOS reference implementation, but it may very well be another implementation, even a custom one specific to the application.

### The µOS++ RTOS implementation

From an embedded system point of view, **µOS++** provides the **reference implementation** for the **scheduler** and **portable synchronisation** objects (like mutex, semaphore, etc).

<div style="text-align:center">
<img alt="µOS++ RTOS" src="{{ site.baseurl }}/assets/images/2017/micro-os-plus-rtos.png" />
</div>

### The µOS++ packages

From a modular point of view, **µOS++** is a **collection of packages** hosted on GitHub in two locations:

* the original code is grouped under the [µOS++](https://github.com/micro-os-plus) GitHub collection of projects
* projects based on third party code are grouped under the [xPacks](https://github.com/xpacks) collection.

<div style="text-align:center">
<img alt="µOS++ Collection" src="{{ site.baseurl }}/assets/images/2017/micro-os-plus-collection.png" />
</div>

## License

Unless otherwise mentioned, all **µOS++** components are provided **free of charge** under the terms of the [MIT License](https://opensource.org/licenses/MIT), with all rights reserved to Liviu Ionescu.
