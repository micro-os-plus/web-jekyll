---
layout: page
lang: en
permalink: /develop/modular-projects/
title: Modular projects
author: Liviu Ionescu

date: 2017-09-26 13:05:00 +0300

---

## Objectives & benefits

### Challanges

One of the major challanges when developing software is reusing various pieces of code from other applications.

The trivial approach is to simply copy/paste routines or entire files from one application to another. This is ok as long as the code does not change; once this happens, manually updating all projects is no longer trivial.

A slightly better solution is to create separate libraries, and include them _as is_ in different projects. Initially this may look ok, but if the number of libraries grows, and the libraries have inter-dependencies, knowing which libraries are compatible with each other may no longer be as easy as expected.

The problem is agravated by the fact that each library has its own life cycle, and new versions may no longer be compatible with existing or newer versions of the other libraries.

### Solution

Instead of a monolythic project, where the build has to process a complicated folder hierarchy, one possible solution is to build the project from separate components, stored in separate packages.

In practical terms, each package should have, in addition to the source files, some metadata, to define its own identity and a list of dependencies from other packages.

### Benefits

This modular approach with structured metadata greatly increase the code reusability and upgreadability, by allowing automated tools to bring into the project the required components, and to automatically manage the dependencies, accepting only combinations of compatible packages.

Such solutions are already available for other languages, with the most successful one being [npm](https://www.npmjs.com) (The Node Package Manager), for JavaScript modules.

There were also several attempts to create such solutions for C/C++ embedded applications, but they had limited success (for example CMSIS Packs, which uses huge packages and is more or less specific to Keil MDK, and yotta, originally from ARM mbed, but now abandoned, which mandates the use of cmake and python).

## Project structure

### Application vs packages

In the proposed modular aproach, the application code is clearly separated from the external packages; the application folders are under full control of the user, who can edit/add/remove any files, while the packages are under the control of the package manager, and generally are read only, to prevent inadvertent changes.

### Example 

An example of such a project structure is used in the **SiFive project templates**; most of the files are part of the application; the packages are grouped below the `xpacks` folder, and the package metadata is in `package.json`:

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
    ...
    "dependencies": {
        "@micro-os-plus/diag-trace": "~1.0.1"
        ,"@sifive/hifive1-board": "~0.0.3"
    }
    ...
}
```

In other words, the application requires explicit support only for diagnostics and for the **SiFive HiFive1** board. Inspecting the above project structure, it is easy to identify seven packages, not two. The explanation is that the `sifive-hifive1-board` package pulled `sifive-coreplex-devices`, which pulled `micro-os-plus-riscv-arch`, which pulled `micro-os-plus-startup` and the two libraries.

### Tools

To further automate things, packages can refer not only to other source packages, but to tools packages, which include separate applications required during the development cycle, like toolchains, debuggers, builders, etc.

## Embedded projects specifics

### Board vs Device vs Architecture

TODO: explain each package type, with content, metadata and usage

### The startup code

Traditionally, the startup code is writen in assembly, the justification being that, right after reset, the run-time is not yet suitable for higher level languages, like C/C++. For some modern architectures, like Cortex-M, this is plainly wrong, since the advanced core automatically loads the stack pointer before calling the `Reset_Handler`, and the startup code can be written in C/C++ from the very beginning.

#### Assembly entry code

Other, more traditional architectures, still require some small assembly code to explicitly set several registers. 

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

#### Portable startup

The traditional functionality is to initialise the data & bss sections, to call the C++ static constructors and then pass control to the application `main()`.

For embedded applications, the sequence is basically the same, just that several specific initialisation routines are called.

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
    os::trace::printf ("Hardware initialised.\n");

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

The code is more or less self-documented. Perhaps the hardware initialisation hooks may raise some questions, especially why the initialisations are not done inside `main()`, and why there are two hardware initialisation routines.

For very simple C applications, it is true that the initialisation code can be called from `main()`.

#### `os_startup_initialize_hardware ()`

For more complex applications, like most C++ applications, it is common to execute code before entering `main()` (like calling constructors for static objects).

This means the hardware must be initialised _before_ entering `main()`, thus the `os_startup_initialize_hardware ()` hook, that must be defined by the application, and is called before the static constructors, and after the data & bss are initialised.

#### `os_startup_initialize_hardware_early ()`

But for some cases this might be too late. What if the board uses external RAM? If so, it obviously must be configured _before_ initialising the data & bss sections. Also, if the core starts at a very slow speed, it might be useful to raise the speed as early as possible, to ensure a fast startup. Another interesting case is when the device starts with a watchdog enabled; if the watchdog is not properly tailored to the application, it might be possible to trigger a reset before the application reaches the main code.

#### Code location

The entire startup library consist of only two files (one header and one source file), and is available as a separate GitHub project [micro-os-plus/startup](https://github.com/micro-os-plus/startup.git).

### Interrupts

In modern architectures, interrupt processing is usually a no-op, there is almost nothing to do, apart from providing a list of pointers to interrupt handlers.

Although for RISC-V the architecture specs make interrupt processing significantly more complicated, the current implementation tries to provide a similar user experience, by hidding all the implementation details. The application has nothing else to do then define some fixed name functions and enable interrupts.

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

### Linker scripts

TODO: explain the multi-file linker scripts, with configuration

### Tracing support

Although modern debuggers are quite advanced and can display lots of useful information, there are many cases when the classical `printf()`, placed in the right location, can be more efficient in spotting bugs.

#### The traditional approach, redirect STDOUT/STDERR

Using `printf()` in Unix environments is as easy as it can be since standard IO support is always available, but in embedded environments the full standard IO libraries may be too expensive, in terms of program size and especially in complexity; without system operating support, the traditional solution to make the trace messages go out via a dedicated peripheral (a hardware debug channel, like ARM ITM, or even an USART port), is to rewrite a low level function, like `_write()` in newlib; unfortunately, the path from `printf()` to the actual `_write()` is quite long.

Plus that in some applications, like those using semihosting, the standard output and standard error are already used for a normal functionality (like outputing test results) and intermixing trace messages may interfere with the normal behaviour.

#### Use a separate trace channel

Since for debug purposes things should be as simple as possible, the prefered solution is to avoid using STDOUT or STDERR at all, and use a completely separated trace channel, that does not depend at all on the usual redirected system functions.

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

The complete public API is:

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

#### Code location

The entire trace library consist of only two files (one header and one source file), and is available as a separate GitHub project [micro-os-plus/diag-trace](https://github.com/micro-os-plus/diag-trace.git) that has no other dependencies and can be included in any application.

## Demo

### Eclipse project template

- generate project
- build 

### Command line template

- generate projct
- build with xmake

