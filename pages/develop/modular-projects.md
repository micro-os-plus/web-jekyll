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

This problem is agravated by the fact that each library has its own life cycle, and new versions may no longer be compatible with the other libraries.

### Solution

Instead of a monolythic project, where the build processes a complicated folder hierarchy, one possible solution is to build the project from separate components, stored in separate packages.

In practical terms, each package should have, in addition to the source files, some metadata, to define its own identity and a list of dependencies from other packages.

### Benefits

This modular approach with structured metadata greatly increase the code reusability and upgreadability, by allowing automated tools to bring into the project the required components, and to automatically manage the dependencies, accepting only combinations of compatible packages.

Such solutions are already available for other languages, with the most successful one being [npm - The Node Package Manager](https://www.npmjs.com), for JavaScript modules.

There were also several attempts to create such solutions for C/C++ embedded applications, but they had limited success (for example CMSIS Packs, which uses huge packages and is more or less specific to Keil MDK, and yotta, originally from ARM mbed, but now abandoned, which mandates the use of cmake and python).

## Project structure

### Application vs packages

In the proposed modular aproach, the application code is clearly separated from the external packages; the application folders are under full control of the user, who can edit/add/remove any files, while the packages are under the control of the package manager, and generally are read only, to prevent inadvertent changes.

### Example 

An example of such a project structure is used in the **SiFive project templates**; most of the files are part of the application; the packages are grouped below the `xpacks` folder, and the package metadata is in `package.json`:

```bash
$ tree -L 3 hifive1-blinky/
hifive1-blinky/
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
        "@micro-os-plus/diag-trace": "^1.0.1"
        ,"@sifive/hifive1-board": "^0.0.3"
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

TODO: explain the startup sequence and used hooks

### Linker scripts

TODO: explain the multi-file linker scripts, with configuration

### Tracing support

TODO: explain the need for a separate trace channel, and how to use trace::printf()

## Demo

### Eclipse project template

- generate project
- build 

### Command line template

- generate projct
- build with xmake

