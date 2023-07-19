---
layout: post
lang: en
title: First µOS++ public version v6.3.7 released
author: Liviu Ionescu

date: 2016-09-15 15:28:00 +0300

categories:
  - releases
  - micro-os-plus

tags:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus-iii

---

Version v6.3.7 is the first **µOS++/CMSIS++** public release. The major additions are the advanced memory management features, which allow deterministic and non-fragmenting allocations in controlled environments.

## Download

As of now, the **µOS++** code is split between several GitHub projects and needs to be brought together to compose a project.
To automate this process, some scripts were written. To experiment with **µOS++**, please check the demo projects, available from [GitHub](https://github.com/micro-os-plus/eclipse-demo-projects), and use a similar structure for your projects.

## New features

- advanced memory management; several `memory_resource` classes were added, with various allocation policies (`first_fit_top`, `lifo`, `block_pool`). Based on these classes, an application allocator was implemented, and the standard C++ `new` and `delete`, as the standard C `malloc()` and `free()` were routed to this allocator. An optional allocator for the RTOS system objects can be defined. For special applications, optional pools of system objects can be created and allocation for these objects redirected to the pools.

## Addressed bugs

- none so far

## Other changes

- none

## Known problems

Experience proved that one of the changes in this version was trickier than planned: the rename of the `os_startup_initialize_hardware()`, since without the renamed function the linker used the weak version of this function and did not perform the hardware initialisations at all.

To help developers, the weak definition was temporarily disabled, so if this function was not yet renamed in the application, the linker will complain.
