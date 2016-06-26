---
layout: old-wiki-page
permalink: /micro-os-plus/i/Tasks/
title: Tasks
author: Liviu Ionescu

date: 2010-12-13 23:06:31 +0000

---

µOS++ tasks allow the application developer to create and manage independent threads of execution. All defined tasks are automatically registered to the scheduler and thus all tasks are scheduled to use the CPU in a order based on their static priority (see the [scheduler]({{ site.baseurl }}/micro-os-plus/i/Scheduler "wikilink") page). Tasks cannot be unregistered from the scheduler.

Each µOS++ task has its own stack where all task calls are performed. On architectures that do not have a separate exception stack (like AVR), when the task is running, interrupt service routines will use the task stack, so please be aware that a 'deep' interrupt service routine will affect all tasks running. When the task is created, the stack is initialized to a known static pattern. Stack activity overwrite this value, so when **getStackUsed()** is invoked it is possible to compute the maximum usage of the stack.

Tasks can have, at different moments in time, different status attributes: running, waiting, suspended.

-   Running tasks: are either using the CPU or waiting for their turn to get the CPU.
-   Waiting tasks: are blocked tasks that will no longer be scheduled to use the CPU until an event occur.
-   Suspended tasks: are no longer scheduled to execution until the 'suspended' status is cleared. Notifications sent to suspended tasks are ignored.

Creating a new task is simply a matter of defining a new class, based on **OSTask** (see example below), and declaring an instance of this class.

The new task is automatically registered to the scheduler by the **OSTask** constructor.

Constructors
------------

    OSTask(const char *pName, const OSStack_t *pStack, unsigned short stackSize,
           OSTaskPriority_t priority = OS_TASK_DEFAULT_PRIORITY);

This constructor defines the task name, the stack and optionally a priority.

Methods
-------

### Info Methods

    char const *getName(void);

Return the task name.

    int getID(void);

Return the task ID.

### Status Methods

    void suspend(void);

Mark the task as suspended and remove it from the list of running tasks.

    void resume(void);

Clean the suspended status and add the task to the list of running tasks.

    bool isSuspended(void);

Return true if the task is suspended.

    bool isWaiting(void);

Return true if the task is waiting for an event.

### Stack Methods

    unsigned char *getStackBottom(void);

Return the address of the stack bottom. Stack grows from high address to low address, so this is the maximum address the stack can grow.

    unsigned short getStackSize(void);

Return the stack size given at task creation.

    OSStack_t *getStack(void);

Return the current stack pointer of the task. This value is stored only during context switch, so the running task will not get the actual value.

    unsigned short getStackUsed(void);

Return the maximum usage of the stack.

### Priority Methods

    OSTaskPriority_t getPriority(void);

Return task priority.

    void setPriority(OSTaskPriority_t priority);

Set task priority to given value. Should be used with caution to avoid deadlocks and priority inversions.

### Events Methods

    OSEvent_t getEvent(void);

Return the event the task is waiting for. Cancelling a waiting task can be done by notifying this event with a return value of OS_EVENT_WAIT_RETURN_CANCELED.

    void setEvent(OSEvent_t event);

Set the event the task is waiting for (defined only for completness, normally not necessary).

* * * * *

Examples
--------

### TaskBlink.h

    #include "portable/kernel/include/OS.h"

    #include "config_app.h"

    class TaskBlink : public OSTask
      {
    public:
        // task constructor
        TaskBlink(const char *pName, schedTicks_t rate = 1);

        // actual task main code
        virtual void taskMain(void);
    private:
        // members
        OSStack_t m_stack[(OS_MINIMAL_STACK_SIZE + 200) / sizeof(OSStack_t)];
        schedTicks_t m_rate;
      };

### TaskBlink.cpp

    #include "TaskBlink.h"

    TaskBlink::TaskBlink(const char *pName, schedTicks_t rate) :
      OSTask(pName, m_stack, sizeof(m_stack))
      {
        m_rate = rate;
      }

    void TaskBlink::taskMain(void)
      {
        ledInit();
        ledOff();

        // task endless loop
        for (;;)
          {
            os.timerSeconds.sleep(m_rate);
            ledToggle();
          }
      }

### main.c

    // ...
    #include "TaskBlink.h"
    // ...
    TaskBlink t("blink"); // the new task is declared as a static object