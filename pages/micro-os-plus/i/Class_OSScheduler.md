---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSScheduler/
title: Class OSScheduler
author: Liviu Ionescu

date: 2011-02-23 10:44:36 +0000

---

OSScheduler

Constructors
============

OSScheduler()
-------------

**Description**


This constructor print a trace messsage (if debug is active).

**Parameters**

:\* None.

Methods
=======

static void earlyInit(void)
---------------------------

**Description**


This method performs early initialisations of the OSScheduler task. It must be called before all constructors.

**Parameters**

:\* None.

**Return value**

:\* None.

static void start(void) __attribute__( ( noreturn ) )
---------------------------------------------------------

**Description**


Enable the scheduler to run and start the task with the highes priority. This function is automatically called in the default main() function, called after all static constructors were executed.

**Parameters**

:\* None.

**Return value**

:\* None.

static bool isRunning(void)
---------------------------

**Description**


Return true if the the scheduler was started. Please note that once started, the scheduler cannot be stopped, so this function will return false before main() (i.e. while running static constructors) and true after main().

**Parameters**

:\* None.

**Return value**

:\* True if the the scheduler was started. False otherwise.

static void lock(void)
----------------------

**Description**


Lock the scheduler to the current task, i.e. do not allow the scheduler to switch to another task. Please note that interrupts are not affected, the interrupt service routines will be executed normally and event notifications might wakeup tasks with higher priorities, but switching to another task will be permited only after unlock(). While locked, yield() will immediately return to the same task, and eventWait() will immediately return with OSEventWaitReturn::OS_LOCKED.

**Parameters**

:\* None.

**Return value**

:\* None.

static void unlock(void)
------------------------

**Description**


Unlock the scheduler, so at the next rescheduling moment another task might get the CPU.

**Parameters**

:\* None.

**Return value**

:\* None.

static bool isLocked(void)
--------------------------

**Description**


Return true if the scheduler is locked.

**Parameters**

:\* None.

**Return value**

:\* TRUE if the scheduler is locked, FALSE otherwise.

static void setLock(bool flag)
------------------------------

**Description**


Lock the scheduler if the flag is true, unlock otherwise.

**Parameters**

:\* flag - if is TRUE the scheduler will be locked.

**Return value**

:\* None.

inline static bool isPreemptive(void)
-------------------------------------

**Description**


Return true if the scheduler runs in preemptive mode.

**Parameters**

:\* None.

**Return value**

:\* TRUE if the preemptive mode was activated, FALSE otherwise.

static void setPreemptive(bool flag)
------------------------------------

**Description**


Return true if the scheduler runs in preemptive mode.

**Parameters**

:\* flag - if is TRUE, set the preemptive mode.

**Return value**

:\* None.

static OSTask \*getTaskCurrent(void)
------------------------------------

**Description**


Return a pointer to the task currently running on the CPU.

**Parameters**

:\* None.

**Return value**

:\* Pointer to the task currently running on the CPU.

static OSTask \*getTaskIdle(void)
---------------------------------

**Description**


Return a pointer to the Idle task.

**Parameters**

:\* None.

**Return value**

:\* Pointer to the Idle task.

static int getTasksCount(void)
------------------------------

**Description**


Return the number of tasks registered to the scheduler.

**Parameters**

:\* None.

**Return value**

:\* The number of tasks registered to the scheduler.

static OSTask \*getTask(int i)
------------------------------

**Description**


Return the i-th task registered to the scheduler, or OS_TASK_NONE for illegal index.

**Parameters**

:\* None.

**Return value**

:\* The i-th task registered to the scheduler, or OS_TASK_NONE for illegal index.

static bool isAllowDeepSleep(void)
----------------------------------

**Description**


Return true if the deep sleep flag was set to true. Requires definition of OS_INCLUDE_OSTASK_SLEEP.

**Parameters**

:\* None.

**Return value**

:\* Return true if the deep sleep flag was set to true.

static void setAllowDeepSleep(bool flag)
----------------------------------------

**Description**


Set the value of the deep sleep flag. Requires definition of OS_INCLUDE_OSTASK_SLEEP.

**Parameters**

:\* bool - the value where the deep sleep flag will be set to.

**Return value**

:\* None.

inline static void criticalEnter(void) __attribute__( ( always_inline ) )
------------------------------------------------------------------------------

**Description**


Enter a critical section, i.e. a section where interrupts are not allowed. It is mandatory to be braced by a criticalExit(), failure to do so leads to unexpected results. The usual implementations save the current status of the interrupt flag and disable interrupts.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static void criticalExit(void) __attribute__( ( always_inline ) )
-----------------------------------------------------------------------------

**Description**


Exit critical section. Usual implementations restore the interrupt flag to the value saved by criticalEnter().

**Parameters**

:\* None.

**Return value**

:\* None.

static OSEventWaitReturn_t eventWait(OSEvent_t event)
-------------------------------------------------------

**Description**


Put the active task to sleep until an event occurs.

**Parameters**

:\* event - the event used to wake up the task.

**Return value**

:\* Status of the operation.

== static int eventNotify(OSEvent_t event, OSEventWaitReturn_t ret = OSEventWaitReturn::OS_VOID) == **Description**


Wakeup all tasks waiting for event.

**Parameters**

:\* event - the event used to wake up the tasks.

:\* ret - suplimentary information used to determine more informations about the source of the event.

**Return value**

:\* The number of notified tasks.

static void yield(void)
-----------------------

**Description**


Suspend the current task and reschedule the CPU to the next task.

**Parameters**

:\* None.

**Return value**

:\* None.

static unsigned char taskRegister(OSTask \*pTask)
-------------------------------------------------

**Description**


Register a task to the scheduler.

**Parameters**

:\* None.

**Return value**

:\* None.

static bool isContextSwitchRequired(void)
-----------------------------------------

**Description**


Quick check if a context switch is necessary.

**Parameters**

:\* None.

**Return value**

:\* TRUE if a context switch is needed.

static void performContextSwitch(void)
--------------------------------------

**Description**


Make the context switch to the first task from the tasks ReadyList.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static void interruptEnter(void) __attribute__( ( always_inline ) )
-------------------------------------------------------------------------------

**Description**


Called in order to save the context of the current task must be called in conjunction with interruptExit.

**Parameters**

:\* None.

**Return value**

:\* None.

inline static void interruptEnter(void) __attribute__( ( always_inline ) )
-------------------------------------------------------------------------------

**Description**


Called in order to perform the context switch must be called in conjunction with interruptEnter.

**Parameters**

:\* None.

**Return value**

:\* None.

Variables
=========

static OSTimerTicks timerTicks
------------------------------

**Description**


Timer, expressed in ticks, used to schedule the next task.

static OSTimerSeconds timerSeconds
----------------------------------

**Description**


Timer expressed in seconds.

static OSTask \*ms_pTaskRunning
--------------------------------

**Description**


Pointer to the active task (running task).
