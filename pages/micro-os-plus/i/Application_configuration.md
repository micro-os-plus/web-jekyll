---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Application_configuration/
title: Application configuration
author: Liviu Ionescu

date: 2011-05-24 23:04:46 +0000

---

The short story
===============

The recommended method of including configuration definitions in µOS++ projects is to use the **uOS.h** file

    #include "portable/kernel/include/uOS.h"

This file should be included in the **main.cpp** file, and in all class header files.

Each µOS++ project should define two distinct header files, one for the application specific files and one for system specific files. The preferred location for these files is **\${ProjDirPath}/include**.

App_Defines.h
--------------

Since all application files include uOS.h, extending the system definitions with application specific definitions can be conveniently done by including a custom header file **at the end** of uOS.h, **after most of the other system include files**.

This custom file is called App_Defines.h, and it's purpose is to extend the uOS.h header with application specific definitions, not to redefine system definitions.

By using this approach, application specific definitions in App_Defines.h can be based on all existing system definitions, for example:

    #define APP_CFGINT_TASKBLINK_TICKS          (OS_CFGINT_TICK_RATE_HZ)

OS_App_Defines.h
------------------

Similarly, all µOS++ system files include at least **portable/kernel/include/OS_Defines.h**, as a common point for all system related defines. This file performs a hierarchical sequence of inclusions, from particular to general, assuming that each level will add defaults for definitions not yet encountered.

In other terms, if a definition is not present in the application file, the board file might define it, otherwise the family/architecture related files might define it.

So the application definitions have the higher precedence and should not be overwritten by board/family/architecture definitions.

This also means that in this structure the board/family/definitions are not available in OS_App_Defines.h.

On the other hand, due to this specific inclusion order, definitions in the system headers are available in the application headers, so if these two files need to make conditional preprocessing, the **\#define** present in OS_App_Defines.h is available for any **\#if defined()** in App_Defines.h.

The long story
==============

OS_Defines.h
-------------

One of the build characteristics of µOS++ is that, at the limit, any project should build without errors with all µOS++ source files, regardless of architecture/family/board specifics.

In order for this to work, each non portable source file should check if the proper target is selected and skip if necessary.

    #include "portable/kernel/include/OS_Defines.h"

    #if defined(OS_CONFIG_ARCH_ARM_CORTEX_M3)

    #include "portable/kernel/include/OS.h"

    ...

    #endif /* defined(OS_CONFIG_ARCH_ARM_CORTEX_M3) */

As seen above, the minimum requirement for all system files, either C/C++ or assembly is to include the OS_Defines.h header file. If more system definitions are needed, the alternative is to use the OS.h header file.

The inclusion chain in OS_Defines.h is:

-   define absolute variables, like **OS versions**, in integer and string format
-   include **OS_App_Defines.h**
-   based o the board definition, selectively include **OS_Board_Defines.h**
-   based on the architecture family definition, selectively include **OS_Family_Defines.h**
-   based on the architecture definition, selectively include **OS_Arch_Defines.h**
-   define **defaults** for various definitions
-   define **interdependencies** for various definitions

As mentioned before, the OS_App_Defines.h header file is included early, before board/family/architecture files.

Being also included in preprocessed assembly files, one **specific requirement** for OS_Defines.h and nested files is to **include only preprocessor definitions, and not C/C++ definitions**.

OS.h (for system classes)
-------------------------

Regular system source files, in addition to preprocessor definitions, also need the definitions of the system classes, so instead of OS.h, the **portable/kernel/include/OS.h** header file should be used.

The inclusion chain in OS.h is:

-   include **OS_Defines.h**
-   include <stdint.h> for uint8_t, int8_t and other
-   define uchar_t, uint_t, ulong_t
-   include <cstddef> for std::size_t
-   define the **OSImpl** class
-   define the **OSSchedulerImpl** class
-   define the **OSApplicationImpl** class
-   include **OSScheduler.h**
-   include **OSTask.h**
-   include **OSTimer.h**, OSTimerSeconds.h, OSTimerTicks.h, Timer.h
-   include **OSDeviceDebug.h**
-   define the **OSReturn** class
-   define the **OSTimeout** class
-   define the **OS** class, derived from OSImpl
-   based on the architecture definition, selectively include **OS_Arch_Inlines.h**
-   based on the architecture family definition, selectively include **OS_Family_Inlines.h**

uOS.h (for application classes)
-------------------------------

As a single inclusion point for application source files, the inclusion chain in uOS.h is:

-   include **OS.h**
-   based on various OS_INCLUDE_\* variables, selectively include all other header files not already included in OS.h, like OSMutex.h, etc
-   define all system global variables as extern
-   include **App_Defines.h**
-   define other application variables based on definitions in App_Defines.h

The place of App_Defines.h is at the end of the inclusion chain, so none of the definitions present here can change anything in the system configuration, only in the application configuration.
