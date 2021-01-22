---
layout: post
lang: en
title: First µOS++ scriptable build
author: Liviu Ionescu

date: 2021-01-22 22:18:00 +0200

categories:
  - releases
  - rtos
  - micro-os-plus

---

In preparation for the future 7.x release, a major milestone was
reached: the modularised µOS++ was, for the first time, fully built
without Eclipse.

The preliminary version uses a simplified CMake configuration, that
performs monolithic builds for all demo platforms:

- STM32F4DISCOVERY (Cortex-M4)
- STM32F0DISCOVERY (Cortex-M0)
- SiFive HiFive1 (RISC-V)
- Synthetic POSIX (user process on macOS/Linux)

The CMake scripts will be further refined; support for meson is also
planned.
