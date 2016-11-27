---
layout: post
lang: en
title: µOS++ IIIe v6.3.10 released
author: Liviu Ionescu

date: 2016-11-27 11:53:00 +0300

categories:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus

---

Version v6.3.10 is a new **µOS++ IIIe/CMSIS++** public release that addresses several bugs.

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

- rtos/os-clocks: after exiting deep sleep, when calling the `update_for_slept_time()` to update the internal count, the checks that allow timeout processing should also happen here; fixed, `internal_check_timestamps()` added;
- memory/first-fit-top: in memory full conditions the allocator risked to allocate past the limit; the problem was identified as a missing end of list initialisation in the initial free list chunk; fixed;
- startup: preprocessor floating point detection during hardware initialisations used wrong macros; fixed, new tests check `__ARM_FP`;
- micro-os-plus-iii-cortexm.git/os-core: first projects using floating point revealed a problem with the context switching code, which, in certain conditions, did not handle the `EXC_RETURN` value properly, and the floating point registers were not saved/restored correctly; fixed, now the `EXC_RETURN` is saved on the thread stack;

## Other changes

None.

## Known problems

None.

## Future developments

Advanced tools to manage the µOS++ packages (based on XCDL/xPack) are planned, and will be available in the near future.
