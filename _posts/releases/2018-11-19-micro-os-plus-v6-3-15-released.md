---
layout: post
lang: en
title: µOS++ v6.3.15 released
author: Liviu Ionescu

date: 2018-11-19 13:09:00 +0200

categories:
  - releases
  - rtos
  - micro-os-plus

---

Version v6.3.15 is a **µOS++** maintenance release. The main changes
are several bug fixes.

## Affected packages

- [micro-os-plus-iii](https://github.com/micro-os-plus/micro-os-plus-iii)

## Download or update

As of now, the **µOS++** code is split between several GitHub projects
and needs to be brought together to compose a project.
To automate this process, some scripts are available from a
[separate project](https://github.com/xpacks/scripts).

To update the local copy of the xPacks, use the
`scripts.git/xpacks-update-repo.sh` script.

To experiment with **µOS++**, please check the demo projects, available from
[GitHub](https://github.com/micro-os-plus/eclipse-demo-projects),
and use a similar structure for your projects.

## New features

- none

## Addressed bugs

- [[#45](https://github.com/micro-os-plus/micro-os-plus-iii/issues/45)]: in
certain conditions, after locking the scheduler, although new PendSV were
no longer issued, if the ready queue already contained other entries, they were
still scheduled, breaking the interdiction set by the lock; an additional
check was added to `internal_switch_threads()` in `rtos/os-core.cpp`, to
guarantee that threads are not switched while the scheduler is locked.
- [[#46](https://github.com/micro-os-plus/micro-os-plus-iii/issues/46)]: in
certain conditions, if a lock to a protected mutex failed with an error,
the ownership was still preserved; fixed.

## Other changes

- [[#47](https://github.com/micro-os-plus/micro-os-plus-iii/issues/47)]: the
documentation for `stack::available()` mentioned the returned value to be
in words; actually the value is in bytes; corrected.

## Known problems

- the header files are still located below a `cmsis-plus` folder; to be
replaced by `micro-os-plus` in a future major release.
- the `file_descriptors_manager` class is not yet synchronised

## Future developments

This will hopefully be the final release of µOS++ in the current monolithic
structure. Future versions will use a modular structure, based on xPacks.
