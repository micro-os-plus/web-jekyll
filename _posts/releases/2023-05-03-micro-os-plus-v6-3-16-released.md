---
layout: post
lang: en
title: µOS++ v6.3.16 released
author: Liviu Ionescu

date: 2021-05-03 13:09:00 +0200

categories:
  - releases
  - micro-os-plus

tags:
  - releases
  - rtos
  - cmsis-plus
  - micro-os-plus-iii

---

Version v6.3.16 is a **µOS++** maintenance release. The changes
are a bug fix and an enhancements.

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

- [[#48](https://github.com/micro-os-plus/micro-os-plus-iii/issues/84)]:
  several methods lacked the `override` keyword, triggering compiler
  warnings; fixed.

## Other changes

- [[#74](https://github.com/micro-os-plus/micro-os-plus-iii/issues/74)]:
  there ws no C wrapper for thread::kill(); added

## Known problems

- the header files are still located below a `cmsis-plus` folder; to be
replaced by `micro-os-plus` in a future major release.
- the `file_descriptors_manager` class is not yet synchronised
