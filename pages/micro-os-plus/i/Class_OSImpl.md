---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSImpl/
title: Class OSImpl
author: Liviu Ionescu

date: 2011-02-21 11:58:23 +0000

---

OSImpl

Constructors
============

Methods
=======

inline static void CPUstackInit(void) __attribute__((always_inline))
-------------------------------------------------------------------------

**Description**


Initialize the SP register in order to point to the stack section.

**Parameters**

:\* none

**Return value**

:\* none

inline static void CPUinit(void) __attribute__((always_inline))
--------------------------------------------------------------------

**Description**


Perform some CPU initializations.

**Parameters**

:\* none

**Return value**

:\* none

inline static void CPUidle(void) __attribute__((always_inline))
--------------------------------------------------------------------

**Description**


Put MCU to the idle sleep mode.

**Parameters**

:\* none

**Return value**

:\* none

inline static void CPUsleep(void) __attribute__((always_inline))
---------------------------------------------------------------------

**Description**


Put MCU to sleep.

**Parameters**

:\* none

**Return value**

:\* none

inline static void CPUdeepSleep(void) __attribute__((always_inline))
-------------------------------------------------------------------------

**Description**


Put MCU to deep sleep.

**Parameters**

:\* none

**Return value**

:\* none

inline static OSResetBits_t CPUfetchResetBits(void) __attribute__((always_inline))
----------------------------------------------------------------------------------------

**Description**


Return the reset bits used to know the reset reason.

**Parameters**

:\* none

**Return value**

:\* The reset bits used to know the reset reason.

inline static void WDTreset(void) __attribute__((always_inline))
---------------------------------------------------------------------

**Description**


Reset the WDT.

**Parameters**

:\* none

**Return value**

:\* none

inline static void NOP(void) __attribute__((always_inline))
----------------------------------------------------------------

**Description**


No operation performed. It embeds the asm "nop" assembly command.

**Parameters**

:\* none

**Return value**

:\* none

inline static void SOFTreset(void) __attribute__((always_inline))
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
