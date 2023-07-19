---
layout: post
lang: en
title: µOS++ v6.3.11 released
author: Liviu Ionescu

date: 2017-01-02 22:29:00 +0300

categories:
  - releases
  - micro-os-plus-iii

tags:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus

---

Version v6.3.11 is a new **µOS++/CMSIS++** public release that addresses several bugs.

## Affected xPacks

- [micro-os-plus-iii](https://github.com/micro-os-plus/micro-os-plus-iii)
- [micro-os-plus-iii-cortexm](https://github.com/micro-os-plus/micro-os-plus-iii-cortexm)

## Download or update

As of now, the **µOS++** code is split between several GitHub projects and needs to be brought together to compose a project.
To automate this process, some scripts are available from a [separate project](https://github.com/xpacks/scripts).

To update the local copy of the xPacks, use the `scripts.git/xpacks-update-repo.sh` script.

To experiment with **µOS++**, please check the demo projects, available from [GitHub](https://github.com/micro-os-plus/eclipse-demo-projects), and use a similar structure for your projects.


## New features

None.

## Addressed bugs

- [[#6](https://github.com/micro-os-plus/micro-os-plus-iii/issues/6)]: attempts to print float values usually resulted in printing 0.0, while printing double values resulted in printing garbage. The problem was not related to printf(), but to all functions using variable arguments; more specifically, the implementation of the `va_arg()` macro not only expects the stack to be aligned at 8 bytes for float/double variables, but silently aligns it; if at the moment of the call the stack was not 8-bytes aligned, this resulted in fetching wrong values from the stack. The solution was to guarantee that the initial thread stack is aligned at 8-bytes. Asserts were also added for both the thread stack and the MSP stack;
- [[#7](https://github.com/micro-os-plus/micro-os-plus-iii/issues/7)]: In certain conditions, the message queue `*_receive()` calls triggered asserts, although the parameters were ok. The problem was due to some incorrect conditions used for checking the nbytes parameter; the wrong asserts were removed, in all three `*_receive()` public calls;
- [[#8](https://github.com/micro-os-plus/micro-os-plus-iii/issues/8)]: with GCC 5.4, any optimisation level higher then -O1 triggered a hard fault during the startup sequence of Cortex-M0/M0+ systems. Intended as a feature, with optimisation level higher then -O1, recent GCC versions check if the NULL pointer is dereferenced, and generate an undefined instruction, so instructions like `__set_MSP (*((uint32_t*) 0x0));` are no longer possible. The current workaround was to use a volatile pointer. Please note that this currently works on GCC 5.4, with any optimisation level; is not guaranteed to work on future GCC versions, which might get smarter in checking NULL dereferencing.

## Other changes

None.

## Known problems

None.
