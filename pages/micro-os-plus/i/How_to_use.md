---
layout: old-wiki-page
permalink: /micro-os-plus/i/How_to_use/
title: How to use
author: Liviu Ionescu

date: 2012-11-01 21:43:30 +0000

---

Prerequisites
=============

Before you start using the µOS++, please check that you have installed all necessary tools and packages, as described in the [How to install]({{ site.baseurl }}/micro-os-plus/i/How_to_install "wikilink") page.

Downloading the system source code and sample projects
======================================================

Using the released packages
---------------------------

TBD...

Using the SVN repository
------------------------

### Automatic method

For loading the latest versions of the projects from repository, the Eclipse standard procedure is to import the ['WorkspaceTeamProjectSystemAndSampleSets.psf](http://micro-os-plus.svn.sourceforge.net/svnroot/micro-os-plus/trunk/Eclipse/WorkspaceTeamProjectSystemAndSampleSets.psf) file.

If you need only the system project, please use the ['WorkspaceTeamProjectSystemSet.psf](http://micro-os-plus.svn.sourceforge.net/svnroot/micro-os-plus/trunk/Eclipse/WorkspaceTeamProjectSystemSet.psf) file.

The second step is to import the file in Eclipse:


**Eclipse** menu: **File** → **Import**

-   a new Import Select window is displayed
-   expand the **Team** category
-   select the **Team Project Set**
-   click **Next**
-   in the File name: field, enter the **WorkspaceTeamProjectSystemAndSampleSets.psf** file
-   click **Finish**

For saving your own Team Project sets:


**Eclipse** menu: **File** → **Export**

-   a new Export Select window is displayed
-   expand the **Team** category
-   select the **Team Project Set**
-   click **Next**
-   enable **Export working sets**
-   click on **Select All** or manually select the System and Samples sets
-   click **Next**
-   in the new window, select the export destination to a file
-   click **Finish**
-   in the To preference file: enter the name of the file to be used, like **myWorkspaceTeamProjectSets.psf**
-   click **Finish**
-   check if the myWorkspaceTeamProjectSets.psf file was created

### Manual method

TBD...

### Replace with a specific revision

If your application was built with an older version, and you have good reasons to use that specific revision, this can be easily done with the SVN commands.


Select the micro-os-plus project and right click

-   select the **Replace With** menu entry
-   select the **Revision or URL...** menu entry
-   a new window Update To Revision is displayed
-   enter the desired revision or date
-   click OK
-   a confirmation dialog is displayed
-   click OK

The managed build process peculiarities
=======================================

The µOS++ was designed to be portable across different boards. In other words, the same source code, without any changes, can be compiled to completely different boards, with completely different characteristics.

There might be many solutions for this, but the preferred one uses the CDT Managed Build mechanism, that completely automates the build process, without having to deal with the creation and maintenance of makefiles.

Build Configurations
--------------------

In Eclipse terms, a single project can have multiple build configurations, each for a different board.

In addition, each board can have different Debug/Release configurations.

To accomodate for multiple build configurations into a single project, in µOS++ the following naming convention is used:


*Type*-*Manufacturer*-*Board*

Where:

-   *Type* is **Debug** or **Release**
-   *Manufacturer* is a string defining the board manufacturer, like **Atmel**, **Olimex**, etc
-   *Board* is a string defining the physical board, for example **STK525**, **STM32-H103**

Preferably the board is exactly the name of the board, as the manufacturer defines it. If it is longer than usual, or contains special character, it is recommended to shorten/filter it.

Build Variables
---------------

To differentiate between build configurations, Eclipse allows to define different build variables for different configurations.

Since in µOS++ the criteria to differentiates between configuration is the board, the only build variable needed is a string, named **BOARD**.

The values that this variable can hold are uppercase alphanumerical strings, using the following naming convention


*Manufacturer*_*Board*

where the parts have the same meaning as before, but converte to uppercase, and '-' is replaced by '_'.

The explanation for these requirements is simple, the BOARD definition will be used as part of preprocessor macro-definition.

To acces the build variables, select the desired project (**minimal**, for example), and go to the


**Eclipse** menu: **Project** → **Properties**

-   expand **C/C++ Build**
-   select **Build Variables**
-   in the right panel, choose the desired configuration, for example **Debug-Atmel-STS525**
-   the main window will display something like

|Name|Type|Value|
|----|----|-----|
|BOARD|String|ATMEL_STK525|

The second build variables used for Debug build configurations is **DBGDEV**. It is used to specify the debug device used for the trace output.

Currently only the **I2C** value is actively maintained.

Another choice is **USART**, but code for this is not fully supported on all platforms.

In addition to user defined build variables, there are also a lot of system variables. They can be seen by enabling **Show system variables**.

Build variables can be used as simple macro definitions in most of the places where string fields are allowed in Eclipse.

C/C++ Symbols
-------------

The next step for forwarding definitions definitions to the build process, are the C/C++ Symbols.

The definitions entered here are automatically added to the preprocessor definitions of corresponding languages used in the project, and, very important, are also used by the CDT Indexer.

To access the C/C++ Symbols, select the desired project (**minimal**, for example), and go to the


**Eclipse** menu: **Project** → **Properties**

-   expand **C/C++ General**
-   select **Paths & Symbols**
-   in the right panel, choose the desired configuration, for example **Debug-Atmel-STS525**
-   in the right panel, select the **Symbols** tab

===OS_CONFIG_BOARD_\${BOARD}=1===

This is the only mandatory definitions required by µOS++, and needs to be present for all projects.

As it can be seen, it expands the build variable BOARD to a custom C/C++ preprocessor definition.

===DEBUG=1===

This definition should be present in all build configurations intended for debug.

Among other things, the debug configurations defines a generic serial device, where debug messages are sent. The recommended device is I2C, but it is also possible to use USART ports.

The selections is made by the following definitions. Only one of them should be present.

===OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1===

This definition should be present only for debug configurations, and defines the debug device to be the one defined by the build variable **DBGDEV**.

C/C++ Build Settings
--------------------

The last step for forwarding definitions definitions to the build process, are the C/C++ Tool Settings.

To access the C/C++ Tool Settings, select the desired project (**minimal**, for example), and go to the


**Eclipse** menu: **Project** → **Properties**

-   expand **C/C++ Build**
-   select **Settings**
-   in the right panel, choose the desired configuration, for example **Debug-Atmel-STS525**
-   in the right panel, select the **Tool Settings** tab

Selecting one specific compiler will show in the **All options** field the above preprocessor definitions passed as -D options to the GCC compiler.

Whenever possible, it is also recommended to use the GNU Make Builder, instead of the CDT internal one.

To access the C/C++ Tool chain Eitor, select the desired project (**minimal**, for example), and go to the


**Eclipse** menu: **Project** → **Properties**

-   expand **C/C++ Build**
-   select **Tool Chain Editor**
-   in the **Current builder** dialog box select **Gnu Make Builder**

Creating and configuring new projects
=====================================

Using an existing project as template
-------------------------------------

Although creating new projects from scratch is perfectly possible, the configurations are slightly more complex than usual, so the recommended method is by copy/paste, using as template the **sample-minimal** project.

-   in the Project Explorer, select the **View Menu icon** (down pointing triangle)
    -   select **No Working Sets**
    -   press **OK**; now all projects should be visible linearly, without Sets groupings
-   select the **sample-minimal** project
-   Edit → **Copy**
-   Edit → **Paste**
-   enter a name for the new project
-   accept the default location
-   press **OK**
-   select all Debug\* and Release\* folders
-   Edit → **Delete**
-   right click on project
-   select **Team Disconnect**
    -   select **Also delete the SVN meta-information from the file system**
    -   click **Yes**
-   edit the **includes/App_Defines.h** to change the debugger greeting message

Update project to reference micro-os-plus.

Continue to the **Build Project** section below.

Copying build configurations from template
------------------------------------------

If needed, instead of manually configuring projects, it is easier to copy build configurations from existing projects.

The reference project is the sample-minimal project, it is highly recommended to copy configurations only from this project.

-   **Eclipse** menu: **Project** → **Build Configurations** → **Manage**
-   click on the **New** button
-   enter configuration name, like **Debug-Atmel-STK525**
-   select **Import from projects**
-   select **sample-minimal -\> Debug-Atmel-STK525**
-   click on the **OK** button
-   click on the **OK** button

For unknown reasons, not all settings are copied, and some manual changes are needed:

-   add **BOARD** and **DVGDEV** in the C/C++ Build Variables
-   make the project reference the **micro-os-pus** project

Creating a new project from scratch
-----------------------------------

### Create new C++ project

-   **Eclipse** menu: **File** → **New** -\> **C++ Project**
    -   enter a project name
    -   as Project type select **AVR Cross Target Application** → *'Empty Project*
    -   as Toolchain select **AVR-GCC Toolchain**
    -   click **Next**
    -   accept the Debug/Release configurations, will be edited later
    -   click **Next**
    -   select **MCU Type**
    -   enter **MCU Frequency** (for completeness, not used by µOS++)
    -   click **Finish**

### Create a link to the system folder

All project should have a folder named **micro-os-plus** linked to **WORKSPACE_LOC/micro-os-plus**.

-   select the newly created project
-   **Eclipse** menu: **File** → **New** → **Folder**
    -   click on **Advanced**
    -   select **Link to alternate location (Linked Folder)**
    -   click on **Variables...**
    -   select **WORKSPACE_LOC**
    -   click OK
    -   append **'/micro-os-plus** to the WORKSPACE_LOC
    -   check if the Folder name was updated to **micro-os-plus**
    -   click **Finish**
    -   wait a few good moments for the configuration to be created

### Import Debug/Release configurations from templates

-   get Debug-AVR-Configuration.xml
-   get Release-AVR-Configuration.xml

-   **Eclipse** menu: **Project** → **Properties**
    -   expand **C/C++ general**
    -   select Paths and Symbols
    -   click on **Includes** tab
    -   click on **Import Settings...**
    -   click on **Browse**
        -   select **Debug-AVR-Configuration.xml**
        -   click on **Open**
    -   in the Select Configuration select Debug
-   click on Finish

-   repeat for Release with Release-AVR-Configuration.xml

### Create source and include folders

-   create src folder
-   add the main.cpp file
-   create include folder
-   create App_define.h
-   create OS_App_Defines.h

### Update the location of the source folders

-   **Eclipse** menu: **Project** → **Properties**
    -   expand C/C++ general
    -   select **Paths and Symbols**
    -   click on **Source Location** tab
    -   select the **Debug** configuration
    -   click on **Add folder...**
        -   select the src folder
        -   press OK
    -   click on **Add Folder...**
        -   select the **micro-os-plus** folder
        -   click on **OK**
    -   select the root project folder
    -   click on Delete
    -   select the **Release** configuration
    -   click on **Add folder...**
        -   select the src folder
        -   press OK
    -   click on **Add Folder...**
        -   select the **micro-os-plus** folder
        -   click on **OK**
    -   select the root project folder
    -   click on Delete
    -   click on OK

### Add reference to micro-os-plus system project

-   **Eclipse** menu: **Project** → **Properties**
    -   expand C/C++ general
    -   select **Paths and Symbols**
    -   click on **References** tab
    -   select the **Debug** configuration
    -   select micro-os-plus
    -   click on Apply
    -   select the **Release** configuration
    -   select micro-os-plus
    -   click on Apply
    -   click on OK

### Define BOARD

-   **Eclipse** menu: **Project** → **Properties**
    -   expand **C/C++ Build**
    -   select **Build Variables**
    -   select the **Debug** configuration
    -   click on **Add...**
        -   enter Variable name: **BOARD**
        -   enable click on **Apply to all configurations**
        -   leave Type: **String**
        -   enter Value: **ATMEL_STK525** or **ATMEL_EVK1104**
        -   click on **OK**
    -   check if the value as added to all configurations
    -   click on **OK**

### Define DBGDEV

-   **Eclipse** menu: **Project** → **Properties**
    -   expand **C/C++ Build**
    -   select **Build Variables**
    -   select the **Debug** configuration
    -   click on **Add...**
        -   enter Variable name: **DBGDEV**
        -   disable **Apply to all configurations**
        -   leave Type: **String**
        -   enter Value: **I2C**
        -   click on **OK**
    -   check if the value was added only to the Debug configuration
    -   click on **OK**

### Custom architecture configurations

-   **Eclipse** menu: **Project** → **Properties**
    -   expand the **AVR** group
    -   select **Target Hardware**
        -   select the **MCU Type**
        -   select the **MCU Clock Frequency**
        -   click **OK**
    -   if you have a development platform with a micro-controller larger than the production board, select the AVR group and enable **Enable individual settings for Build Configurations**
-   click **OK**

### Rename configurations

Eventually rename the Debug/Release configurations to mark the board used.

The configuration names look like **Debug-Atmel-STK525**.

-   **Eclipse** menu: **Project** → **Build Configurations** → **Manage**

Updating the compile options
----------------------------

### Warnings

-   enable All Warnings -Wall

### Debugging

-   set the debugging info to **-g3** for Debug and to **-g2** or **-g** for Release
-   if available, set the debug info format to **dwarf-2**

### Optimizations

-   set to **-O0**/**-O1** for Debug and **-Os** for Release
-   disable -fpack-struct
-   disable -fshort-enums

### Language Standards

-   set to **-std=gnu99** for C
-   set to **-std=gnu++98** for C++
-   disable -funsigned-char
-   disable -funsigned-bitfields
-   enable -fno-exceptions

### Miscellaneous

-   set C options to: **-Wextra -c -fmessage-length=0 -ffunction-sections -fdata-sections**
-   eventually add to C options: *' -Wa,-adhlns="\$@.lst"*'
-   for C++ add **-Wabi -fno-rtti -fno-exceptions**
-   for -O0/-O1 add **-finline-small-functions**
-   for -Os add the following optimisations: '''-finline-functions -funswitch-loops -fpredictive-commoning -fgcse-after-reload -ftree-vectorize '''

Post build steps
----------------

For environments that do not support additional build steps, like Avr32, you can manually configure a command to generate the disassembler output.

To access the Post build steps, select the desired project (**minimal**, for example), and go to the


**Eclipse** menu: **Project** → **Properties**

-   expand **C/C++ Build**
-   select **Settings**
-   in the right panel, choose the desired configuration, for example **Debug-Atmel-STS525**
-   in the right panel, select the **Build Steps** tab
-   in the Post-build steps, fill-in the following command


avr32-objdump -h -S \${BuildArtifactFileBaseName}.elf \>\${BuildArtifactFileBaseName}.lst

Building projects
=================

Once the project is created, the procedure to build it is:

-   **Eclipse** menu: **Project** → **Build Configurations** → **Set Active** → select desired config
-   **Eclipse** menu: **Project** → **Build Project**
-   monitor the console while the build progresses

Troubleshooting build
=====================

If you missed/messed something during installation or project configuration, you might end with projects partly built.

The first thing to try after changing configuration details is to do a fresh build. For this


**Eclipse** menu: **Project** → **Clean**

-   select **Clean projects selected below**
-   select the current project
-   disable **Start a build immediately**

Project configuration references
================================

ARM
---

Currently the Debug & Release configurations are almost identical, the difference is the compiler optimisation level, -O0 for Debug, -Os for Release, and the DEBUG macro definition, present only on Debug.

Although the definitions and the samples presented below are from a Windows environment, on GNU/Linux and Mac OS X they should be similar, if not identical.

**Important:** Please note that the preprocessor macro definitions and the Includes folders should be defined only once in the C/C++ General → Paths & Symbols page, and will automatically be used in the C/C++ Build → Settings.

### C/C++ General → Paths & Symbols

#### Includes

For all languages

-   **\${ProjDirPath}/include**
-   **\${WorkspaceDirPath}/micro-os-plus/system**

**Important:** Be sure you do not mark them as Workspace path. (don't know why, it seems to be a CDT bug)

These definitions will automatically be reflected in all language **C/C++ Build → Settings**.

#### Symbols

Common to all configurations:

-   **OS_CONFIG_BOARD_\${BOARD} 1**

Present only for Debug, removed from Release:

-   **DEBUG 1**
-   **OS_CONFIG_DEBUG_DEVICE_\${DBGDEV} 1**

These definitions will automatically be reflected in all language **C/C++ Build → Settings**.

#### Library Path

-   **/micro-os-plus** (workspace path)

#### Source Location

-   /...actual project name.../src
-   /...actual project name.../micro-os-plus

#### References

-   none

### C/C++ Build → Settings

#### Tool Settings

-   Target Processor
    -   Processor: **cortex-m3**
    -   enable **Thumb (-mthumb)**
-   Debugging
    -   Debug level: **Maximum (-g3)** ⇐ for Debug | **Default (-g)** ⇐ for Release
    -   Debug format: **dwarf-2**
-   ARM Sourcery Windows GCC Assembler
    -   Preprocessor
        -   enable **Use preprocessor**
        -   Defined symbols (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   DEBUG=1
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Warnings
        -   enable **All warnings (-Wall)**
        -   enable **Extra warnings (-Wextra)**
    -   Miscellaneous
        -   Assembler Listing: **-adhlns="\$@.lst"**
        -   Other flags: **-c -fmessage-length=0**
-   ARM Sourcery Windows GCC C Compiler
    -   Preprocessor
        -   Defined symbols (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   DEBUG=1
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1
    -   Directories
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Optimizations
        -   Optimization level: **None (-O0)** ⇐ for Debug | **Optimize size (-Os)** ⇐ for Release
    -   Warnings
        -   enable **All warnings (-Wall)**
        -   enable **Extra warnings (-Wextra)**
    -   Miscellaneous
        -   Language Standard: **Compiler Default (ISO C90 with GNU extensions)**
        -   Assembler Listing: **-adhlns="\$@.lst"**
        -   enable **Do not inline functions (-fno-inline-functions)**
        -   Other flags: **-c -fmessage-length=0**
-   ARM Sourcery Windows GCC C++ Compiler
    -   Preprocessor
        -   Defined symbols (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   DEBUG=1
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1
    -   Directories
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Optimizations
        -   Optimization level: **None (-O0)** ⇐ for Debug | **Optimize size (-Os)** ⇐ for Release
    -   Warnings
        -   enable **All warnings (-Wall)**
        -   enable **Extra warnings (-Wextra)**
        -   enable **ABI warnings (-Wabi)**
    -   Miscellaneous
        -   Language Standard: **Compiler Default (ISO C90 with GNU extensions)**
        -   Assembler Listing: **-adhlns="\$@.lst"**
        -   enable **Do not inline functions (-fno-inline-functions)**
        -   enable **Do not use exceptions (-fno-exceptions)**
        -   enable **Do not use RTTI (-fno-rtti)**
        -   Other flags: **-c -fmessage-length=0**
-   ARM Sourcery Windows GCC C++ Linker
    -   General
        -   Script file: **\${workspace_loc}\\system\\hal\\boards\\Olimex\\stm32_h103\\stm32_h103_rom.ld** ⇐ board dependent
        -   enable **Do not use standard start files (-nostartfiles)**
        -   enable **Remove unused sections (-Xlinker --gc-sections)**
    -   Libraries
        -   Library search path (-L): **"\${workspace_loc:/micro-os-plus}"**
    -   Miscellaneous
        -   Map Filename: **\${BuildArtifactFileBaseName}.map**
        -   enable **Cross Reference (-Xlinker --cref)**
-   ARM Sourcery Windows GNU Create Flash Image
    -   Output
        -   Output file format (-O): **ihex**
-   ARM Sourcery Windows GNU Create Listing
    -   General
        -   Other flags: **-h -S**
-   ARM Sourcery Windows GNU Print Size
    -   General
        -   Size Format: **Berkeley**

#### Build Steps

-   empty

#### Build Artifacts

-   Artifact name: **\${ProjName}**
-   Artifact extensions: **elf**

#### Binary Parsers

-   enable **GNU Elf Parser**
-   enable **Elf Parser**

#### Error Parsers

-   all except Visual C Error Parser

### Linker script file

The configuration for the linker script files is currently preliminary and might require further updates. For more flexibility, required for example when the flash image should be moved to higher addresses to reserve space for a custom bootloader, the script is split in two parts, one containing the memory definitions, placed in the board folder, and one common to all boards, placed in the arch folder, dynamically included in the first one at link time.

AVR8
----

Currently the Debug & Release configurations are almost identical, the difference is the compiler optimisation level, -O1 for Debug, -Os for Release, and the DEBUG macro definition, present only on Debug. (O1 is used since, according to some old tests, O0 did not work).

Although the definitions and the samples presented below are from a Windows environment, on GNU/Linux and Mac OS X they should be similar, if not identical.

**Important:** Please note that the preprocessor macro definitions and the Includes folders should be defined only once in the C/C++ General → Paths & Symbols page, and will automatically be used in the C/C++ Build → Settings.

### C/C++ General → Paths & Symbols

#### Includes

For all languages

-   **\${ProjDirPath}/include**
-   **\${WorkspaceDirPath}/micro-os-plus**

**Important:** Be sure you do not mark them as Workspace path. (don't know why, it seems to be a CDT bug)

These definitions will automatically be reflected in all language **C/C++ Build → Settings**.

#### Symbols

Common to all configurations:

-   **OS_CONFIG_BOARD_\${BOARD} 1**

Present only for Debug, removed from Release:

-   **DEBUG 1**
-   **OS_CONFIG_DEBUG_DEVICE_\${DBGDEV} 1**

These definitions will automatically be reflected in all language **C/C++ Build → Settings**.

#### Library Path

-   none

#### Source Location

-   /...actual project name.../src
-   /...actual project name.../micro-os-plus

#### References

-   micro-os-plus

(this reference is necessary indirectly, to save files opened from the system project)

### AVR Settings

Click on the Target Hardware and set the MCU Type and the MCU Clock Frequency. (The clock frequency is currently not used in the build).

### C/C++ Build → Settings

#### Tool Settings

-   Additional Tools in Toolchain
    -   Generate HEX file for Flash memory
    -   Generate Extended Listing
    -   Print Size

-   AVR Assembler
    -   General
        -   enable **Use preprocessor**
        -   Other GCC Flags: **-adhlns="\$@.lst"** (optional, if you need the individual listing files)
    -   Paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
        -   "\${ProjDirPath}/include"
        -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Debugging
        -   Generate Debugging Info: **Extra debugging info (-g3)** ⇐ for Debug | **Standard debugging info (-g2)** ⇐ for Release
        -   Debug Info Format: **dwarf-2**
-   AVR Compiler
    -   Directories
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Symbols
        -   Defined syms (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   DEBUG=1
            -   "OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1"
    -   Warnings
        -   enable **All warnings (-Wall)**
    -   Debugging
        -   Generate Debugging Info: **Extra debugging info (-g3)** ⇐ for Debug | **Standard debugging info (-g2)** ⇐ for Release
        -   Debug Info Format: **dwarf-2**
    -   Optimizations
        -   Optimization level: **Slight Optimizations (-O1)** ⇐ for Debug | **Optimize size (-Os)** ⇐ for Release
        -   disable Pack structs (-fpack-struct)
        -   disable Short enums (-fshort-enums)
    -   Language Standard
        -   Language Standard: **ISO C99 + GNU extensions (-std=gnu99)**
        -   disable char is unsigned (-funsigned-char)
        -   disable bitfields are unsigned (-funsigned-bitfields)
    -   Miscellaneous
        -   Other flags for -O0/O1 **-Wextra -fmessage-length=0 -ffunction-sections -fdata-sections -finline-small-functions**
        -   Other flgs for -Os **-Wextra -fmessage-length=0 -ffunction-sections -fdata-sections -finline-functions -funswitch-loops -fpredictive-commoning -fgcse-after-reload -ftree-vectorize**
        -   Other optional flags -Wa,-adhlns="\$@.lst"
-   AVR C++ Compiler
    -   Directories
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Symbols
        -   Defined syms (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   DEBUG=1
            -   "OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1"
    -   Warnings
        -   enable **All warnings (-Wall)**
    -   Debugging
        -   Generate Debugging Info: **Extra debugging info (-g3)** ⇐ for Debug | **Standard debugging info (-g2)** ⇐ for Release
        -   Debug Info Format: **dwarf-2**
    -   Optimizations
        -   Optimization level: **Slight Optimizations (-O1)** ⇐ for Debug | **Optimize size (-Os)** ⇐ for Release
        -   disable Pack structs (-fpack-struct)
        -   disable Short enums (-fshort-enums)
    -   Language Standard
        -   Language Standard: **ISO C98 + GNU extensions (-std=gnu++98)**
        -   disable char is unsigned (-funsigned-char)
        -   disable bitfields are unsigned (-funsigned-bitfields)
        -   enable **Do not use Exceptions (-fno-exceptions)**
    -   Miscellaneous
        -   Other flags for -O0/O1 **-Wextra -Wabi -fno-rtti -fmessage-length=0 -ffunction-sections -fdata-sections -finline-small-functions**
        -   Other flags for -Os **-Wextra -Wabi -fno-rtti -fmessage-length=0 -ffunction-sections -fdata-sections -finline-functions -funswitch-loops -fpredictive-commoning -fgcse-after-reload -ftree-vectorize**
-   ARM C++ Linker
    -   General
        -   Map Filename: **\${BuildArtifactFileBaseName}.map**
    -   Libraries
        -   none
    -   Objects
        -   None
-   AVR Create Extended Listing
    -   General
        -   Options: **-h -S**
        -   Output Filename **\${BuildArtifactFileBaseName}.lss**
-   AVR Create Flash Image
    -   General
        -   Options to create flash imge: **-R .eprom -O ihex**
        -   Output Filename **\${BuildArtifactFileBaseName}.hex**
-   AVR Print Size
    -   General
        -   Size Format: **AVR Format**

#### Build Steps

-   empty

#### Build Artifacts

-   Artifact name: **\${ProjName}**
-   Artifact extensions: **elf**

#### Binary Parsers

-   enable **GNU Elf Parser**
-   enable **Elf Parser**

#### Error Parsers

-   all except Visual C Error Parser and pushd/popd CWD Locator

AVR32
-----

Currently the Debug & Release configurations are almost identical, the difference is the compiler optimisation level, -O0 for Debug, -Os for Release, and the DEBUG macro definition, present only on Debug.

Although the definitions and the samples presented below are from a Windows environment, on GNU/Linux and Mac OS X they should be similar, if not identical.

**Important:** Please note that the preprocessor macro definitions and the Includes folders should be defined only once in the C/C++ General → Paths & Symbols page, and will automatically be used in the C/C++ Build → Settings.

### C/C++ Build → Build Variables

BOARD=ATMEL_EVK1104

DBGDEV=I2C

### C/C++ General → Paths & Symbols

#### Includes

For all languages

-   **\${ProjDirPath}/include**
-   **\${WorkspaceDirPath}/micro-os-plus/system**

**Important:** Be sure you do not mark them as Workspace path. (don't know why, it seems to be a CDT bug)

These definitions will automatically be reflected in all language **C/C++ Build → Settings**.

#### Symbols

Common to all configurations:

-   **OS_CONFIG_BOARD_\${BOARD} 1**

Present only for Debug, removed from Release:

-   **DEBUG 1**
-   **OS_CONFIG_DEBUG_DEVICE_\${DBGDEV} 1**

These definitions will automatically be reflected in all language **C/C++ Build → Settings**.

#### Libraries

-   none

#### Library Path

-   **/micro-os-plus** as Workspace path

#### Source Location

-   /...actual project name.../src
-   /...actual project name.../micro-os-plus

#### References

-   **micro-os-plus**

### C/C++ Build → Settings

#### Tool Settings

-   32-bit AVR/GNU C++ Compiler
    -   Preprocessor
        -   Defined symbols (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   DEBUG=1
            -   OS_CONFIG_DEBUG_DEVICE_\${DBGDEV}=1
    -   Includes
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Optimizations
        -   Optimization Level: **None (-O0)** ⇐ for Debug | **Optimize for size (-Os)** ⇐ for Release
        -   enable **Prepare functions for garbage collection**
        -   enable **Use assembler for pseudo instructions**
        -   disable all others
    -   Debugging
        -   Generate Debugging Info: **Maximum (-g3)** ⇐ for Debug | **Default (-g)** ⇐ for Release
    -   Warnings
        -   enable **All warnings (-Wall)**
    -   Miscellaneous
        -   Other flags **-c -fmessage-length=0 -fno-exceptions -fno-rtti -Wextra -Wabi -std=gnu++98 -fdata-sections**
-   32-bit AVR/GNU Compiler
    -   Preprocessor
        -   (none)
    -   Symbols
        -   Defined symbols (-D) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "OS_CONFIG_BOARD_\${BOARD}=1"
            -   DEBUG=1
            -   OS_CONFIG_DEBUG_DEVICE_I2C=1
    -   Includes
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Optimizations
        -   Optimization level: **None (-O0)** ⇐ for Debug | **Optimize size (-Os)** ⇐ for Release
        -   enable **Use assembler for pseudo instructions**
    -   Debugging
        -   Generate Debugging Info: **Maximum (-g3)** ⇐ for Debug | **Default (-g)** ⇐ for Release
    -   Warnings
        -   enable **All warnings (-Wall)**
    -   Miscellaneous
        -   Other flags **-c -fmessage-length=0 -Wextra -std=gnu99 -ffunction-sections -fdata-sections**

-   32-bit AVR/GNU C++ Linker
    -   General
        -   enable **Do not use standard start files**
    -   Libraries
        -   Library search path: "\${workspace_loc:/micro-os-plus}"
    -   Miscellaneous
        -   Linker flags: -Wl,-Map,\${BuildArtifactFileBaseName}.map -Xlinker --cref -Wl,-e,_trampoline -T "\${workspace_loc}/micro-os-plus/hal/arch/avr32/uc3/lib/link_uc3a3256.lds"
    -   Shared Library Settings
        -   (none)
    -   Optimizations
        -   Enable **Garbage collect unused sections**
        -   Enable **Direct references to the data section** [Q: what is this good for?]
        -   Disable **Put read-only data in writable data section**
        -   Disable all other
-   32-bit AVR/GNU Assembler
    -   General
        -   Assembler flags: (none)
        -   Include paths (-I) ⇐ reflect the **C/C++ General → Paths & Symbols** definitions
            -   "\${ProjDirPath}/include"
            -   "\${WorkspaceDirPath}/micro-os-plus"
    -   Debugging
        -   Debug Level: **Maximum (-g3)** ⇐ for Debug | **Default (-g)** ⇐ for Release

#### Build Steps

-   empty

#### Build Artifacts

-   Artifact name: **\${ProjName}**
-   Artifact extensions: **elf**

#### Binary Parsers

-   enable **AVR32/GNU Elf Parser**

#### Error Parsers

-   all except Visual C Error Parser and pushd/popd CWD Locator

### MCU Settings

Click on the Target Device and set the MCU Type.

Sample Build Outputs
====================

ARM
---

A sample build output on Windows looks like this:


    **** Build of configuration Debug-Olimex-STM32-H103 for project minimal ****

    cs-make all
    Building file: H:/My Files/MacMini Vault/Projects/Eclipse Workspaces/36 Win/uOS Dev 2/system/portable/tasks/src/CANLeds.cpp
    Invoking: ARM Sourcery Windows GCC C++ Compiler
    arm-none-eabi-g++ -DDEBUG=1 -DOS_CONFIG_DEBUG_DEVICE_I2C=1 -D"OS_CONFIG_BOARD_OLIMEX_STM32_H103=1"
    -I"H:/My Files/MacMini Vault/Projects/Eclipse Workspaces/36 Win/uOS Dev 2/minimal/include"
    -I"H:\My Files\MacMini Vault\Projects\Eclipse Workspaces\36 Win\uOS Dev 2/system" -O0 -Wall
    -Wa,-adhlns="system/portable/tasks/src/CANLeds.o.lst" -fno-exceptions -fno-rtti -c -fmessage-length=0
    -MMD -MP -MF"system/portable/tasks/src/CANLeds.d" -MT"system/portable/tasks/src/CANLeds.d"
    -mcpu=cortex-m3 -mthumb -g -gdwarf-2 -o"system/portable/tasks/src/CANLeds.o"
    "H:/My Files/MacMini Vault/Projects/Eclipse Workspaces/36 Win/uOS Dev 2/system/portable/tasks/src/CANLeds.cpp"
    Finished building: H:/My Files/MacMini Vault/Projects/Eclipse Workspaces/36 Win/uOS Dev 2/system/portable/tasks/src/CANLeds.cpp

    ...

    Building target: minimal.elf
    Invoking: ARM Sourcery Windows GCC C++ Linker
    arm-none-eabi-g++
    -T"H:\My Files\MacMini Vault\Projects\Eclipse Workspaces\36 Win\uOS Dev 2\system\hal\boards\Olimex\stm32_h103\stm32_h103_rom.ld"
    -nostartfiles -Xlinker --gc-sections -Xlinker --print-gc-sections
    -L"H:\My Files\MacMini Vault\Projects\Eclipse Workspaces\36 Win\uOS Dev 2\system"
    -Wl,-Map,minimal.map -Xlinker --cref -mcpu=cortex-m3 -mthumb -g -gdwarf-2 -o"minimal.elf"
    ./system/portable/tasks/src/CANLeds.o ./system/portable/tasks/src/TaskBlink.o ./system/portable/tasks/src/TaskPitpalac.o
    ./system/portable/stdlib/src/ios.o ./system/portable/stdlib/src/iostream.o ./system/portable/stdlib/src/istream.o
    ./system/portable/stdlib/src/ostream.o ./system/portable/stdlib/src/streambuf.o  ./system/portable/misc/src/CircularBlockBuffer.o
    ./system/portable/misc/src/CircularByteBuffer.o ./system/portable/misc/src/Parser.o ./system/portable/misc/src/SimpleCli.o
    ./system/portable/misc/src/uOS.o  ./system/portable/kernel/src/OS.o ./system/portable/kernel/src/OSEventFlags.o
    ./system/portable/kernel/src/OSMutex.o ./system/portable/kernel/src/OSScheduler.o ./system/portable/kernel/src/OSTask.o
    ./system/portable/kernel/src/OSTaskIdle.o ./system/portable/kernel/src/OSTimer.o ./system/portable/kernel/src/OSTimerSeconds.o
    ./system/portable/kernel/src/OSTimerTicks.o ./system/portable/kernel/src/Timer.o ./system/portable/kernel/src/ostream_OSTask.o
    ./system/portable/devices/usb/src/OSUsbDevice.o ./system/portable/devices/usb/src/OSUsbDeviceDescriptors.o
    ./system/portable/devices/sdi12/src/SDI12BootLoader.o ./system/portable/devices/sdi12/src/SDI12Sensor.o
    ./system/portable/devices/misc/src/DeviceLM74.o ./system/portable/devices/misc/src/DeviceMCP2510.o
    ./system/portable/devices/misc/src/DeviceRTC4574.o ./system/portable/devices/misc/src/DeviceSPIUsart.o
    ./system/portable/devices/misc/src/PinChangeDispatchers.o  ./system/portable/devices/debug/src/DeviceDebugI2C.o
    ./system/portable/devices/debug/src/OSDeviceDebug.o  ./system/portable/devices/character/src/DeviceCharacterMultiUsart0.o
    ./system/portable/devices/character/src/DeviceCharacterMultiUsart1.o ./system/portable/devices/character/src/DeviceCharacterUsart.o
    ./system/portable/devices/character/src/DeviceCharacterUsart0.o ./system/portable/devices/character/src/DeviceCharacterUsart1.o
    ./system/portable/devices/character/src/DeviceCharacterUsb.o ./system/portable/devices/character/src/OSDeviceCharacter.o
    ./system/portable/devices/character/src/OSDeviceCharacterBuffered.o  ./system/portable/devices/block/src/CANPacket.o
    ./system/portable/devices/block/src/DeviceMemCard.o ./system/portable/devices/block/src/DeviceMemCardSPI.o
    ./system/portable/devices/block/src/OSDeviceCAN.o  ./system/hal/boards/Metrilog/m512/src/SDI12Sensor_Implementation.o
    ./system/hal/arch/avr/kernel/src/OSScheduler_Implementation.o ./system/hal/arch/avr/kernel/src/OSTimer_Implementation.o
    ./system/hal/arch/avr/kernel/src/OS_Implementation.o ./system/hal/arch/avr/kernel/src/ostream_ProgramPtr.o
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
    ./system/hal/arch/arm_cortex_m3/devices/debug/src/OSDeviceDebug_Arch_Implementation.o  ./src/main.o

    Finished building target: minimal.elf

    Invoking: ARM Sourcery Windows GNU Create Flash Image
    arm-none-eabi-objcopy -O ihex minimal.elf "minimal.hex"
    Finished building: minimal.hex

    Invoking: ARM Sourcery Windows GNU Create Listing
    arm-none-eabi-objdump -h -S minimal.elf >"minimal.lst"
    Finished building: minimal.lst

    Invoking: ARM Sourcery Windows GNU Print Size
    arm-none-eabi-size  --format=berkeley minimal.elf
       text    data     bss     dec     hex filename
      12356     672     600   13628    353c minimal.elf
    Finished building: minimal.siz