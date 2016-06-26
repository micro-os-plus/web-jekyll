---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSTask/
title: Class OSTask
author: Liviu Ionescu

date: 2011-02-23 13:41:09 +0000

---

OSTask

Constructors
============

== OSTask(const char \*pName, const OSStack_t \*pStack, unsigned short stackSize, OSTaskPriority_t priority = OSTask::DEFAULT_PRIORITY) == **Description**


Initialize the task object with the list of parameters received.

**Parameters**

:\* pName - name of the task.

:\* pStack - pointer to the memory region used by this task as stack.

:\* stackSize - the size of the stack.

:\* priority - task's priority.

**Return value**

:\* none

OSTask(const char \*pName, OSTaskMainPtr_t entryPoint, void \*pParameters, const OSStack_t \*pStack, unsigned short stackSize, OSTaskPriority_t priority)
------------------------------------------------------------------------------------------------------------------------------------------------------------

**Description**


Initialize the task object with the list of parameters received.

**Parameters**

:\* pName - name of the task.

:\* entryPoint - pointer to the function executed by this task.

:\* pStack - pointer to the memory region used by this task as stack.

:\* stackSize - the size of the stack.

:\* priority - task's priority.

**Return value**

:\* none

Destructor
==========

virtual \~OSTask()
------------------

**Description**


Destroy this object.

**Parameters**

:\* none

**Return value**

:\* none

Methods
=======

virtual void taskMain(void)
---------------------------

**Description**


Main function task, overridden by actual implementation. This function is used if no entryPoint is registered (see the constructors section).

**Parameters**

:\* none

**Return value**

:\* none

void suspend(void)
------------------

**Description**


Suspend the task and remove it from the ready list.

**Parameters**

:\* none

**Return value**

:\* none

void resume(void)
-----------------

**Description**


Resume the task, previously suspended by inserting it into the ready list.

**Parameters**

:\* none

**Return value**

:\* none

bool isSuspended(void)
----------------------

**Description**


Check if the task is suspended.

**Parameters**

:\* none

**Return value**

:\* TRUE if the task is suspended.

bool isWaiting(void)
--------------------

**Description**


Check if the task is waiting on an event.

**Parameters**

:\* none

**Return value**

:\* TRUE if the task is waiting.

void virtualWatchdogSet(unsigned short seconds)
-----------------------------------------------

**Description**


Set the virtual watchdog expire interval (in seconds). It requires the definition of OS_INCLUDE_OSTASK_VIRTUALWATCHDOG.

**Parameters**

:\* seconds - the interval expressed in seconds

**Return value**

:\* none

void virtualWatchdogCheck(void)
-------------------------------

**Description**


If the virtual watchdog interval expires, the MCU is reset using the hardware module watchdog. It requires the definition of OS_INCLUDE_OSTASK_VIRTUALWATCHDOG.

**Parameters**

:\* none

**Return value**

:\* none

bool isDeepSleepAllowed(void)
-----------------------------

**Description**


Return TRUE if the task can go to sleep, FALSE otherwise. It is required the definition of OS_INCLUDE_OSTASK_SLEEP.

**Parameters**

:\* none

**Return value**

:\* TRUE if the task can go to sleep.

char const \*getName(void)
--------------------------

**Description**


Return the task name.

**Parameters**

:\* none

**Return value**

:\* Task's name.

unsigned char \*getStackBottom(void)
------------------------------------

**Description**


Return the address of the stack bottom. Stack grows from high address to low address, so this is the maximum address the stack can grow.

**Parameters**

:\* none

**Return value**

:\* The address of the bottom of the stack.

unsigned char \*getStackBottom(void)
------------------------------------

**Description**


Return the current stack pointer of the task. This value is stored only during context switch, so the running task will not get the actual value.

**Parameters**

:\* none

**Return value**

:\* The address of the current stack pointer of the task.

unsigned short getStackSize(void)
---------------------------------

**Description**


Return the stack size given at task creation.

**Parameters**

:\* none

**Return value**

:\* The stack size.

int getID(void)
---------------

**Description**


Return the task ID.

**Parameters**

:\* none

**Return value**

:\* The task ID.

void \*getContext(void)
-----------------------

**Description**


Return the task's context.

**Parameters**

:\* none

**Return value**

:\* The task context.

OSTaskPriority_t getPriority(void)
-----------------------------------

**Description**


Return task priority. Higher means better priority.

**Parameters**

:\* none

**Return value**

:\* The task priority.

void setPriority(OSTaskPriority_t priority)
--------------------------------------------

**Description**


Set task priority.

**Parameters**

:\* none

**Return value**

:\* none

OSEvent_t getEvent(void)
-------------------------

**Description**


Return the event the task is waiting for. Cancelling a waiting task can be done by notifying this event with a return value of OS_EVENT_WAIT_RETURN_CANCELED.

**Parameters**

:\* none

**Return value**

:\* The event the task is waiting for.

void setEvent(OSEvent_t event)
-------------------------------

**Description**


Set the event the task is waiting for.

**Parameters**

:\* event - the event the task is waiting for.

**Return value**

:\* none

unsigned short getStackUsed(void)
---------------------------------

**Description**


Return the maximum usage of the stack, in bytes.

**Parameters**

:\* none

**Return value**

:\* The maximum usage of the stack, in bytes.

void setAllowSleep(bool status)
-------------------------------

**Description**


Allow task to be put to sleep.

**Parameters**

:\* status - if is TRUE the task can be put at sleep.

**Return value**

:\* none

== int eventNotify(OSEvent_t event, OSEventWaitReturn_t ret = OSEventWaitReturn::OS_VOID) == **Description**


Wake up this task if it waits for the event received as parameter.

**Parameters**

:\* event - the event used to wake up the tasks.

:\* ret - suplimentary information used to determine more informations about the source of the event.

**Return value**

:\* none

Variables
=========

OSStack_t \*m_pStack
----------------------

**Description**


The SP is saved in this variable at contextSave and restored from here at contextRestore.

