---
layout: post
lang: en
title: µOS++ v6.3.9 released
author: Liviu Ionescu

date: 2016-10-13 22:46:00 +0300

categories:
  - releases
  - micro-os-plus

tags:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus-iii

---

Version v6.3.9 is a new **µOS++/CMSIS++** public release (v6.3.8 was an internal release). The major additions are: the first integration of the POSIX I/O subsystem and an experimental set of scripts to generate µOS++ projects.

## Download

As of now, the **µOS++** code is split between several GitHub projects and needs to be brought together to compose a project.
To automate this process, some scripts were written. To experiment with **µOS++**, please check the demo projects, available from [GitHub](https://github.com/micro-os-plus/eclipse-demo-projects), and use a similar structure for your projects.

## New features

- integrate posix-io & posix-driver git subtrees from the separate projects; currently only character devices are fully functional;
- automate char device registry by using lists; no need to manually add/remove devices;
- in order to support tickless deep sleeps, the `update_for_slept_time()` function was added to the `clock` class, to update the internal count with the number of ticks lost during the sleep;

## Addressed bugs

- os-c-wrapper.c: the functions used to create objects did create objects properly, but failed to return a pointer to the created objects; fixed;
- diag/trace.cpp: for empty strings, `puts()` did not add the terminator; fixed;

## Other changes

- general purpose classes were moved to the newly created `utils` folder;
- startup: temporarily disable weak `os_startup_initialize_hardware()` (without the renamed function the linker used the weak version of this function and did not perform the hardware initialisations at all).

## Known problems

None.
