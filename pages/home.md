---
layout: main
permalink: /
title: The µOS++ IIIe / CMSIS++ Project
author: Liviu Ionescu

date: 2016-03-03 22:35:00 +0300

---

The **µOS++ IIIe** _(micro oh ɛs plus plus third edition)_ project is the third iteration of µOS++, a POSIX-like, portable, open source, royalty-free, multi-tasking real-time operating system intended for 32/64-bits embedded applications, written in C++.

**CMSIS++** is a proposal for a future CMSIS, written in C++, and is the core component of **µOS++ IIIe**. The project is hosted on GitHub as [micro-os-plus/cmsis-plus](https://github.com/micro-os-plus/cmsis-plus).

## Twofold identity

The µOS++ IIIe project can be considered from two points of view.

### The µOS++ packages

From a modular point of view, µOS++ IIIe is a **collection of packages** hosted on GitHub in two locations:

* the original code is grouped under the [µOS++ IIIe / CMSIS++](https://github.com/micro-os-plus) GitHub collection of projects (or _Organization_, according to GitHub terminology)
* projects based on third party code are grouped under the [xPacks](https://github.com/xpacks) collection.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-collection.png" />
</div>

### The µOS++ RTOS

From an embedded system point of view, µOS++ IIIe provides the **reference implementation** for the CMSIS++ **scheduler** and **portable synchronisation** objects (like mutex, semaphore, etc).

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-rtos.png" />
</div>

## License

Unless otherwise mentioned, all µOS++ IIIe / CMSIS++ components are provided free of charge under the terms of the [MIT License](https://opensource.org/licenses/MIT).
