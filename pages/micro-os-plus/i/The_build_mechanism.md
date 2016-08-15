---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/The_build_mechanism/
title: The build mechanism
author: Liviu Ionescu

date: 2010-11-10 14:24:03 +0000

---

Building embedded applications usually differs from building desktop applications. When using traditional libraries the granularity is at library module level, i.e. useless library modules are not included by the linker. However for embedded applications, where flash size restrictions are important, this might not be enough and granularity at source level fragment is preffered. This extreme granularity can be obtained only by using preprocessor conditional statements to exclude useless code.

The Build Toolchain
-------------------

The only compiler considered for building µOS++ is the [GNU C++](http://gcc.gnu.org/) compiler (currently 4.3.x); on Windows systems this compiler is packed in [WinAVR](http://winavr.sourceforge.net/) and the ARM compiler is packed in [Code Sourcery G++ Lite](http://www.codesourcery.com/sgpp/lite/arm).

The recommended build environment is based on [Eclipse](http://www.eclipse.org/) (currently 3.4). Please note that the formatter in CDT 4.0.0 has some bugs and some files are not processed properly; version 4.0.1 fixes these bugs.

Managed Build
-------------

Due to the inherent complexity of such a system, comprising tens of files, our recommendation is to use the Eclipse managed build mechanism.

Dedicated plug-ins are available both for ARM and AVR.

    **** Build of configuration Debug-Olimex-STM32-H103 for project blinkX3 ****

    cs-make all
    Building file: X:/Users/ilg/Vault/Projects/workspace-3.3-AVR/micro-os-plus/
    system/portable/tasks/src/TaskBlink.cpp
    Invoking: ARM Sourcery Windows GCC C++ Compiler
    arm-none-eabi-g++ -DDEBUG=1 -DOS_CONFIG_DEBUG_DEVICE_I2C=1
    -D"OS_CONFIG_BOARD_OLIMEX_STM32_H103=1"
    -I"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\blinkX3/include"
    -I"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\micro-os-plus\system"
    -O1 -Wall -fno-exceptions
    -fsigned-char -c -fmessage-length=0 -fno-rtti -fno-inline-functions -Wabi
    -MMD -MP -MF"system/portable/tasks/src/TaskBlink.d"
    -MT"system/portable/tasks/src/TaskBlink.d" -mcpu=cortex-m3 -mthumb -g3
    -gdwarf-2 -o"system/portable/tasks/src/TaskBlink.o"
    "X:/Users/ilg/Vault/Projects/workspace-3.3-AVR/micro-os-plus/system/
    portable/tasks/src/TaskBlink.cpp"
    Finished building: X:/Users/ilg/Vault/Projects/workspace-3.3-AVR/
    micro-os-plus/system/portable/tasks/src/TaskBlink.cpp

    ...

    Building file: ../src/TaskBlink.cpp
    Invoking: ARM Sourcery Windows GCC C++ Compiler
    arm-none-eabi-g++ -DDEBUG=1 -DOS_CONFIG_DEBUG_DEVICE_I2C=1
    -D"OS_CONFIG_BOARD_OLIMEX_STM32_H103=1"
    -I"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\blinkX3/include"
    -I"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\micro-os-plus\system"
    -O1 -Wall -fno-exceptions
    -fsigned-char -c -fmessage-length=0 -fno-rtti -fno-inline-functions -Wabi
    -MMD -MP -MF"src/TaskBlink.d" -MT"src/TaskBlink.d" -mcpu=cortex-m3 -mthumb -g3
    -gdwarf-2 -o"src/TaskBlink.o" "../src/TaskBlink.cpp"
    Finished building: ../src/TaskBlink.cpp

    Building file: ../src/main.cpp
    Invoking: ARM Sourcery Windows GCC C++ Compiler
    arm-none-eabi-g++ -DDEBUG=1 -DOS_CONFIG_DEBUG_DEVICE_I2C=1
    -D"OS_CONFIG_BOARD_OLIMEX_STM32_H103=1"
    -I"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\blinkX3/include"
    -I"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\micro-os-plus\system"
    -O1 -Wall -fno-exceptions
    -fsigned-char -c -fmessage-length=0 -fno-rtti -fno-inline-functions -Wabi
    -MMD -MP -MF"src/main.d" -MT"src/main.d" -mcpu=cortex-m3 -mthumb -g3
    -gdwarf-2 -o"src/main.o" "../src/main.cpp"
    Finished building: ../src/main.cpp

    Building target: blinkX3.elf
    Invoking: ARM Sourcery Windows GCC C++ Linker
    arm-none-eabi-g++ -T"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\
    micro-os-plus\system\hal\boards\Olimex\stm32_h103\stm32_h103_rom.ld"
    -nostartfiles
    -L"X:\Users\ilg\Vault\Projects\workspace-3.3-AVR\micro-os-plus\system"
    -Wl,-Map,blinkX3.map -v -mcpu=cortex-m3 -mthumb -g3 -gdwarf-2
    -o"blinkX3.elf"  ./system/portable/tasks/src/CANLeds.o
    ./system/portable/tasks/src/TaskBlink.o
    ./system/portable/tasks/src/TaskPitpalac.o
    ./system/portable/stdlib/src/ios.o
    ./system/portable/stdlib/src/iostream.o
    ./system/portable/stdlib/src/istream.o
    ./system/portable/stdlib/src/ostream.o
    ./system/portable/stdlib/src/streambuf.o
    ./system/portable/misc/src/CircularBlockBuffer.o
    ./system/portable/misc/src/CircularByteBuffer.o
    ./system/portable/misc/src/Parser.o
    ./system/portable/misc/src/SimpleCli.o
    ./system/portable/misc/src/uOS.o
    ./system/portable/kernel/src/OS.o
    ./system/portable/kernel/src/OSEventFlags.o
    ./system/portable/kernel/src/OSMutex.o
    ./system/portable/kernel/src/OSScheduler.o
    ./system/portable/kernel/src/OSTask.o
    ./system/portable/kernel/src/OSTaskIdle.o
    ./system/portable/kernel/src/OSTimer.o
    ./system/portable/kernel/src/OSTimerSeconds.o
    ./system/portable/kernel/src/OSTimerTicks.o
    ./system/portable/kernel/src/Timer.o
    ./system/portable/kernel/src/ostream_OSTask.o
    ./system/portable/devices/usb/src/OSUsbDevice.o
    ./system/portable/devices/usb/src/OSUsbDeviceDescriptors.o
    ./system/portable/devices/sdi12/src/SDI12BootLoader.o
    ./system/portable/devices/sdi12/src/SDI12Sensor.o
    ./system/portable/devices/misc/src/DeviceLM74.o
    ./system/portable/devices/misc/src/DeviceMCP2510.o
    ./system/portable/devices/misc/src/DeviceRTC4574.o
    ./system/portable/devices/misc/src/DeviceSPIUsart.o
    ./system/portable/devices/misc/src/PinChangeDispatchers.o
    ./system/portable/devices/debug/src/DeviceDebugI2C.o
    ./system/portable/devices/debug/src/OSDeviceDebug.o
    ./system/portable/devices/character/src/DeviceCharacterMultiUsart0.o
    ./system/portable/devices/character/src/DeviceCharacterMultiUsart1.o
    ./system/portable/devices/character/src/DeviceCharacterUsart.o
    ./system/portable/devices/character/src/DeviceCharacterUsart0.o
    ./system/portable/devices/character/src/DeviceCharacterUsart1.o
    ./system/portable/devices/character/src/DeviceCharacterUsb.o
    ./system/portable/devices/character/src/OSDeviceCharacter.o
    ./system/portable/devices/character/src/OSDeviceCharacterBuffered.o
    ./system/portable/devices/block/src/CANPacket.o
    ./system/portable/devices/block/src/DeviceMemCard.o
    ./system/portable/devices/block/src/DeviceMemCardSPI.o
    ./system/portable/devices/block/src/OSDeviceCAN.o
    ./system/hal/boards/Metrilog/m512/src/SDI12Sensor_Implementation.o
    ./system/hal/arch/avr/kernel/src/OSScheduler_Implementation.o
    ./system/hal/arch/avr/kernel/src/OSTimer_Implementation.o
    ./system/hal/arch/avr/kernel/src/OS_Implementation.o
    ./system/hal/arch/avr/kernel/src/ostream_ProgramPtr.o
    ./system/hal/arch/avr/devices/misc/src/DeviceADC_Implementation.o
    ./system/hal/arch/avr/devices/debug/src/OSDeviceDebug_Implementation.o
    ./system/hal/arch/avr/devices/character/src/DeviceCharacterMultiUsart0_Implementation.o
    ./system/hal/arch/avr/devices/character/src/DeviceCharacterMultiUsart1_Implementation.o
    ./system/hal/arch/avr/devices/character/src/DeviceCharacterUsart0_Implementation.o
    ./system/hal/arch/avr/devices/character/src/DeviceCharacterUsart1_Implementation.o
    ./system/hal/arch/avr/devices/character/src/DeviceCharacterUsart_Implementation.o
    ./system/hal/arch/avr/devices/block/src/DeviceCAN_MCP2510.o
    ./system/hal/arch/avr/at90usb/devices/usb/src/OSUsbDevice_Implementation.o
    ./system/hal/arch/avr/at90usb/devices/character/src/DeviceCharacterUsb_Implementation.o
    ./system/hal/arch/avr/at90can/devices/block/src/DeviceCAN_AT90CAN.o
    ./system/hal/arch/arm_cortex_m3/stm32f10x/lib/src/system_stm32f10x.o
    ./system/hal/arch/arm_cortex_m3/stm32f10x/kernel/src/OS_Family_Implementation.o
    ./system/hal/arch/arm_cortex_m3/lib/src/core_cm3.o
    ./system/hal/arch/arm_cortex_m3/kernel/src/OSScheduler_Arch_Implementation.o
    ./system/hal/arch/arm_cortex_m3/kernel/src/OSTimer_Arch_Implementation.o
    ./system/hal/arch/arm_cortex_m3/kernel/src/OS_Arch_Implementation.o
    ./system/hal/arch/arm_cortex_m3/devices/debug/src/OSDeviceDebug_Arch_Implementation.o
     ./src/TaskBlink.o ./src/main.o
    Finished building target: blinkX3.elf

    Invoking: ARM Sourcery Windows GNU Create Flash Image
    arm-none-eabi-objcopy -O ihex blinkX3.elf "blinkX3.hex"
    Finished building: blinkX3.hex

    Invoking: ARM Sourcery Windows GNU Create Listing
    arm-none-eabi-objdump -h -S blinkX3.elf >"blinkX3.lst"
    Finished building: blinkX3.lst

    Invoking: ARM Sourcery Windows GNU Print Size
    arm-none-eabi-size  --format=berkeley blinkX3.elf
       text       data        bss        dec        hex    filename
      14652        696       2552      17900       45ec    blinkX3.elf
    Finished building: blinkX3.siz

Manual Build
------------

Althouth previous versions included limited support for manual builds by use of a single included file (system.cpp), starting with version 3.x it was no longer maintained. Upon request, this file can be updated to include new files.

Compile and link options should be based on the above manged build script.
