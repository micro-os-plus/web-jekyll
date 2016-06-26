---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSSchedulerImpl/
title: Class OSSchedulerImpl
author: Liviu Ionescu

date: 2011-02-14 18:40:53 +0000

---

OSSchedulerImpl

Constructors
============

Methods
=======

static void start(void) __attribute__( ( noreturn ) )
---------------------------------------------------------

**Description**


Starts the first task from the tasks ready list.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static void yield(void) __attribute__( ( always_inline ) )
----------------------------------------------------------------------

**Description**


Specific implementation of the yield function for the AVR32 architecture.

**Parameters**

:\* None.

**Return value**

:\* None.

static OSStack_t \*stackInitialize(OSStack_t \* pStackTop, void(\*entryPoint)(void \*), void \*pParams, unsigned char id)
---------------------------------------------------------------------------------------------------------------------------

**Description**


Used to initialize the stack for a task.

**Parameters**

:\* pStackTop - pointer to the memory region used as stack by this task.

:\* entryPoint - function pointer to the routine that will be executed by this task.

:\* pParams - pointer to the parameters passed to this task.

:\* id - task's ID.

**Return value**

:\* Pointer to the last element from the initialized stack.

inline static void FirstTask_contextRestore(void) __attribute__( ( always_inline ) )
------------------------------------------------------------------------------------------

**Description**


Restore the context for the next task to be scheduled.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static void stackPointerSave(void) __attribute__( ( always_inline ) )
---------------------------------------------------------------------------------

**Description**


Save the SP for the active task to it's stack.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static void registersRestore(void) __attribute__( ( always_inline ) )
---------------------------------------------------------------------------------

**Description**


Restore the registers for the active task.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static bool isContextSwitchAllowed(void) __attribute__( ( always_inline ) )
---------------------------------------------------------------------------------------

**Description**


Check if the context switch can be done. The context switch cannot be done if the current context is a nested interrupt. In order to check this, the SR register saved on stack is verified (to see what the previous context was).

**Parameters**

:\* None.

**Return value**

:\* TRUE if the context switch is allowed, FALSE otherwise..
