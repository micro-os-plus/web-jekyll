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

One of the major challenges when developing software is reusing various pieces of code among applications.

The trivial approach is to simply copy/paste routines or entire files from one application to another. This is ok as long as the code does not change; once the code changes, manually updating all projects is no longer trivial.

A slightly better solution is to create separate libraries, and include them _as is_ in different projects. Initially this may look ok, but if the libraries have inter-dependencies, and their number grows, knowing which libraries are compatible with each other may no longer be as easy as expected.

The problem is aggravated by the fact that each library has its own life cycle, and new versions may no longer be compatible with existing or newer versions of the other libraries.

### Solution

Instead of a monolithic project, where the build has to process a complicated folder hierarchy, one possible solution is to build the project from separate components, stored in separate packages.

In practical terms, each package should have, in addition to the source files, some metadata, to define its own identity and a list of dependencies from other packages.

### Benefits

This modular approach with structured metadata greatly increase the code reusability and upgradability, by allowing automated tools to bring into the project the required components, and to automatically manage the dependencies, accepting only combinations of compatible packages.

Such solutions are already available for other languages, with the most successful one being [npm](https://www.npmjs.com) (The Node Package Manager), for JavaScript modules.

There were also several attempts to create such solutions for C/C++ embedded applications, but they had limited success (for example CMSIS Packs, which uses huge packages and is more or less specific to Keil MDK, and yotta, originally from ARM mbed, now abandoned, which mandates the use of cmake and python).

## Project structure

### Application vs packages

In the proposed modular approach, the application code is clearly separated from the external packages; the application folders are under full control of the user, who can edit/add/remove any files, while the packages are under the control of the package manager, and generally are read only, to prevent inadvertent changes.

### Example 

An example of such a project structure is used in the **SiFive project templates**; most of the files are part of the application; the packages are grouped under the `xpacks` folder, and the package metadata is located in `package.json`:

```bash
$ tree -L 2 hifive1-blinky
hifive1-blinky
├── LICENSE
├── README.md
├── build
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

38 directories, 61 files
$ 
```

### Dependencies

Each package keeps a list of dependencies to other packages, and the package manager ensures that all required packages are downloaded and made available to the project before the build starts.

For the above project, the `package.json` file includes the following dependencies:

```json
{
    "...": "...",
    "dependencies": {
        "@micro-os-plus/diag-trace": "~1.0.1"
        ,"@sifive/hifive1-board": "~0.0.3"
    },
    "...": "..."
}
```

In other words, the application requires explicit support only for diagnostics and for the **SiFive HiFive1** board. Inspecting the project's structure, it is easy to identify seven packages, not two. The explanation is that the `sifive-hifive1-board` package pulled `sifive-coreplex-devices`, which pulled `micro-os-plus-riscv-arch`, which pulled `micro-os-plus-startup` and the two libraries.

### Tools

To further automate the build process, packages can refer not only to other source packages, but to tools packages, which include separate applications required during the development cycle, like toolchains, debuggers, builders, etc.

This is a very powerful feature, that ensures, in a portable way, that the project can be built immediately after the install is complete.

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

This approach is usually enough, but for some cases running the first initializations after the data & bss might be too late. What if the board uses external RAM? If so, it obviously must be configured _before_ initializing the data & bss sections. Also, if the core starts at a very slow speed, it might be useful to raise the speed as early as possible, to ensure a fast startup. Another interesting case is when the device starts with a watchdog enabled; if the watchdog is not properly tailored to the application, it might trigger a reset before the application reaches the main code.

#### The `os` prefix or namespace

µOS++ is not exactly the traditional RTOS, it is more a run-time environment and a collection of APIs for embedded systems. It does include its own scheduler (written in C++), but it does not mandate its use, it can also run on top of other RTOS (like FreeRTOS).

As such, the `os` prefix or namespace does not imply the presence of a scheduler, it is mainly used to differentiate functions that **are not** part of the application.

#### Code

The entire startup library consists of only two files (one header and one source file), and is available as a separate GitHub project [micro-os-plus/startup](https://github.com/micro-os-plus/startup.git).

### Board vs Device vs Architecture

Traditionally, boards come with a BSP (Board Support Package), that provides all board specific definitions and drivers.

However, for reusability reasons, in the µOS++ implementation, the BSP is not monolithic, but modular, with three explicit layers:

* board (like **HiFive1**)
* device (like **FE310-G000**)
* architecture (like **RISC-V**)

In other words, multiple boards can share the definitions of a single device, and multiple devices can share the definitions specific to a common architecture.

#### Use of C++

The following examples include C++ code; actually most of µOS++ is written in C++, but this is only an implementation detail, the application can be entirely written in C, as equivalent C APIs are available at all levels.

Although some voices advocate against using C++ in system code, these opinions are usually based more on believes, than on facts. C++ **can** be successfully used in embedded systems, and modern features, like constexpr, inline templates, can generate even smaller code.

#### Board

The board definitions can be included in the application with a single `#include` line:

```c++
#include <micro-os-plus/board.h>
```

There are currently not many mandatory definitions at board level, except a function that returns the frequency of the RTC oscillator.

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

The board package also includes some metadata, used to automatically configure projects using the board, for example:

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

The device packages also include some metadata, to be consumed by automated tools, for example:

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

The prototypes of these functions are provided by the device or architecture packages.

### Linker scripts

As with most other projects generated by the GNU MCU Eclipse templates, the linker script is split into three parts:

```bash
$ tree ldscripts
ldscripts
├── libs.ld
├── mem.ld
└── sections.ld

0 directories, 3 files
$
```

The names should indicate the content: `libs.ld` defines the additional libraries, `mem.ld` defines the memory regions and `sections.ld` defines the  sections and the mapping to the memory regions.

To make the build use them all, add something like this when invoking the linker:

```bash
$ <prefix>-g++ ... -L ldscripts -T libs.ld -T mem.ld -T sections.ld ...
```

### The C and C++ libraries

These two packages complement the system libraries and provide missing functions or have lighter implementations, more suitable for embedded applications.

```bash
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
$
```

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

The entire trace library consists of only two files (one header and one source file), and is available as a separate GitHub project [micro-os-plus/diag-trace](https://github.com/micro-os-plus/diag-trace.git) that has no other dependencies and can be included in any application.

## Demo

### Eclipse project template

- generate project
- build 

### Command line template

- generate project
- build with xmake

