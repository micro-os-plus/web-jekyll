---
layout: page
lang: en
permalink: /develop/modular-projects/
title: Modular projects
author: Liviu Ionescu

date: 2017-09-26 13:05:00 +0300

---

## Objectives & benefits

### Challenges

One of the major challenges when developing software is reusing various pieces of code among applications and sharing code with other developers.

The trivial approach is to simply copy/paste routines or entire files from one application to another. This is ok as long as the code does not change; once the code changes, manually updating all projects is no longer trivial.

A slightly better solution is to create separate libraries, and include them _as is_ in different projects. Initially this may look ok, but when having many libraries, especially with multiple inter-dependencies, knowing which libraries are compatible with each other may no longer be as easy as expected.

The problem is aggravated by the fact that each library has its own life cycle, and new versions may no longer be compatible with existing or newer versions of any of the other libraries.

### Solution

Instead of a monolithic project, where the build process has to deal with a complicated folder hierarchy, one possible solution is to build the project from separate components, stored as one or more files in separate packages.

In practical terms, each package should have, in addition to the source files, some **metadata**, to define its own **identity** and a list of **dependencies** from other packages.

### Benefits

This modular approach with structured metadata greatly increase the code **reusability** and **upgradeability**, by allowing automated tools to bring into the project the required components, and to automatically manage the dependencies, accepting only combinations of compatible packages.

Such solutions are already available for other languages, the most successful one being [npm](https://www.npmjs.com) (The Node Package Manager), for Node.js/JavaScript modules.

There were also several attempts to create similar solutions for C/C++ embedded applications, but they had limited success (for example CMSIS Packs, which uses huge packages and is more or less specific to Keil MDK, and yotta, originally from ARM mbed, now abandoned, based upon cmake and python).

The current proposal uses a new technology, called **xPack**, that addresses the management of multi-version packages (for both source code and binary tools), and provides support for an automated build process, advanced application configuration and convenient debug (the [project web](https://xpack.github.io) site is currently under construction).

## Examples

The following examples use the new SiFive project templates, that generate functional projects for the current SiFive boards (**HiFive1**, **Coreplex E31 Arty**, **Coreplex E51 Arty**).

The templates can be invoked both from **command line** environments and from **GNU MCU Eclipse**.

### Command line usage

To create a new project based on existing xPacks, the most convenient way is to use a project template.

Create an empty folder and invoke `xpm init` in interactive mode, pointing to the desired template.

```
$ mkdir -p /tmp/hifive1-blinky-cpp
$ cd /tmp/hifive1-blinky-cpp
$ xpm init --template @sifive/coreplex-templates
Generate a SiFive Coreplex C/C++ project

Programming language? (c, cpp, ?) [cpp]:
Board? (hifive1, e31arty, e51arty, ?) [hifive1]:
Content? (empty, blinky, ?) [blinky]:
Use system calls? (none, retarget, ?) [retarget]:
Trace output? (none, uart0ftdi, ?) [uart0ftdi]:
Check some warnings? (true, false, ?) [true]:
Check most warnings? (true, false, ?) [false]:
Enable -Werror? (true, false, ?) [false]:
Use -Og on debug? (true, false, ?) [false]:
Use newlib nano? (true, false, ?) [true]:

Creating the C++ project 'hifive1-blinky-cpp'...
File 'LICENSE' generated.
File 'oocd.launch' generated.
File 'package.json' generated.
File 'README.md' generated.
File 'xmake.json' generated.
File 'include/led.h' copied.
File 'include/sysclock.h' copied.
File 'ldscripts/libs.ld' copied.
File 'ldscripts/mem.ld' copied.
File 'ldscripts/sections.ld' copied.
File 'src/initialize-hardware.cpp' generated.
File 'src/interrupts-handlers.cpp' generated.
File 'src/led.cpp' copied.
File 'src/main.cpp' generated.
File 'src/newlib-syscalls.c' copied.
File 'src/sysclock.cpp' copied.
Folder 'xpacks/micro-os-plus-c-libs' copied.
Folder 'xpacks/micro-os-plus-cpp-libs' copied.
Folder 'xpacks/micro-os-plus-diag-trace' copied.
Folder 'xpacks/micro-os-plus-riscv-arch' copied.
Folder 'xpacks/micro-os-plus-startup' copied.
Folder 'xpacks/sifive-hifive1-board' copied.
Folder 'xpacks/sifive-coreplex-devices' copied.

'xpm init' completed in 253 ms.
```

In the interactive part, at any time it is possible to ask for more details by entering a question mark:

```
$ xpm init --template @sifive/coreplex-templates
Generate a SiFive Coreplex C/C++ project

Programming language? (c, cpp, ?) [cpp]: ?
Select the preferred programming language
- C for the application files, C and C++ for the system
- C++ for the application files, C++ and C for the system
Programming language? (c, cpp, ?) [cpp]:
Board? (hifive1, e31arty, e51arty, ?) [hifive1]: ?
Select the SiFive board name
- Freedom E310 HiFive1
- Coreplex E31 Arty
- Coreplex E51 Arty
Board? (hifive1, e31arty, e51arty, ?) [hifive1]:
Content? (empty, blinky, ?) [blinky]: ?
Choose the project content
- Empty (add your own content)
- Blinky (blink one or more LEDs)
Content? (empty, blinky, ?) [blinky]:
Use system calls? (none, retarget, ?) [retarget]: ?
Control how system calls are implemented
- Freestanding (no POSIX system calls)
- POSIX (system calls implemented by application code)
Use system calls? (none, retarget, ?) [retarget]:
Trace output? (none, uart0ftdi, ?) [uart0ftdi]: ?
Control where the trace output messages are forwarded
- None (no trace output)
- UART0 (via FTDI)
Trace output? (none, uart0ftdi, ?) [uart0ftdi]:
Check some warnings? (true, false, ?) [true]: ?
Enable -Wall and -Wextra to catch most common warnings
Check some warnings? (true, false, ?) [true]:
Check most warnings? (true, false, ?) [false]: ?
Enable as many warnings as possible
Check most warnings? (true, false, ?) [false]:
Enable -Werror? (true, false, ?) [false]: ?
Instruct the compiler to stop on warnings
Enable -Werror? (true, false, ?) [false]:
Use -Og on debug? (true, false, ?) [false]: ?
Use the new optimization flag for the debug configurations
Use -Og on debug? (true, false, ?) [false]:
Use newlib nano? (true, false, ?) [true]: ?
Use the size optimised version of newlib
Use newlib nano? (true, false, ?) [true]:

Creating the C++ project 'hifive1-blinky-cpp'...
...
```

For scripting environments (like automated tests), it is also possible to pass all configuration choices as command line options. The only mandatory property is `boardName`, all other have reasonable defaults:

```
$ xpm init --template @sifive/coreplex-templates --property boardName=hifive1
Generate a SiFive Coreplex C/C++ project

Creating the C++ project 'hifive1-blinky-cpp'...
- boardName=hifive1
- content=blinky
- syscalls=retarget
- trace=uart0ftdi
- useSomeWarnings=true
- useMostWarnings=false
- useWerror=false
- useOg=false
- useNano=true

File 'LICENSE' generated.
File 'oocd.launch' generated.
File 'package.json' generated.
File 'README.md' generated.
File 'xmake.json' generated.
File 'include/led.h' copied.
File 'include/sysclock.h' copied.
File 'ldscripts/libs.ld' copied.
File 'ldscripts/mem.ld' copied.
File 'ldscripts/sections.ld' copied.
File 'src/initialize-hardware.cpp' generated.
File 'src/interrupts-handlers.cpp' generated.
File 'src/led.cpp' copied.
File 'src/main.cpp' generated.
File 'src/newlib-syscalls.c' copied.
File 'src/sysclock.cpp' copied.
Folder 'xpacks/micro-os-plus-c-libs' copied.
Folder 'xpacks/micro-os-plus-cpp-libs' copied.
Folder 'xpacks/micro-os-plus-diag-trace' copied.
Folder 'xpacks/micro-os-plus-riscv-arch' copied.
Folder 'xpacks/micro-os-plus-startup' copied.
Folder 'xpacks/sifive-hifive1-board' copied.
Folder 'xpacks/sifive-coreplex-devices' copied.

'xpm init' completed in 176 ms.
```

Both methods produce the same result. The project itself is quite generic, and does not include any `make` files, or any other specific build system files. Instead, it includes a structured file (`xmake.json`) that contains all required details for an automated tool to generate the specific build system files.

The approach is similar to `cmake`, just that instead of using a proprietary scripting language (with a syntax not at all easy to parse), it uses a JSON file, which can be easily parsed by any 3rd party tools.

The first such tool is `xmake`, the xPack builder; it consumes `xmake.json` directly and generates `make` files. Future versions will also import/export Eclipse CDT configurations.

To build the project, the standard method is to use `xpm build`, which, for the current project, invokes `xmake build`, which performs the following steps:

* create the usual debug and release build configurations
* generate the `make` files
* finally invoke `make` to run the actual build.

```console
$ xpm build
Build the package

Changing current folder to '/tmp/hifive1-blinky-cpp'...
Invoking 'xmake build -- all'...

Build one or all project configurations

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'debug'...
Generating 'make' files...
'make' files generated in 90 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug'...

Invoking builder: 'make all'...
[riscv64-unknown-elf-gcc]: src/newlib-syscalls.c
[riscv64-unknown-elf-g++]: src/initialize-hardware.cpp
[riscv64-unknown-elf-g++]: src/interrupts-handlers.cpp
[riscv64-unknown-elf-g++]: src/led.cpp
[riscv64-unknown-elf-g++]: src/main.cpp
[riscv64-unknown-elf-g++]: src/sysclock.cpp
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/_sbrk.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/c-syscalls-empty.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/stdlib/assert.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/stdlib/exit.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/stdlib/init-fini.c
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-c-libs/src/stdlib/atexit.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-cpp-libs/src/cxx.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-diag-trace/src/trace.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-riscv-arch/src/arch-functions.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-riscv-arch/src/traps.cpp
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-riscv-arch/src/reset-entry.S
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-riscv-arch/src/trap-entry.S
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-startup/src/startup.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-coreplex-devices/src/device-functions.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-coreplex-devices/src/device-interrupts.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-coreplex-devices/src/plic-functions.cpp
[riscv64-unknown-elf-gcc]: xpacks/sifive-coreplex-devices/src/sifive/fe300prci_driver.c
[riscv64-unknown-elf-g++]: xpacks/sifive-hifive1-board/src/board-functions.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-hifive1-board/src/trace-uart.cpp
[riscv64-unknown-elf-g++]: hifive1-blinky-cpp.elf
'make all' completed in 5.705 sec.

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'release'...
Generating 'make' files...
'make' files generated in 76 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-release'...

Invoking builder: 'make all'...
[riscv64-unknown-elf-gcc]: src/newlib-syscalls.c
[riscv64-unknown-elf-g++]: src/initialize-hardware.cpp
[riscv64-unknown-elf-g++]: src/interrupts-handlers.cpp
[riscv64-unknown-elf-g++]: src/led.cpp
[riscv64-unknown-elf-g++]: src/main.cpp
[riscv64-unknown-elf-g++]: src/sysclock.cpp
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/_sbrk.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/c-syscalls-empty.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/stdlib/assert.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/stdlib/exit.c
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-c-libs/src/stdlib/init-fini.c
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-c-libs/src/stdlib/atexit.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-cpp-libs/src/cxx.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-diag-trace/src/trace.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-riscv-arch/src/arch-functions.cpp
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-riscv-arch/src/traps.cpp
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-riscv-arch/src/reset-entry.S
[riscv64-unknown-elf-gcc]: xpacks/micro-os-plus-riscv-arch/src/trap-entry.S
[riscv64-unknown-elf-g++]: xpacks/micro-os-plus-startup/src/startup.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-coreplex-devices/src/device-functions.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-coreplex-devices/src/device-interrupts.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-coreplex-devices/src/plic-functions.cpp
[riscv64-unknown-elf-gcc]: xpacks/sifive-coreplex-devices/src/sifive/fe300prci_driver.c
[riscv64-unknown-elf-g++]: xpacks/sifive-hifive1-board/src/board-functions.cpp
[riscv64-unknown-elf-g++]: xpacks/sifive-hifive1-board/src/trace-uart.cpp
[riscv64-unknown-elf-g++]: hifive1-blinky-cpp.elf
'make all' completed in 5.199 sec.

'xmake build' completed in 11.157 sec.

'xpm build' completed in 11.346 sec.
```

As for any modern builder, subsequent invocations process only the changed files, if any:

```console
$ xpm build
Build the package

Changing current folder to '/tmp/hifive1-blinky-cpp'...
Invoking 'xmake build -- all'...

Build one or all project configurations

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'debug'...
Generating 'make' files...
'make' files generated in 87 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug'...

Invoking builder: 'make all'...
make: Nothing to be done for `all'.
'make all' completed in 52 ms.

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'release'...
Generating 'make' files...
'make' files generated in 82 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-release'...

Invoking builder: 'make all'...
make: Nothing to be done for `all'.
'make all' completed in 51 ms.

'xmake build' completed in 350 ms.

'xpm build' completed in 538 ms.
```

To clean all builds, the project includes a `clean` script, which invokes `xmake`, which finally invokes `make` with the `clean` target:

```console
$ xpm run clean
Run package specific script

Changing current folder to '/tmp/hifive1-blinky-cpp'...
Invoking 'xmake build -- clean'...

Build one or all project configurations

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'debug'...
Generating 'make' files...
'make' files generated in 86 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug'...

Invoking builder: 'make clean'...
[rm]: *
Build completed in 52 ms.

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'release'...
Generating 'make' files...
'make' files generated in 84 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-release'...

Invoking builder: 'make clean'...
[rm]: *
Build completed in 48 ms.

'xmake build' completed in 350 ms.

'xpm run clean' completed in 530 ms.
```

An even more verbose output can be obtained by invoking `xmake` with the `-v` option:

```console
$ xmake build -v
Build one or all project configurations

Generating the build files for 'hifive1-blinky-cpp', target 'hifive1', toolchain 'riscv64-elf-gcc', profile 'debug'...

Source folders: 'src', 'xpacks/micro-os-plus-c-libs/src', 'xpacks/micro-os-plus-c-libs/src/stdlib', 'xpacks/micro-os-plus-cpp-libs/src', 'xpacks/micro-os-plus-diag-trace/src', 'xpacks/micro-os-plus-riscv-arch/src', 'xpacks/micro-os-plus-startup/src', 'xpacks/sifive-coreplex-devices/src', 'xpacks/sifive-coreplex-devices/src/sifive', 'xpacks/sifive-hifive1-board/src'
Include folders: 'include', 'xpacks/micro-os-plus-c-libs/include', 'xpacks/micro-os-plus-cpp-libs/include', 'xpacks/micro-os-plus-diag-trace/include', 'xpacks/micro-os-plus-riscv-arch/include', 'xpacks/micro-os-plus-startup/include', 'xpacks/sifive-coreplex-devices/include', 'xpacks/sifive-hifive1-board/include'
Tool C: -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8  -g3   -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -std=gnu11 -Wall -Wextra    -DSIFIVE_FREEDOM_E310 -DSIFIVE_HIFIVE1_BOARD -DDEBUG -DOS_USE_TRACE_UART0 -DTRACE
Tool C++: -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8  -g3   -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -std=gnu++14 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -Wall -Wextra    -DSIFIVE_FREEDOM_E310 -DSIFIVE_HIFIVE1_BOARD -DDEBUG -DOS_USE_TRACE_UART0 -DTRACE
Tool AS: -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8  -g3   -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections   -Wall -Wextra    -x assembler-with-cpp -DSIFIVE_FREEDOM_E310 -DSIFIVE_HIFIVE1_BOARD -DDEBUG -DOS_USE_TRACE_UART0 -DTRACE
Tool Linker: -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8  -g3   -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections   -Wall -Wextra    -nostartfiles -Xlinker --gc-sections --specs=nano.specs -L"../../ldscripts" -T mem.ld -T libs.ld -T sections.ld

Creating folder 'src'...
Creating folder 'xpacks/micro-os-plus-c-libs/src'...
Creating folder 'xpacks/micro-os-plus-c-libs/src/stdlib'...
Creating folder 'xpacks/micro-os-plus-cpp-libs/src'...
Creating folder 'xpacks/micro-os-plus-diag-trace/src'...
Creating folder 'xpacks/micro-os-plus-riscv-arch/src'...
Creating folder 'xpacks/micro-os-plus-startup/src'...
Creating folder 'xpacks/sifive-coreplex-devices/src'...
Creating folder 'xpacks/sifive-coreplex-devices/src/sifive'...
Creating folder 'xpacks/sifive-hifive1-board/src'...

Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/makefile'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/objects.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/variables.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-c-libs/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-c-libs/src/stdlib/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-cpp-libs/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-diag-trace/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-riscv-arch/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-startup/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/sifive-coreplex-devices/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/sifive-coreplex-devices/src/sifive/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/sifive-hifive1-board/src/subdir.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-c-libs/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-c-libs/src/stdlib/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-cpp-libs/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-diag-trace/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-riscv-arch/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/micro-os-plus-startup/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/sifive-coreplex-devices/src/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/sifive-coreplex-devices/src/sifive/sources.mk'...
Generating file 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug/xpacks/sifive-hifive1-board/src/sources.mk'...

'make' files generated in 89 ms.

Changing current folder to 'build/hifive1-blinky-cpp-hifive1-riscv64-elf-gcc-debug'...

Invoking builder: 'make'...

Building file: src/newlib-syscalls.c
Invoking: GCC C Compiler
riscv64-unknown-elf-gcc -c -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8  -g3   -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections  -std=gnu11 -Wall -Wextra    -DSIFIVE_FREEDOM_E310 -DSIFIVE_HIFIVE1_BOARD -DDEBUG -DOS_USE_TRACE_UART0 -DTRACE  -I"../../include" -I"../../xpacks/micro-os-plus-c-libs/include" -I"../../xpacks/micro-os-plus-cpp-libs/include" -I"../../xpacks/micro-os-plus-diag-trace/include" -I"../../xpacks/micro-os-plus-riscv-arch/include" -I"../../xpacks/micro-os-plus-startup/include" -I"../../xpacks/sifive-coreplex-devices/include" -I"../../xpacks/sifive-hifive1-board/include" -MMD -MP -MF"src/newlib-syscalls.d" -MT"src/newlib-syscalls.o" -o "src/newlib-syscalls.o" "../../src/newlib-syscalls.c"
Finished building: src/newlib-syscalls.c
...
Building target: hifive1-blinky-cpp.elf
Invoking: GCC Linker
riscv64-unknown-elf-g++ -march=rv32imac -mabi=ilp32 -mcmodel=medany -msmall-data-limit=8  -g3   -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections   -Wall -Wextra    -nostartfiles -Xlinker --gc-sections --specs=nano.specs -L"../../ldscripts" -T mem.ld -T libs.ld -T sections.ld src/newlib-syscalls.o src/initialize-hardware.o src/interrupts-handlers.o src/led.o src/main.o src/sysclock.o xpacks/micro-os-plus-c-libs/src/_sbrk.o xpacks/micro-os-plus-c-libs/src/c-syscalls-empty.o xpacks/micro-os-plus-c-libs/src/stdlib/assert.o xpacks/micro-os-plus-c-libs/src/stdlib/exit.o xpacks/micro-os-plus-c-libs/src/stdlib/init-fini.o xpacks/micro-os-plus-c-libs/src/stdlib/atexit.o xpacks/micro-os-plus-cpp-libs/src/cxx.o xpacks/micro-os-plus-diag-trace/src/trace.o xpacks/micro-os-plus-riscv-arch/src/arch-functions.o xpacks/micro-os-plus-riscv-arch/src/traps.o xpacks/micro-os-plus-riscv-arch/src/reset-entry.o xpacks/micro-os-plus-riscv-arch/src/trap-entry.o xpacks/micro-os-plus-startup/src/startup.o xpacks/sifive-coreplex-devices/src/device-functions.o xpacks/sifive-coreplex-devices/src/device-interrupts.o xpacks/sifive-coreplex-devices/src/plic-functions.o xpacks/sifive-coreplex-devices/src/sifive/fe300prci_driver.o xpacks/sifive-hifive1-board/src/board-functions.o xpacks/sifive-hifive1-board/src/trace-uart.o   -o "hifive1-blinky-cpp.elf"
Finished building target: hifive1-blinky-cpp.elf
Build completed in 5.580 sec.
...
'xmake build' completed in 10.799 sec.
```

Note: at the time of preparing this page, the `xpm` tool is under development and the generic `xpm init` mechanism is not yet functional. As a temporary workaround, use the `xpm-init-sifive-coreplex-project` tool, available in the `@sifive/templates` [xPack](https://www.npmjs.com/package/@sifive/templates).

### Eclipse project

To create a new Eclipse project, start the new project wizard (File → New → C++ Project), enter a name and select **SiFive C/C++ Project**:

![New SiFive C++ project]({{ site.baseurl }}/assets/images/2017/new-sifive-cpp.png)

Select the board (HiFive1, Coreplex E31 Arty, Coreplex E51 Arty), the content (Empty, Blinky), and set the other configuration options:

![New SiFive C++ project settings]({{ site.baseurl }}/assets/images/2017/new-sifive-cpp-settings.png)

The result is a project with the following structure:

![HiFive1 blinky]({{ site.baseurl }}/assets/images/2017/hifive1-blinky-cpp.png)

Build the project as usual and possibly run/debug it on the board.

Note: Note: at the time of preparing this page, the SiFive C/C++ project template is available only from the experimental update site  [http://gnu-mcu-eclipse.netlify.com/v4-neon-updates-experimental/](http://gnu-mcu-eclipse.netlify.com/v4-neon-updates-experimental/).

## Project structure

### Application vs packages

In the proposed modular approach, the application code is clearly separated from the external packages; the application folders are under full control of the user, who can edit/add/remove any files, while the packages are under the strict control of the package manager, and generally are read only, to prevent inadvertent changes.

### Example

The **SiFive project templates** created in the previous sections use this structure; most of the files are part of the application; the packages are grouped under the `xpacks` folder, and the package metadata is located in `package.json` and `xmake.json`:

```console
$ tree -L 2 hifive1-blinky-cpp
hifive1-blinky-cpp
├── LICENSE
├── README.md
├── include
│   ├── led.h
│   └── sysclock.h
├── ldscripts
│   ├── libs.ld
│   ├── mem.ld
│   └── sections.ld
├── oocd.launch
├── package.json
├── src
│   ├── initialize-hardware.cpp
│   ├── interrupts-handlers.cpp
│   ├── led.cpp
│   ├── main.cpp
│   ├── newlib-syscalls.c
│   └── sysclock.cpp
├── xmake.json
└── xpacks
    ├── micro-os-plus-c-libs
    ├── micro-os-plus-cpp-libs
    ├── micro-os-plus-diag-trace
    ├── micro-os-plus-riscv-arch
    ├── micro-os-plus-startup
    ├── sifive-coreplex-devices
    └── sifive-hifive1-board

11 directories, 16 files
```

### Dependencies

Each package keeps a list of dependencies to other packages, and the package manager ensures that all required packages are downloaded and made available to the project before the build starts.

For the above project, the `package.json` file includes the following dependencies:

```json
{
  "...": "...",
  "dependencies": {},
  "devDependencies": {
    "xmake": "~0.3.5"
  },
  "xpack": {
    "dependencies": {
      "@micro-os-plus/diag-trace": "~1.0.2",
      "@sifive/hifive1-board": "~0.0.5"
    },
    "devDependencies": {
      "@gnu-mcu-eclipse/riscv-none-gcc": "~0.0.1",
      "@gnu-mcu-eclipse/openocd": "~0.0.1"
    }
  }
}
```

In other words, the application requires explicit support only for diagnostics and for the **SiFive HiFive1** board. Inspecting the project's structure, it is easy to identify seven packages, not two. The explanation is that the `@sifive/hifive1-board` xPack pulled `@sifive/coreplex-devices`, which pulled `@micro-os-plus/riscv-arch`, which pulled `@micro-os-plus/startup` and the two libraries.

### Tools

To further automate the build process, xPacks can refer not only to other **source packages**, but to **tools packages**, which include separate applications required during the development cycle, like toolchains, debuggers, builders, etc.

This is a very powerful feature, that ensures, in a portable way, that a built process can be started immediately after the install is completed.

In the current project, there are three tools required during development:

* `xmake`
* `@gnu-mcu-eclipse/riscv-none-gcc`
* `@gnu-mcu-eclipse/openocd`

`xmake` is a `npm` module, and is installed in `node_modules`, as required by the Node.js specifications.

The other two are tool xPacks; they download and install, in a central location, platform specific binaries for the toolchain and OpenOCD, and make the path available to the current xPack.

All tools are installed in version specific folders, so it is perfectl possible for different xPacks to use different versions of the same tools (for example multiple toolchain versions).

## Embedded projects specifics

### The startup code

Traditionally, the startup code is written in assembly, the justification being that, right after reset, the run-time is not yet suitable for higher level languages, like C/C++. For some modern architectures, like Cortex-M, this is not necessary, since the core automatically loads the stack pointer before calling the `Reset_Handler`, and the startup code can be written in C/C++ from the very beginning (assuming some extra attention when using global variables and avoid excessive optimizations).

#### The assembly entry code

The more traditional architectures still require some small assembly code to explicitly set several registers.

For RISC-V, the current architecture specs require to manually load the SP and GP registers. However, after preparing these registers, it is perfectly possible to pass control to a portable C/C++ function, traditionally named `_start()`:

```as
	.section	.reset_entry,"ax",@progbits
	.align		2 // number of low order zeros, i.e. align to a multiple of 4
	.globl		riscv_reset_entry
	.type		riscv_reset_entry, @function
riscv_reset_entry:

.option push
	// Ensure the instruction is not optimised, since gp is not yet set.
.option norelax
	// __global_pointer$ is a magic symbol, known by the linker.
	// Unless instructed not to do so, the linker optimises
	// accesses +/- 2KB around this to gp-relative.
	la gp, __global_pointer$
.option pop

	// The linker script usually defines the stack at the end of RAM.
	la sp, __stack

	// Proceed with the standard C _start() routine.
	j _start

```

#### The portable startup code

The traditional functionality is to initialize the data & bss sections, to call the C++ static constructors and then pass control to the application `main()`.

For embedded applications, the sequence is basically the same, just that several specific initialization routines are added.

A simplified version of the portable startup code is:

```c++
void
_start (void)
{
    os_startup_initialize_hardware_early ();

    os_initialize_data (&__data_load_addr__, &__data_begin__, &__data_end__);
    os_initialize_bss (&__bss_begin__, &__bss_end__);

    os::trace::initialize ();

    os_startup_initialize_hardware ();
    os::trace::printf ("Hardware initialized.\n");

    os_startup_initialize_free_store (...);

    os_run_init_array ();

    int argc;
    char** argv;
    os_startup_initialize_args (&argc, &argv);

    int code = main (argc, argv);

    exit(code);
    /* NOTREACHED */
}
```

The code is more or less self-documented. Perhaps some questions may be raised by the hardware initialization hooks, especially why not doing the initializations inside `main()`, and why are needed two hardware initialization routines.

#### `os_startup_initialize_hardware ()`

For very simple C applications, it is true that the initialization code can be called from `main()`.

But for more complex applications, like most C++ applications, it is common to execute code before entering `main()` (like calling constructors for static objects).

This implies that the hardware should be initialized _before_ entering `main()`, thus the `os_startup_initialize_hardware ()` hook, that must be defined by the application, and is called after the data & bss are initialized and before the static constructors.

#### `os_startup_initialize_hardware_early ()`

This approach is usually enough, but, for some cases, running the first initializations after the data & bss inits might be too late. What if the board uses external RAM? If so, it obviously must be configured and enabled _before_ initializing the data & bss sections. Also, if the core starts at a very slow speed, it might be useful to raise the speed as early as possible, to ensure a fast startup. Another interesting case is when the device starts with a watchdog enabled; if the watchdog is not properly tailored to the application, it might trigger a reset before the application reaches the main code.

#### The `os` prefix or namespace

µOS++ is not exactly the traditional RTOS, it is more a run-time environment and a collection of APIs for embedded systems. It does include its own scheduler (written in C++), but it does not mandate its use, it can also run on top of other RTOS (like FreeRTOS).

As such, the `os` prefix or namespace does not imply the presence of a scheduler, it is mainly used to differentiate functions that **are not** part of the application.

#### Code

The entire startup library consists of only two files (one header and one source file), and is available as a separate GitHub project [micro-os-plus/startup-xpack](https://github.com/micro-os-plus/startup-xpack.git).

### Board vs Device vs Architecture

Traditionally, boards come with a BSP (Board Support Package), that provides all board specific definitions and drivers.

However, for reusability reasons, in the µOS++ implementation, the BSP is not monolithic, but modular, with three explicit layers:

* board (like **HiFive1**)
* device (like **FE310-G000**)
* architecture (like **RISC-V**)

In other words, multiple boards can share the definitions of a single device, and multiple devices can share the definitions specific to a common architecture.

#### Use of C++

The following examples include C++ code; actually most of µOS++ is written in C++, but this is only an implementation detail, the application can be entirely written in C, as equivalent C APIs are available at all levels.

Although some voices advocate against using C++ in system/embedded code, these opinions are usually based more on believes, than on facts. C++ **can** be successfully used in embedded systems, and modern features, like constexpr, inline templates, can generate even smaller code.

#### Board

The board definitions can be included in the application with a single `#include` line:

```c++
#include <micro-os-plus/board.h>
```

For RISC-V, there are currently not many mandatory definitions at board level, except a function that returns the frequency of the RTC oscillator.

```c++
namespace riscv
{
  namespace board
  {
    uint32_t
    rtc_frequency_hz (void);

  } /* namespace board */
} /* namespace riscv */
```

The board xPack also includes some metadata, used to automatically configure projects using the board, for example:

```json
{
	"schemaVersion": "0.1.0",
	"boards": {
		"hifive1": {
			"vendor": {
				"name": "sifive",
				"id": "1",
				"displayName": "SiFive",
				"fullName": "SiFive, Inc.",
				"contact": "info@sifive.com"
			},
			"revision": "A01",
			"url": "https://www.sifive.com/products/hifive1/",
			"orderForm": "https://www.crowdsupply.com/sifive/hifive1/",
			"name": "HiFive1",
			"description": "The HiFive1 is an Arduino-Compatible development kit featuring the Freedom E310, the industry’s first commercially available RISC-V SoC.",
			"installedDevice": {
				"vendor": "sifive",
				"id": "1",
				"name": "fe310-g000"
			},
			"compatibleDevices": [],
			"features": {
				"flash": {
					"size": "128 Mb",
					"interface": "spi0",
					"memoryRegion": "rom"
				},
				"hfxtal": "16 MHz",
				"lfxtal": "32768 Hz"
			},
			"debug": {
				"interface": "ftdi",
				"connector": "micro-usb",
				"openocd": "-f &quot;board/sifive-freedom-e300-hifive1.cfg&quot;",
				"jlink": {
				    "device": "fe310-g000"
				}
			},
			"compile": {
				"headers": [
					"<micro-os-plus/board.h>"
				],
				"macros": [
					"SIFIVE_HIFIVE1_BOARD"
				]
			}
		}
	}
}
```

##### Code

The SiFive boards libraries are available as two separate GitHub projects [micro-os-plus/sifive-hifive1-board-xpack](https://github.com/micro-os-plus/sifive-hifive1-board-xpack.git) and [micro-os-plus/sifive-coreplex-arty-boards-xpack](https://github.com/micro-os-plus/sifive-coreplex-arty-boards-xpack.git) that requires the `@sifive/coreplex-devices` xPack.

#### Device

The device definitions can be included in the application with a single `#include` line:

```c++
#include <micro-os-plus/device.h>
```

For RISC-V, the device definitions include functions to access the memory mapped system registers, for example:

```c++
namespace riscv
{
  namespace device
  {
    uint64_t
    mtime (void);

    void
    mtime (uint64_t value);

    uint64_t
    mtimecmp (void);

    void
    mtimecmp (uint64_t value);

    // ...
  } /* namespace device */
} /* namespace riscv */
```

There are also functions to access the PLIC registers:

```c++
namespace riscv
{
  namespace plic
  {
    void
    initialize (void);

    void
    clear_priorities (void);

    priority_t
    threshold (priority_t priority);

    priority_t
    threshold (void);

    void
    enable_interrupt (source_t global_interrupt_id);

    void
    disable_interrupt (source_t global_interrupt_id);

    bool
    is_interrupt_enabled (source_t global_interrupt_id);

    void
    priority (source_t global_interrupt_id, priority_t priority);

    priority_t
    priority (source_t global_interrupt_id);

    source_t
    claim_interrupt (void);

    void
    complete_interrupt (source_t global_interrupt_id);

  } /* namespace plic */
} /* namespace riscv */
```

There are also declarations for the local and global interrupt handlers, for example:

```c
  // ...

  void
  riscv_interrupt_global_handle_wdogcmp (void);

  void
  riscv_interrupt_global_handle_rtccmp (void);

  void
  riscv_interrupt_global_handle_uart0 (void);

  void
  riscv_interrupt_global_handle_uart1 (void);

  void
  riscv_interrupt_global_handle_qspi0 (void);

  void
  riscv_interrupt_global_handle_qspi1 (void);

  void
  riscv_interrupt_global_handle_qspi2 (void);

  void
  riscv_interrupt_global_handle_gpio0 (void);

  // ...
```

The device xPacks also include some metadata, to be consumed by automated tools, for example:

```json
{
    "schemaVersion": "0.1.0",
    "devices": {
        "families": {
            "fe300": {
                "vendor": {
                    "name": "sifive",
                    "id": "1",
                    "fullName": "SiFive, Inc.",
                    "contact": "info@sifive.com"
                },
                "name": "Freedom E300",
                "devices": {
                    "fe310-g000": {
                        "name": "Freedom E310-G000",
                        "description": "The FE310-G000 is the first Freedom E300 SoC, and is the industrys first commercially available RISC-V SoC. The FE310-G000 is built around the E31 Coreplex instantiated in the Freedom E300 platform.",
                        "url": "https://www.sifive.com/products/freedom-e310/",
                        "compile": {
                            "headers": [
                                "<micro-os-plus/device.h>"
                            ],
                            "macros": [
                                "SIFIVE_FREEDOM_E310"
                            ],
                            "target": [
                                "-march=rv32imac",
                                "-mabi=ilp32",
                                "-mcmodel=medany",
                                "-msmall-data-limit=8"
                            ]
                        },
                        "features": {
                            "core": "RV32IMAC",
                            "width": "32 bits",
                            "hfosc": "13800 kHz",
                            "lfosc": "32768 Hz",
                            "maxClock": "320 MHz",
                            "package": "qfn",
                            "leads": "48",
                            "vcc": [ "1.8 V", "3.3 V" ]
                        },
                        "memoryRegions": {
                            "ram": {
                                "onChip": "true",
                                "address": "0x80000000",
                                "size": "16 KiB",
                                "access": "rwx",
                                "description": "On-Chip Volatile Memory - Data Tightly Integrated Memory (DTIM)"
                            },
                            "rom": {
                                "onChip": "false",
                                "address": "0x20000000",
                                "maxSize": "512 MiB",
                                "access": "rx",
                                "description": "Off-Chip Non-Volatile Memory - QSPI 0 eXecute-In-Place (XIP)"
                            }
                        },
                        "debug": {
                            "jtag": {
                                "tapindex": "0",
                                "idcode": "0x10e31913",
                                "irlen": "5"
                            }
                        },
                        "xsvd": "xsvd/fe310-g000-xsvd.json"
                    }
                }
            }
        }
    }
}
```

To support debuggers and emulators, a special file with the structured definitions of the peripheral registered is used:

```json
{
    "schemaVersion": "0.1.0",
    "devices": {
        "fe310-g000": {
            "version": "1.0.0",
            "name": "Freedom E310-G000",
            "description": "The FE310-G000 is the first Freedom E300 SoC, and is the industrys first commercially available RISC-V SoC. The FE310-G000 is built around the E31 Coreplex instantiated in the Freedom E300 platform.",
            "busWidth": "32",
            "size": "32",
            "resetValue": "0x00000000",
            "resetMask": "0xFFFFFFFF",
            "access": "rw",
            "peripherals": {
                "clint": {
                    "description": "Coreplex-Local Interruptor (CLINT)",
                    "baseAddress": "0x02000000",
                    "size": "0x10000",
                    "registers": {
                        "msip0": {
                            "description": "MSIP for hart 0",
                            "addressOffset": "0x0000"
                        },
                        "mtimecmp0": {
                            "description": "Timer compare register for hart 0",
                            "addressOffset": "0x4000",
                            "size": "64"
                        },
                        "mtime": {
                            "description": "Timer register",
                            "addressOffset": "0xBFF8",
                            "access": "ro",
                            "size": "64"
                        }
                    }
                },
                "...": "..."
            },
            "...": "..."
        },
        "...": "..."
    }
}
```

##### Code

The SiFive devices library is available as a separate GitHub project [micro-os-plus/sifive-coreplex-devices-xpack](https://github.com/micro-os-plus/sifive-coreplex-devices-xpack.git) that requires the `@micro-os-plus/riscv-arch` xPack.

#### Architecture

The architecture definitions can be included in the application with a single `#include` line:

```c++
#include <micro-os-plus/architecture.h>
```

For RISC-V, the architecture definitions include functions to access the CSRs, for example:

```c++
namespace riscv
{
  namespace csr
  {
    arch::register_t
    mstatus (void);

    void
    mstatus (arch::register_t value);

    void
    clear_mstatus (arch::register_t mask);

    void
    set_mstatus (arch::register_t mask);

    arch::register_t
    mtvec (void);

    void
    mtvec (arch::register_t value);

    arch::register_t
    mcause (void);

    arch::register_t
    mie (void);

    void
    mie (arch::register_t value);

    void
    clear_mie (arch::register_t mask);

    void
    set_mie (arch::register_t mask);

    uint64_t
    mcycle (void);

    uint32_t
    mcycle_low (void);

    uint32_t
    mcycle_high (void);

    arch::register_t
    mhartid (void);

    // ...
  } /* namespace csr */
} /* namespace riscv */
```

There are also declarations for the synchronous exceptions and the common local interrupt handlers, for example:

```c
  void
  riscv_exception_handle_misaligned_fetch (void);

  void
  riscv_exception_handle_fault_fetch (void);

  void
  riscv_exception_handle_illegal_instruction (void);

  void
  riscv_exception_handle_breakpoint (void);

  // ...
```

##### Code

The RISC-V architecture library is available as a separate GitHub project [micro-os-plus/riscv-arch-xpack](https://github.com/micro-os-plus/riscv-arch-xpack.git) that requires the `@micro-os-plus/startup` xPack.

### Interrupts

In modern architectures, the software requirements for interrupt processing are minimal, there is almost nothing to do, apart from providing a list of pointers to interrupt handlers.

The current µOS++ implementation tries to provide a similar user experience for the RISC-V architecture too, by hiding all the implementation details. The application has nothing else to do but define some fixed name functions and enable interrupts.

For example, to handle the machine timer interrupt, the application code looks like this:

```c
#include <micro-os-plus/device.h>

void
riscv_interrupt_local_handle_machine_timer (void)
{
    // ...
}
```

Similar definitions are available for global interrupts, for example to handle the interrupts generated by GPIO pin 4, the application code looks like this:

```c
void
riscv_interrupt_global_handle_gpio4 (void)
{
    // ...
}
```

The prototypes of these functions are provided by the device or architecture xPacks.

### Linker scripts

As with most other projects generated by the GNU MCU Eclipse templates, the linker script is split into three parts:

```
$ tree ldscripts
ldscripts
├── libs.ld
├── mem.ld
└── sections.ld

0 directories, 3 files
```

The names should indicate the content: `libs.ld` defines the additional libraries, `mem.ld` defines the memory regions and `sections.ld` defines the  sections and the mapping to the memory regions.

To make the build use them all, add something like this when invoking the linker:

```
$ <prefix>-g++ ... -L ldscripts -T libs.ld -T mem.ld -T sections.ld ...
```

### The C and C++ libraries

These two xPacks complement the system libraries and provide missing functions or have lighter implementations, more suitable for embedded applications.

```
$ tree c-libs.git
c-libs.git
├── LICENSE
├── README.md
├── include
│   └── newlib
│       └── c-syscalls.h
├── package-lock.json
├── package.json
└── src
    ├── _sbrk.c
    ├── c-syscalls-empty.c
    └── stdlib
        ├── assert.c
        ├── atexit.cpp
        ├── atexit.h
        ├── exit.c
        └── init-fini.c

4 directories, 12 files

$ tree cpp-libs.git
cpp-libs.git
├── LICENSE
├── README.md
├── include
├── package-lock.json
├── package.json
└── src
    └── cxx.cpp

2 directories, 5 files
```

#### Code

The complementary libraries are available as two separate GitHub projects [micro-os-plus/c-libs-xpack](https://github.com/micro-os-plus/c-libs-xpack.git) and [micro-os-plus/cpp-libs-xpack](https://github.com/micro-os-plus/cpp-libs-xpack.git) that have no other dependencies and can be included in any application.

### Tracing support

Although modern debuggers are quite advanced and can display lots of useful information, there are many cases when the classical `printf()`, placed at the right location, can be more efficient in spotting bugs.

#### The traditional approach, redirect STDOUT/STDERR

Using `printf()` in Unix environments is as easy as it can be since standard IO support is always available, but in embedded environments the full standard IO libraries may be too expensive, in terms of program size and especially in complexity; without system operating support, the traditional solution to make the trace messages go out via a dedicated peripheral (a hardware debug channel, like ARM ITM, or even an USART port), is to rewrite a low level function, like `_write()` in newlib; unfortunately, the path from `printf()` to the actual `_write()` is quite long.

Plus in some applications, like those using semihosting, the standard output and standard error are already used for normal functionality (like outputting test results) and intermixing trace messages may interfere with the normal behaviour.

#### Use a separate trace channel

Since for debug purposes things should be as simple as possible, the preferred solution is to avoid using STDOUT or STDERR at all, and use a completely separated trace channel, that does not depend at all on the usual redirected system functions.

Using these functions is very simple, the prototypes being identical to the standard calls, but placed in a separate namespace (in C++) or a separate prefix (in C):

```c++
#include <micro-os-plus/diag/trace.h>

using namespace os;

void f(char* str, int num)
{
    // ...
    trace::printf("Hello %s %d\n"); // in C++
    trace_printf("Hello %s %d\n"); // in C
    // ...
}
```

The complete public C++ API is:

```c++
int os::trace::printf (const char *format, ...);
int os::trace::putchar (int c);
int os::trace::puts (const char *s);
int os::trace::vprintf (const char *format, std::va_list args);
ssize_t os::trace::write (const void* buf, std::size_t nbyte);
```

#### The TRACE macro

Support for the trace functions is enabled by adding the `TRACE` preprocessor definition when invoking the compiler. Without it, the header defines empty inline functions, so there is no need to explicitly brace the `trace::prinf()` calls with `#if defined(TRACE) / #endif`, which is quite convenient.

#### Implementation

The implementation is simple, it uses `vsnprintf()` to output to a local buffer, then calls `trace::write()` (which must be implemented by the application) to transfer the buffer to the desired peripheral.

The custom functions that need to be implemented by the application have a simple and unsurprising API:

```c++
namespace os
{
  namespace trace
  {
    void
    initialize (void);

    ssize_t
    write (const void* buf, std::size_t nbyte);

    void
    flush (void);

  } /* namespace trace */
} /* namespace os */
```

#### Code

The entire trace library consists of only two files (one header and one source file), and is available as a separate GitHub project [micro-os-plus/diag-trace-xpack](https://github.com/micro-os-plus/diag-trace-xpack.git) that has no other dependencies and can be included in any application.

## Future plans

Although the current templates are already able to generate functional projects, there are many things that can be added/improved.

### New device drivers

First and foremost is better support for all SiFive device peripherals; new definitions of the memory mapped registers are already under way; new APIs for the Coreplex device drivers are currently in design phase, and will be implemented soon (as soon as the OpenCOD issues the hamper development will be addressed).

### Peripheral register view in Eclipse

With the new RISC-V device packages including the structured definitions of the peripheral registers, it is perfecly possible to use these definitions to show the register bitfields during an Eclipse debug session, similarly to using ARM SVD definitions.

### Support for applications using an RTOS and middleware

In addition to the simple blinky projects generated now, the future templates should be able to generate more complex RISC-V embedded projects, including those using a RTOS and possibly some middleware (like POSIX IO, File System, Network).

Support for FreeRTOS and µOS++ is planned, with the focus shifted to µOS++, as it has a modern code and supports both C and C++.

### New and improved xPack tools

In order to support scriptable builds and automated testing, the xPack tools (`xpm`, `xmake`, `xsvd`, `xcdl`, etc) will be enhanced with new features.

### Better integration with Eclipse

The **SiFive C/C++ Project template** is only the first step towards using RISC-V xPacks in Eclipse.

After the command line tools will be fully functional and stable, more xPack support will be added to Eclipse, first to complement the CMSIS Packs, then possibly as an alternate solution to the managed build support available now in Eclipse CDT.

### Integration with other editors/IDEs

As a design decision, the main xPack tools will continue to be developed as command line tools.

However, new editors and graphical IDEs are under continuous developpment and some of them get more and more traction (for example Visual Studio Code), so using them to build RISC-V embedded applications based on xPacks may become an attractive option.

### Improved QEMU with graphical animated LEDs & buttons

Similarly to the way Cortex-M board are support in GNU MCU Eclipse QEMU, the HiFive1 board can be emulated in graphical mode, with animated LEDs and buttons.

The first step is to emulate the board at such a level that not only to allow the 'blinky' projects generated by the template to run, but also to show the LEDs blinking on top of the board image, and to trigger button actions when the button images are clicked on.

In order to do this, the structured peripheral registers definitions available in the SiFive device xPack need to be validated, since the actual QEMU implementation code is automatically generated from the xsvd definitions.

### Documentation pages

The current code already includes lots of Doxygen definitions, aiming to allowing the full reference manuals to be generated from the source code, using the same approach for RISC-V code as as for the existing [µOS++ reference pages](http://micro-os-plus.github.io/reference/cmsis-plus/).

Tutorials and User's Manuals are also planned, similar to those partly available in the [µOS++ User's Manual](http://micro-os-plus.github.io/user-manual/).

### Many more

Being driven by the community needs, the list is open, and is limited only by our imagination.

## Feedback

As usual for open source projects, any comments/criticism/suggestions are highly appreciated!
