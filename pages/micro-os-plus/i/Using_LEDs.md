---
layout: old-wiki-page
permalink: /micro-os-plus/i/Using_LEDs/
title: Using LEDs
author: Liviu Ionescu

date: 2011-07-29 09:46:00 +0000

---

By default 4 LEDs are defined in OS_Board_Defines.h for various purposes.

The first one is usually used as an *Activity* indicator: it is turned on when entering any interrupt and turned of when the processor enters any idle or sleep mode, so a life representation of the system activity is visible to the eye. By connecting a scope probe to this LED it also allows to measure the active to idle ratio.

LEDs are defined using 4 proprocessor macros:

    #define OS_CFGREG_BOARD_LED0_PORT_CONFIG                        GPIOX
    #define OS_CFGREG_BOARD_LED0_PORT_WRITE                         GPIOX
    #define OS_CFGREG_BOARD_LED0_PORT_READ                          GPIOX
    #define OS_CFGPIN_BOARD_LED0_PIN                                AVR32_PIN_PX16
    #define OS_CFGBOOL_BOARD_LED0_ISACTIVE_LOW                      (true)

Using the debug LEDs is quite easy:

    #include "portable/devices/debug/include/OSDebugLed1.h"
    ...
    OSDebugLed1::init();
    ...
    OSDebugLed1::on();
    ...
    OSDebugLed1::off();
    ...
    OSDebugLed1::toggle();