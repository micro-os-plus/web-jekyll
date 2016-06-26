---
layout: old-wiki-page
permalink: /micro-os-plus/i/Interrupt_service_routines/
title: Interrupt service routines
author: Liviu Ionescu

date: 2011-03-09 20:47:09 +0000

---

Overview
========

The µOS++ framework provides special support for adding context switch functionality to interrupt service routines.

The main idea requires two steps:

-   to inform the compiler that the routines to be used as interrupt service routines should not have the standard entry/exit code, (i.e. to be naked), and
-   instead of the compiler generated code, to use the system defined code to enter/exit managed interrupt service routines.

Naked functions
===============

One very important notice: the naked interrupts run in a special environment, without a properly initialised link register. This makes the use of local variables, i.e. variables allocated on the stack of the naked routine, impossible. Calls to other functions are safe, and this is one of the reasons why in µOS++ the functionality is split between context handlers and interrupt service routines.

Context handlers vs. interrupt service routines
===============================================

As mentioned above, in µOS++ the functionality is split between context handlers and interrupt service routines. Context handlers are non portable, and should be implemented in the HAL part for each architecture or family, sometimes in plain C. When written in C++, they should be static methods.

Opposed to them, in µOS++, interrupt service routines are (or should be) portable and can be written in C++ without problems.

The pointer to the current object
=================================

Regardless of the complexity of the class hierarchy, with multiple classes inheriting from a common base, driver classes should have separate instances, to be able to use distinct interrupts context handlers.

As an example, even if the platform allows to define a common base for all Usart ports, it is still necessary to derive distinct Usart0, Usart1, etc. classed from the common base, and each and every one to configure separate interrupts.

The actual interrupt service routine can be a C++ method defined in the base class, but to be able to call it, the pointer to the actual objects should be used to differentiate between instances.

Exactly for this purpose, each implementation class should define a static member (like ms_pThis), where the constructor will store the pointer to the object.

Calling the common interrupt service routine from the context handler should be done using his pointer:

    ms_pThis->interruptRxServiceRoutine();

C++ context handlers
====================

If the architecture allows to register any function as interrupt service routines, then it can be written in C++ without problems.

    class MyClass
    {
    public:
      MyClass();
      ...
      static void __attribute__((naked))
      contextHandler(void);
      ...
      void interruptRxServiceRoutine(void);
      ...
      static MyClass * ms_pThis;
    }

    MyClass::MyClass(void)
    {
      ...
      ms_pThis = this;
      ...
    }

    void
    MyClass::contextHandler(void)
    {
      OSScheduler::interruptEnter();
      {
        ms_pThis->interruptRxServiceRoutine();
      }
      OSScheduler::interruptExit();
    }

    void
    MyClass::interruptRxServiceRoutine(void)
    {
      // Here the interesting things happen
    }

C context handlers
==================

For architectures that mandate interrupt service routines to be written in C, the code outline is slightly different.

    extern "C" void __attribute__((naked))
    MyClass_contextHandler(void);

    class MyClass
    {
    public:
      MyClass();
      ...
      void interruptServiceRoutine(void);
      ...
      static MyClass * ms_pThis;
    }

    MyClass::MyClass(void)
    {
      ...
      ms_pThis = this;
      ...
    }

    void
    MyClass_contextHandler(void)
    {
      OSScheduler::interruptEnter();
      {
        MyClass::ms_pThis->interruptServiceRoutine();
      }
      OSScheduler::interruptExit();
    }

    void
    MyClass::interruptServiceRoutine(void)
    {
      // Here the interesting things happen
    }

Configurable preemption
=======================

The µOS++ does not mandate for interrupts to implement preemption. When running in cooperative mode, i.e. when OS_EXCLUDE_PREEMPTION is defined, the code behind interruptEnter()/Exit() automatically skips the context switch code, so the interrupts will behave as usual (except they will do a full context save and context restore).

When running in preemptive mode, i.e. the OS_EXCLUDE_PREEMPTION is not defined, all interrupts declared as naked and using the interruptEnter()/Exit() code, will perform the context switch code.

For increased flexibility, and some more debugging opportunities, it is recommended to allow for each interrupt service routine to include or not the preemption code.

The configuration variables used to do this should conform to the following convention:

    OS_EXCLUDE_MYCLASS_ISR_PREEMPTION
    OS_EXCLUDE_MYCLASS_MYCONDITION_ISR_PREEMPTION

The MYCONDITION name adds some more specificity in case there are several interrupt service routines in a class, for example distinct RX and TX routines in the Usart driver.

A complete C++ code with configurable preemptions should configure the attribute used for the several interrupt service routine between naked and interrupt (or signal) on some platforms, like AVR8), and if naked is not used, be sure to completely exclude the interruptEnter()/Exit() code.

When the interruptEnter()/Exit() code is included, it also handles the activity LED (i.e. turn it on when interrupts are entered). To preserve the usefulness of the activity LED, when the interruptEnter()/Exit() code is not included, it is necessary to explicitly turn the LED on. In all cases it will be turned off when the processor enters the idle/sleep mode.

    class MyClass
    {
    public:
      MyClass();
      ...
      static void
    #if !defined(OS_EXCLUDE_MYCLASS_ISR_PREEMPTION)
      __attribute__((naked))
    #else
      __attribute__((interrupt))
    #endif /* !defined(OS_EXCLUDE_MYCLASS_ISR_PREEMPTION) */
      contextHandler(void);
      ...
      void interruptServiceRoutine(void);
      ...
      static MyClass * ms_pThis;
    }

    MyClass::MyClass(void)
    {
      ...
      ms_pThis = this;
      ...
    }

    void
    MyClass::contextHandler(void)
    {
    #if !defined(OS_EXCLUDE_MYCLASS_ISR_PREEMPTION)
      OSScheduler::interruptEnter();
    #else
      OSScheduler::ISR_ledActiveOn();
    #endif /* !defined(OS_EXCLUDE_MYCLASS_ISR_PREEMPTION) */
      {
        ms_pThis->interruptServiceRoutine();
      }
    #if !defined(OS_EXCLUDE_MYCLASS_ISR_PREEMPTION)
      OSScheduler::interruptExit();
    #endif /* !defined(OS_EXCLUDE_MYCLASS_ISR_PREEMPTION) */
     }

    void
    MyClass::interruptServiceRoutine(void)
    {
      // Here the interesting things happen
    }