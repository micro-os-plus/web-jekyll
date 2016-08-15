---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSCPUImpl/
title: Class OSCPUImpl
author: Liviu Ionescu

date: 2011-03-08 23:42:56 +0000

---

OSCPUImpl

Constructors
============

Methods
=======

inline static void stackInit(void) __attribute__((always_inline))
----------------------------------------------------------------------

**Description**


Initialize the SP register in order to point to the stack section.

**Parameters**

:\* none

**Return value**

:\* none

inline static void earlyInit(void) __attribute__((always_inline))
----------------------------------------------------------------------

**Description**


Perform some CPU initializations.

**Parameters**

:\* none

**Return value**

:\* none

inline static void idle(void) __attribute__((always_inline))
-----------------------------------------------------------------

**Description**


Put MCU to the idle sleep mode.

**Parameters**

:\* none

**Return value**

:\* none

inline static void sleep(void) __attribute__((always_inline))
------------------------------------------------------------------

**Description**


Put MCU to sleep.

**Parameters**

:\* none

**Return value**

:\* none

inline static void deepSleep(void) __attribute__((always_inline))
----------------------------------------------------------------------

**Description**


Put MCU to deep sleep.

**Parameters**

:\* none

**Return value**

:\* none

inline static OSResetBits_t fetchResetBits(void) __attribute__((always_inline))
-------------------------------------------------------------------------------------

**Description**


Return the reset bits used to know the reset reason.

**Parameters**

:\* none

**Return value**

:\* The reset bits used to know the reset reason.

inline static void watchdogReset(void) __attribute__((always_inline))
--------------------------------------------------------------------------

**Description**


Reset the watchdog timer (WDT).

**Parameters**

:\* none

**Return value**

:\* none

inline static void nop(void) __attribute__((always_inline))
----------------------------------------------------------------

**Description**


No operation performed. It embeds the asm "nop" assembly command.

**Parameters**

:\* none

**Return value**

:\* none

inline static void softReset(void) __attribute__((always_inline))
----------------------------------------------------------------------

**Description**


Generate a soft reset.

**Parameters**

:\* none

**Return value**

:\* none

inline static void returnFromInterrupt(void) __attribute__((always_inline,noreturn))
-----------------------------------------------------------------------------------------

**Description**


Wrapper for the asm "rete" instruction.

**Parameters**

:\* none

**Return value**

:\* none

inline static void returnFromSubroutine(void) __attribute__((always_inline,noreturn))
------------------------------------------------------------------------------------------

**Description**


Copy link register's (LR) value into the PC. This will continue execution of the previously executed routine.

**Parameters**

:\* none

**Return value**

:\* none

inline static void interruptsEnable(void) __attribute__((always_inline))
-----------------------------------------------------------------------------

**Description**


Enable interrupts (global interrupt mask bit - GM from SR). If function must be always inline, it is required the definition of OS_INLINE_INTERRUPTS_ENABLE_DISABLE.

**Parameters**

:\* none

**Return value**

:\* none

inline static void interruptsDisable(void) __attribute__((always_inline))
------------------------------------------------------------------------------

**Description**


Disable all interrupts (global interrupt mask bit - GM from SR). If function must be always inline, it is required the definition of OS_INLINE_INTERRUPTS_ENABLE_DISABLE.

**Parameters**

:\* none

**Return value**

:\* none
