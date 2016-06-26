---
layout: old-wiki-page
permalink: /micro-os-plus/i/How_to_port/
title: How to port
author: Liviu Ionescu

date: 2011-01-18 22:00:35 +0000

---

Introduction
============

TBD

Port existing architecture to new board
=======================================

TBD

Port to new architecture/family
===============================

Create board folder
-------------------

In **micro-os-plus/hal/boards**

For existing manufacturer

-   copy TEMPLATE_MANUFACTURER/TEMPLATE_BOARD to the manufacturer folder
-   rename TEMPLATE_BOARD to the actual bard name, preferably lower case (ex. evk1104, stk525)

For new manufacturer

-   copy/paste TEMPLATE_MANUFACTURER
-   rename TEMPLATE_MANUFACTURER to the manufacturer name (ex. Atmel)
-   rename TEMPLATE_BOARD to the actual bard name, preferably lower case (ex. evk1104, stk525)

Edit \${Board}/include/OS_Board_defines.h

    #define OS_CONFIG_ARCH_AVR32                    1
    #define OS_CONFIG_FAMILY_AVR32UC3               1
    #define OS_CONFIG_VARIANT_AVR32UC3A3                1
    #if !defined(OS_CONFIG_BOARD_ATMEL_EVK1104)
    #define OS_CONFIG_BOARD_ATMEL_EVK1104               1
    #endif

Create architecture folder
--------------------------

In **micro-os-plus/hal/arch**

-   copy/paste TEMPLATE_ARCH
-   rename TEMPLATE_ARCH to the architecture name
-   rename TEMPLATE_FAMILY to the architecture family name

Create build configuration
--------------------------

-   new config, based on Debug-Template-Avr32
-   rename to Debug-Atmel-EVK1104
-   edit Build Variable BOARD=ATMEL_EVK1104

Update references to board definitions
--------------------------------------

### /micro-os-plus/portable/kernel/include/OS_Defines.h

    ...
    #elif defined(OS_CONFIG_BOARD_ATMEL_EVK1104)
    #include "hal/boards/Atmel/evk1104/include/OS_Board_Defines.h"
    ...

### /micro-os-plus/portable/devices/debug/include/DeviceDebugI2C_Inlines.h

    ...
    #elif defined(OS_CONFIG_BOARD_ATMEL_EVK1104)
    #include "hal/boards/Atmel/evk1104/include/DeviceDebugI2C_Defines.h"
    ...

Update references to architecture/family definitions
----------------------------------------------------

### /micro-os-plus/portable/kernel/include/OS_Defines.h

    ...
    #elif defined(OS_CONFIG_ARCH_AVR32)
    #  include "hal/arch/avr32/kernel/include/OS_Arch_Defines.h"

    #if defined(OS_CONFIG_FAMILY_AVR32UC3)
    #  include "hal/arch/avr32/uc3/kernel/include/OS_Family_Defines.h"
    #else
    #  error "Missing OS_CONFIG_FAMILY_* definition"
    #endif
    ...

### /micro-os-plus/portable/kernel/include/OSScheduler.h

    ...
    #elif defined(OS_CONFIG_ARCH_AVR32)
    #include "hal/arch/avr32/kernel/include/OSScheduler_Arch_Inlines.h"

    #if defined(OS_CONFIG_FAMILY_AVR32UC3)
    #include "hal/arch/avr32/uc3/kernel/include/OSScheduler_Family_Inlines.h"
    #else
    #error "Missing OS_CONFIG_FAMILY_* definition"
    #endif
    ...

### /micro-os-plus/portable/kernel/include/OS.h

    ...
    #elif defined(OS_CONFIG_ARCH_AVR32)
    #include "hal/arch/avr32/kernel/include/OS_Arch_Inlines.h"
    #if defined(OS_CONFIG_FAMILY_AVR32UC3)
    #include "hal/arch/avr32/uc3/kernel/include/OS_Family_Inlines.h"
    #else
    #error "Missing OS_CONFIG_FAMILY_* definition"
    #endif
    ...

### /micro-os-plus/portable/devices/debug/include/DeviceDebugI2C_Inlines.h

    ...
    #elif defined(OS_CONFIG_ARCH_AVR32)
    #if defined(OS_CONFIG_FAMILY_AVR32UC3)
    #include "hal/arch/avr32/uc3/devices/debug/include/DeviceDebugI2CEmuMaster_Family_Inlines.h"
    #else
    #error "Missing OS_CONFIG_FAMILY_* definition"
    #endif
    ...

Update architecture/family macros in source files
-------------------------------------------------

### /micro-os-plus/hal/arch/avr32/kernel/src/\*.cpp

    ...
    #if defined(OS_CONFIG_ARCH_AVR32)
    ...

### /micro-os-plus/hal/arch/avr32/uc3/kernel/src/\*.cpp

    ...
    #if defined(OS_CONFIG_FAMILY_AVR32UC3)
    ...

Configure compiler and linker
-----------------------------

Add compiler files
------------------

/micro-os-plus/hal/arch/avr32/uc3/lib/src/trampoline.x /micro-os-plus/hal/arch/avr32/uc3/lib/include/conf_isp.h

update trampoline.x include

1.  include "hal/arch/avr32/uc3/lib/include/conf_isp.h"

update conf_isp.h

1.  include "hal/arch/avr32/lib/include/compiler.h"

Configure C/C++
---------------

-c -fmessage-length=0 -mpart=uc3a3256 -fno-exceptions -fno-rtti -Wextra -Wabi -std=gnu++98

`-mpart=uc3a3256 -Wl,-Map,sample-minimal.map -Xlinker --cref  -Wl,-e,_trampoline -T "${workspace_loc}/micro-os-plus/hal/arch/avr32/uc3/lib/link_uc3a3256.lds"`

-mpart=uc3a3256

-c -fmessage-length=0 -mpart=uc3a3256 -Wextra -std=gnu99
