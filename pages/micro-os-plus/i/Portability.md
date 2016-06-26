---
layout: old-wiki-page
permalink: /micro-os-plus/i/Portability/
title: Portability
author: Liviu Ionescu

date: 2010-11-10 14:10:59 +0000

---

µOS++ code is split into a portable part and a hardware dependent part (hal).

Hardware dependent part is hierarchicaly split into architecture (like "avr" or "arm-cortex-m3"), family (like "at90usb" or "stm32f10x"), variant (like "at90usb1287") and board (like "stk525" or "stm32_h103").

The configuration starts with the board definition, passed as a preprocessor definition on the compiler command line, like -D"OS_CONFIG_BOARD_OLIMEX_STM32_H103=1"

Based on this definition, the "portable/kernel/include/OS_Defines.h" header file includes a board specific definition header, like "hal/boards/Olimex/stm32_h103/include/OS_Board_Defines.h".

This file adds definitions for the architecture, family, variant, and then default definitions for various configuration values, like oscillator frequency, tick rate, LED ports, etc.

Porting to a new board
======================

If the new board is based on an existing microcontroller, the porting process is quite simple, all you have to do is to add the new OS_Board_Defines.h somewhere in the hierarchy and add a conditional reference to it in "portable/kernel/include/OS_Defines.h". The preffered location is under "hal/boards/MANUFACTURER/BOARD/include".

You can pick a definition that is close to your board, and copy/paste it.

Porting to a new family
=======================

A new family is a group of microcontrollers with common characteristics. For ARM, this is usually a product family from a different manufacturer.

The recommended aproach is to copy/paste an existing family definition and to modify where needed. Expected changes are interrupt vectors and reset initializations.
