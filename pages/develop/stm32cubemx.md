---
layout: page
lang: en
permalink: /develop/stm32cubemx/
title: STM32CubeMX
author: Liviu Ionescu

date: 2021-01-23 11:27:00 +0300

---

## Overview

[STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)
is a graphical tool provided by ST Microelectronics,
that allows a very easy configuration
of STM32 microcontrollers, as well as the generation
of the corresponding initialization C code for the Arm® Cortex-M.

This page documents the procedure to create the initialisation code
for the **NUCLEO-F411RE** blinky projects.

For other boards/devices, adjust the steps accordingly.

Note: STM32CubeMX has a very weird implementation, and you may face many
small issues with the interface;

## Prerequisites

The application requires Java. The more recent CubeMX releases
include a Java JRE; if this is not enough, install a recent
Java distribution.

## Download & install

Register to the STM site and download the latest version.

The result is a file like `en.stm32cubemx-*-v6-8-1.zip`. Unpack it and follow
the instructions.

Note: for macOS, if the user account has no administrative rights
(as it should not have!), run the install manually, with sudo:

```sh
sudo xattr -cr ~/Downloads/en.stm32cubemx-mac-v6-8-1
sudo open ~/Downloads/en.stm32cubemx-mac-v6-8-1/SetupSTM32CubeMX.app
```

Install in `~/Applications/STMicroelectronics/STM32CubeMX.app`

On macOS, the packages repository is stored at `${HOME}/STM32Cube/Repository`

## Start

Start the application. The current top window looks like:

![STM32CubeMX]({{ site.baseurl }}/assets/images/2021/stm32cubemx.png)

## Install the F4 package

STM provides separate packages for each family. Install the F7 package.

- in the top page, click the **INSTALL/REMOVE** button
- scroll to the **STM32F4** family
- enable the latest available version
- click the **Install Now** button
- click the **Close** button

![Install STM32F4]({{ site.baseurl }}/assets/images/2021/cubemx-install-f4.png)

## Create a new project

Before creating a new project, create a new folder in the project,
for example `stm32f411cubemx`.

To create a new project, start by selecting the board:

- click the **ACCESS TO BOARD SELECTOR**
- in the Commercial Part Number, enter **NUCLEO-F411RE**
- in the list, select the board
- click the **Start Project** button

![Select STM32F4DISCO]({{ site.baseurl }}/assets/images/2021/cubemx-select-f4disco.png)

- at the **Initialize all peripherals with their default Mode**
  click the **No** button for a minimal configuration
- in CubeMX, File -> Save Project as -> select the destination
  (like `<project>/platform-nucleo-f411re/stm32f411cubemx`), **Save**
- check if a file called `stm32f411cubemx.ioc` was created in the
  destination folder

## Configure the project

- in the top window, click the **Project Manager** tab
- select the **Project** category
  - check the **Project Name: stm32f411cubemx**
  - check the **Project Location: platform-nucleo-stm32f411re**
  - check the **Application Structure: Advanced**
  - enable **Do not generate the main()**
  - ignore the **Toolchain Folder Location** (no idea what it might be)
  - in the **Toolchain/IDE** combo, select **Makefile**
  - in the **Mcu and Firmware Package** area
    - **Mcu Reference: STM32F411xE**
    - **Firmware Package Name and Versio: STM32Cube FW_F4 V1.27.1** (use latest)
    - enable **Use Default Firmware Location**

![Project settings]({{ site.baseurl }}/assets/images/2021/cubemx-project.png)

- select the **Code Generation** category
  - select the **Copy only the necessary library files**
  - in the **Generated files** group
    - enable **Generate peripheral initialization as a pair of `.c/.h` files per peripheral**
    - enable **Keep User Code when re-generating**
    - enable **Delete previously generated files when not re-generated**
  - in the **HAL Settings** group
    - disable **Set all free pins as analog**
    - enable **Enable Full Assert**

![Code Generator settings]({{ site.baseurl }}/assets/images/2021/cubemx-code-generator.png)

- select the **Advanced Settings**
  - enable **MX_GPIO_Init**, with visibility (static)
  - enable **SystemClock_Config**
  - disable all register callbacks (on the right)

![Advanced settings]({{ site.baseurl }}/assets/images/2021/cubemx-advanced.png)

- in the top window, click the **Pinout & Configuration** tab
  - expand the **System Core** category
  - select NVIC
  - in the NVIC tab
    - enable all system interrupts, up to System tick timer
  - in the Code generation tab
    - disable **Generate IRQ handler**
  - only for Systick: enable **Call HAL handler**

![NVIC]({{ site.baseurl }}/assets/images/2021/cubemx-nvic.png)
![NVIC Code]({{ site.baseurl }}/assets/images/2021/cubemx-nvic-code.png)

## Generate code

Click the top right **GENERATE CODE** button.

The result is a file system hierarchy like:

```console
ilg@wks % tree stm32f411cubemx
stm32f411cubemx
├── Core
│   ├── Inc
│   │   ├── gpio.h
│   │   ├── main.h
│   │   ├── stm32f4xx_hal_conf.h
│   │   └── stm32f4xx_it.h
│   └── Src
│       ├── gpio.c
│       ├── main.c
│       ├── stm32f4xx_hal_msp.c
│       ├── stm32f4xx_it.c
│       └── system_stm32f4xx.c
├── Drivers
│   ├── CMSIS
│   │   ├── Device
│   │   │   └── ST
│   │   │       └── STM32F4xx
│   │   │           ├── Include
│   │   │           │   ├── stm32f411xe.h
│   │   │           │   ├── stm32f4xx.h
│   │   │           │   └── system_stm32f4xx.h
│   │   │           ├── LICENSE.txt
│   │   │           └── Source
│   │   │               └── Templates
│   │   ├── Include
│   │   │   ├── cmsis_armcc.h
│   │   │   ├── cmsis_armclang.h
│   │   │   ├── cmsis_compiler.h
│   │   │   ├── cmsis_gcc.h
│   │   │   ├── cmsis_iccarm.h
│   │   │   ├── cmsis_version.h
│   │   │   ├── core_armv8mbl.h
│   │   │   ├── core_armv8mml.h
│   │   │   ├── core_cm0.h
│   │   │   ├── core_cm0plus.h
│   │   │   ├── core_cm1.h
│   │   │   ├── core_cm23.h
│   │   │   ├── core_cm3.h
│   │   │   ├── core_cm33.h
│   │   │   ├── core_cm4.h
│   │   │   ├── core_cm7.h
│   │   │   ├── core_sc000.h
│   │   │   ├── core_sc300.h
│   │   │   ├── mpu_armv7.h
│   │   │   ├── mpu_armv8.h
│   │   │   └── tz_context.h
│   │   └── LICENSE.txt
│   └── STM32F4xx_HAL_Driver
│       ├── Inc
│       │   ├── Legacy
│       │   │   └── stm32_hal_legacy.h
│       │   ├── stm32f4xx_hal.h
│       │   ├── stm32f4xx_hal_cortex.h
│       │   ├── stm32f4xx_hal_def.h
│       │   ├── stm32f4xx_hal_dma.h
│       │   ├── stm32f4xx_hal_dma_ex.h
│       │   ├── stm32f4xx_hal_exti.h
│       │   ├── stm32f4xx_hal_flash.h
│       │   ├── stm32f4xx_hal_flash_ex.h
│       │   ├── stm32f4xx_hal_flash_ramfunc.h
│       │   ├── stm32f4xx_hal_gpio.h
│       │   ├── stm32f4xx_hal_gpio_ex.h
│       │   ├── stm32f4xx_hal_pwr.h
│       │   ├── stm32f4xx_hal_pwr_ex.h
│       │   ├── stm32f4xx_hal_rcc.h
│       │   ├── stm32f4xx_hal_rcc_ex.h
│       │   ├── stm32f4xx_hal_tim.h
│       │   ├── stm32f4xx_hal_tim_ex.h
│       │   ├── stm32f4xx_ll_bus.h
│       │   ├── stm32f4xx_ll_cortex.h
│       │   ├── stm32f4xx_ll_dma.h
│       │   ├── stm32f4xx_ll_exti.h
│       │   ├── stm32f4xx_ll_gpio.h
│       │   ├── stm32f4xx_ll_pwr.h
│       │   ├── stm32f4xx_ll_rcc.h
│       │   ├── stm32f4xx_ll_system.h
│       │   └── stm32f4xx_ll_utils.h
│       ├── LICENSE.txt
│       └── Src
│           ├── stm32f4xx_hal.c
│           ├── stm32f4xx_hal_cortex.c
│           ├── stm32f4xx_hal_dma.c
│           ├── stm32f4xx_hal_dma_ex.c
│           ├── stm32f4xx_hal_exti.c
│           ├── stm32f4xx_hal_flash.c
│           ├── stm32f4xx_hal_flash_ex.c
│           ├── stm32f4xx_hal_flash_ramfunc.c
│           ├── stm32f4xx_hal_gpio.c
│           ├── stm32f4xx_hal_pwr.c
│           ├── stm32f4xx_hal_pwr_ex.c
│           ├── stm32f4xx_hal_rcc.c
│           ├── stm32f4xx_hal_rcc_ex.c
│           ├── stm32f4xx_hal_tim.c
│           └── stm32f4xx_hal_tim_ex.c
├── Makefile
├── STM32F411RETx_FLASH.ld
├── startup_stm32f411xe.s
└── stm32f411cubemx.ioc

16 directories, 83 files
```

### Source folders

Add the following source folders to the build:

- `stm32f411cubemx/Core/Src`
- `stm32f411cubemx/Drivers/STM32F7xx_HAL_Driver/Src`

### Include folders

Add the following include folders to the build:

- `stm32f411cubemx/Core/Inc`
- `stm32f411cubemx/Drivers/CMSIS/Device/ST/STM32F4xx/Include`
- `stm32f411cubemx/Drivers/CMSIS/Include`
- `stm32f411cubemx/Drivers/STM32F4xx_HAL_Driver/Inc`

## Customisations

Although not critical, for a better error reporting, some small changes
can be performed to the `stm32f411cubemx/Core/Src/main.c` file.

Being braced by the special comments, these changes survive regenerations
with CubeMX.

## Include trace header

```c
/* USER CODE BEGIN Includes */

#if defined(OS_INCLUDE_MICRO_OS_PLUS_DIAG_TRACE)
#include <micro-os-plus/diag/trace.h>
#endif

/* USER CODE END Includes */
```

## Implement Error_Handler()

```c
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */

#if defined(OS_INCLUDE_MICRO_OS_PLUS_DIAG_TRACE)
  trace_printf("Error_Handler()\r\n");
#endif

  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
```

## Implement assert_failed()

```c
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

#if defined(OS_INCLUDE_MICRO_OS_PLUS_DIAG_TRACE)
  trace_printf("Wrong parameters value: file %s on line %d\r\n", file, line);
#endif

    while(1) {}

  /* USER CODE END 6 */
```
