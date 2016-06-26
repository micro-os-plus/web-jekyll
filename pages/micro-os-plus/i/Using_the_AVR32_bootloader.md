---
layout: old-wiki-page
permalink: /micro-os-plus/i/Using_the_AVR32_bootloader/
title: Using the AVR32 bootloader
author: Liviu Ionescu

date: 2011-07-22 13:08:39 +0000

---

Atmel provides a functional bootloader for its UC3 processors. It was intended for reprogramming the firmware after deployment, but it can be also used during development, as a more convenient alternative to JTAG.

How to program the bootloader
=============================

The bootloader occupies the first 8 KB of the flash space, and should be programmed using the JTAG.

The Atmel tools to manage chip programming are available in the AVR perspective:

-   select the **AVR** perspective:
    -   **Eclipse** menu: **Windows** → **Open perspective** → **Other**
    -   select **AVR**
    -   click the **OK** button

Erase the chip
--------------

Although it seems to be included in the next step, to avoid any surprises, it is recommended to first completely erase the chip before any programming.

Be sure you select **Chip Erase...**, not just **Erase...**, to completely erase the chip, including any security bits.

-   in the **AVR Targets** tab, right-click on **JTABICE mkII**
-   click on **Chip Erase...**
    -   read the notificaton message and click the **OK** button

For reference, on my machine this translated to:

    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --gui --part UC3A3256 chiperase

Program the bootloader code
---------------------------

-   in the **AVR Targets** tab, right-click on **JTAGICE mkII**
-   click on **Program Bootloadewr...**
    -   select the part, the **USB DFU** type and the latest version (currently 1.0.3)
    -   click the **Next** button
    -   in the AT32UC3 Bootloader wizard page
        -   set the pin to **42** (or any other value your board supports); this is the pin where the booloader button is connected.
        -   deselect the level (the User Page Configuration Word should read 0x929E2A9E)
        -   select all 3 bit configurations: ISP_BOD_EN, ISP_IO_COND_EN, ISP_FORCE (the FuseBitConfiguration Value should read 0xFFF7FFFF)
        -   click on the **Finish** button

For reference, on my machine this translated to:

    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --part UC3A3256 chiperase
    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --part UC3A3256 program
      -finternal@0x80000000,512Kb -cxtal -e -v -O0x80000000 -Fbin
      C:\Users\LIVIUI~1\AppData\Local\Temp\at32uc3a3-isp-1.0.3.bin9020454716059643611.bin
    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --part UC3A3256 program
      -finternal@0x80000000,512Kb -cxtal -e -v -O0x808001FC -Fbin
      C:\Users\LIVIUI~1\AppData\Local\Temp\userConf7033399909011047483,dat
    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --part UC3A3256 writefuses
      -finternal@0x80000000,512Kb gp=0xfff7ffff
    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --part UC3A3256 reset
    cmd.exe /C avr32program -c USB:0700000053E7 -pjtagicemkii --part UC3A3256 run

How to use the bootloader
=========================

Configure the USB DFU programmer
--------------------------------

Configuring the USB DFU Programmer is certainly possible, but unfortunately it is not obvious, probably due to some bugs.

The first step is to add a new AVR Target. In the properties page, the Details tab, should allow to select the

-   Device: AT32UC3A3256 (or some other value to match your board)
-   Debugger/programmer: USB DFU
-   Clock source: External clock connected to OSC0 (or some other value to match your board)

If these selections are not available, the trick is to play with existing config until they become available. For example you can first configure the JTAGICE mkII first and select the Device.

Program flash image
-------------------

-   in the **AVR Targets** tab, right-click on USB DFU
    -   click the **Program...** menu item
    -   select the file path to the .elf image
    -   leave the offset to **0x0**
    -   set the following options
        -   enable **Verify memory after programming**
        -   enable **Erase flash before programming**
        -   enable **Unlock flash before erasing**
        -   disable **Reset MCU after programming**
        -   enable **Start executing after programming**
    -   click the **OK** button

The device will start to execute the new image as soon as programming is completed.
