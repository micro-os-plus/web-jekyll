---
layout: post
lang: en
title: µOS++ v7.0.0 released
author: Liviu Ionescu

date: 2023-07-19 13:09:00 +0200

categories:
  - releases
  - micro-os-plus-iii

tags:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus

---

Version v7.0.0 is a new **µOS++** major release. It represents
an important milestone, being the first release that includes extensive
tests running in scriptable CI environments.

The main functional changes
are several updates required to avoid warnings with the new toolchains.

## Updated packages

- [micro-os-plus/micro-os-plus-iii](https://github.com/micro-os-plus/micro-os-plus-iii) - v7.0.0
- [micro-os-plus/micro-os-plus-iii-cortexm](https://github.com/micro-os-plus/micro-os-plus-iii-cortexm) - v1.0.0
- [micro-os-plus/micro-os-plus-iii-posix-arch](https://github.com/micro-os-plus/micro-os-plus-iii-posix-arch) - v1.0.0
- [xpacks/arm-cmsis](https://github.com/xpacks/arm-cmsis) - v4.5.0-7
- [xpacks/arm-cmsis-rtos-validator](https://github.com/xpacks/arm-cmsis-rtos-validator) - v1.0.0-1
- [xpacks/chan-fatfs](https://github.com/xpacks/chan-fatfs) - v0.13.1-3
- [xpack-3rd-party/raspberrypi-pico-sdk-xpack](https://github.com/xpack-3rd-party/raspberrypi-pico-sdk-xpack) - v1.5.1-1
- [xpack-3rd-party/libucontext-xpack](https://github.com/xpack-3rd-party/libucontext-xpack) - v1.2.0-1

## Install

As a source code library, µOS++ can be integrated into another project
in the traditional way,
by either copying the relevant files into the target project, or by linking
the relevant project as Git submodules.

However, the workflow can be further automated and the most convenient way is
to **add it as a dependency** to the project via **xpm**.

## New features

- [[#78](https://github.com/micro-os-plus/micro-os-plus-iii/issues/78)]:
  there was no support to clear the statistics;
  add a `clear()` method to thread statistics and to the scheduler

- [[#79](https://github.com/micro-os-plus/micro-os-plus-iii/issues/79)]:
  identifying the thread which issued an assert was difficult;
  add the `this_thread` address and name when displaying the assert error

- [[#81](https://github.com/micro-os-plus/micro-os-plus-iii/issues/81)]:
  thread reuse via placement new was error prone;
  add a thread attribute to check if the thread constructor is called
  only after destroy

## Addressed bugs

- [[#82](https://github.com/micro-os-plus/micro-os-plus-iii/issues/82)]:
  GCC 12 spotted a name clash between the `file_system()` method and
  the class; the method was renamed to `get_file_system()`

- [[#83](https://github.com/micro-os-plus/micro-os-plus-iii/issues/83)]:
  GCC 12 spotted a name clash between the unscoped enum `socket` definition
  and the top definition; the definition was changed to a scoped `enum class`

Note: although minor, those were both **breaking changes**, which
according to semver rules, required
to increase the version major number.

## Other changes

- [[#77](https://github.com/micro-os-plus/micro-os-plus-iii/issues/77)]:
  the arm-none-eabi-gcc 12 complains about some new warnings;
  silenced

- [[#80](https://github.com/micro-os-plus/micro-os-plus-iii/issues/80)]:
  in a normal use case, during thread destruction, there was an _already gone_
  debug message; fixed, do not call `kill()` in the destructor if
  it was already called explicitly

- [[#84](https://github.com/micro-os-plus/micro-os-plus-iii/issues/84)]:
  the stack underflow condition was tested only when asserts were enabled;
  fixed, the condition is always tested and `abort()` is invoked if necessary

## Known problems

- the header files are still located below a `cmsis-plus` folder; to be
replaced by `micro-os-plus` in a future major release
- the `file_descriptors_manager` class is not yet synchronised

## Future developments

This will hopefully be the final release of µOS++ in the current monolithic
structure (IIIe). Work on the next version (IVe) is already under way;
the main change is that it'll use a modular structure, based on xPacks.
