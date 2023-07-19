---
layout: post
lang: en
title: µOS++ v6.3.13 released
author: Liviu Ionescu

date: 2017-08-26 23:29:00 +0300

categories:
  - releases
  - micro-os-plus

tags:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus-iii

---

Version v6.3.13 is a **µOS++** maintenance release.

## Affected xPacks

- [micro-os-plus-iii](https://github.com/micro-os-plus/micro-os-plus-iii)

## Download or update

As of now, the **µOS++** code is split between several GitHub projects and needs to be brought together to compose a project.
To automate this process, some scripts are available from a [separate project](https://github.com/xpacks/scripts).

To update the local copy of the xPacks, use the `scripts.git/xpacks-update-repo.sh` script.

To experiment with **µOS++**, please check the demo projects, available from [GitHub](https://github.com/micro-os-plus/eclipse-demo-projects), and use a similar structure for your projects.


## New features

- `__posix_gettimeofday()` implemented; it calls `rtclock.now ()`
- header `<cmsis-plus/posix/termios.h>` added
- class `os::posix::tty` added with tty attributes support

## Addressed bugs

None.

## Other changes

- several typos in the documentation were fixed
- references to CMSIS++ were replaced by references to µOS++.

## Known problems

None.
