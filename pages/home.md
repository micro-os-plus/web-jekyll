---
layout: main
permalink: /
title: The CMSIS++ / µOS++ IIIe Project
author: Liviu Ionescu

date: 2016-03-03 22:35:00 +0300

---

The CMSIS++ project is a proposal for a future CMSIS, written in C++, and is the core component of µOS++ IIIe. The project is hosted on GitHub as [micro-os-plus/cmsis-plus](https://github.com/micro-os-plus/cmsis-plus).

The µOS++ IIIe (micro oh ɛs plus plus third edition) project is the third iteration of µOS++, an open source, royalty-free, multi-tasking operating system intended for 8/16/32/64 bit embedded systems, written in C++.


## Twofold identity

The µOS++ project can be considered from two points of view.

### The µOS++ packages

From a modular point of view, µOS++ is a **collection of packages** hosted on GitHub in two locations, the original code is grouped under the [CMSIS++ / µOS++ IIIe](https://github.com/micro-os-plus) GitHub collection of projects (or _Organization_, according to GitHub terminology) and projects based on third party code is grouped under the [xPacks](https://github.com/xpacks) collection.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-collection.png" />
</div>

### The µOS++ RTOS

From an embedded system point of view, µOS++ provides the **reference implementation** for the CMSIS++ **scheduler** and **portable synchronisation** objects (like mutex, semaphore, etc).

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-rtos.png" />
</div>

## License

Unless otherwise mentioned, all CMSIS++ / µOS++ components are provided free of charge under the terms of the [MIT License](https://opensource.org/licenses/MIT).
