---
layout: old-wiki-page
permalink: /micro-os-plus/i/FAQ/
title: FAQ
author: Liviu Ionescu

date: 2011-03-03 13:32:58 +0000

---

What does putString_P(PSTR("...")) mean? When to use it?
---------------------------------------------------------

This is a method of OSDeviceDebug, the debug tracer facility. It is similar to putString(), i.e. it sends a string to the trace output.

The difference is that it accepts a string stored in the program space, i.e. a constant string.

The reason for this method to be here is that on Avr8 the program space is different from the data space; the ram is addressed with normal pointers, while the flash needs special calls. With lots of debug messages present on the Debug build configuration, we may ran out of ram on small devices, thus the need to store the debug messages in flash. This is done by using the PSTR() macro. Since this results in a different type than regular strings, the new putString_P() was added.

On more advanced architectures the PSTR() macro does nothing special, and the putString_P() is replaced by putString(), so both are functionally identical.

The complicated syntax should be used only in portable code sections that have good chances to be executed on Avr8, i.e. system internals and Avr8 drivers. It might be also used on applications designed to also run on Avr8.

The content of the system file I want to study is grey. How can I view it properly?
-----------------------------------------------------------------------------------

Showing parts of a source file as gray blocks of text is a feature provided by Eclipse CDT to hide parts of the code that are not compiled.

If the entire content of a source file is gray, this means that you did not informed the µOS++ build process that you need the given functionality, and by default it is disabled.

To enable it, the first step to do is to look at the beginning of the file and note the preprocessor definition used:

    #if defined(OS_INCLUDE_OSMUTEX)

Then go to the project OS_App_Defines.h file and add the needed definition:

    #define OS_INCLUDE_OSMUTEX (1)

Save the file and give the indexer some time to update the screen. The greyed code should shortly turn to normal code.

Embedded criticalEnter()/exit() calls? How does this work?
----------------------------------------------------------

In other words, it looks like embedded critical sections no longer execute properly.

    os.sched.criticalEnter();
    {
      ..
      os.sched.criticalEnter();
      {
        ...
      }
      os.sched.criticalExit();
      // Are we still in the critical section here?
    }
    os.sched.criticalExit();

As presented above, the inner critialExit() seems to reenable interrupts and the critical section ends.

The truth is that criticalEnter()/Exit() were specifically designed to allow embedded critical sections, i.e. they do not simply disable/enable interrupts, but use a stack mechanism to save the initial interrupt status and restore it at exit. So, the inner criticalEnter() finds the interrupts already disabled and when executing criticalExit(0 and restoring the interrupts status, interrupts remain disabled.
