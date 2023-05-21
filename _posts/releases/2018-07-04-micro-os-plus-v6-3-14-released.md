---
layout: post
lang: en
title: µOS++ v6.3.14 released
author: Liviu Ionescu

date: 2018-07-04 08:19:00 +0300

categories:
  - releases
  - rtos
  - micro-os-plus

---

Version v6.3.14 is a **µOS++** maintenance release. The main addition
is the functional POSIX I/O subsystem, which supports character devices,
block devices and file systems.

## Affected packages

- [micro-os-plus-iii](https://github.com/micro-os-plus/micro-os-plus-iii)
- [xpacks/chan-fatfs](https://github.com/xpacks/chan-fatfs)

## Download or update

As of now, the **µOS++** code is split between several GitHub projects
and needs to be brought together to compose a project.
To automate this process, some scripts are available from a
[separate project](https://github.com/xpacks/scripts).

To update the local copy of the xPacks, use the
`scripts.git/xpacks-update-repo.sh` script.

To experiment with **µOS++**, please check the demo projects, available from
[GitHub](https://github.com/micro-os-plus/eclipse-demo-projects),
and use a similar structure for your projects.

## New features

- add support for Chan FatFS to the POSIX I/O layer; for some examples how
to use it, please see the `test/rtos/src/test-chan-fatfs.cpp` file
- add `file_descriptors_manager::used()` to tell how many file
descriptors are used
- [[#41](https://github.com/micro-os-plus/micro-os-plus-iii/issues/41)]
add non-standard `timegm()`, as the opposite of `gmtime()`
- implement alignment in memory allocators
- [[#40](https://github.com/micro-os-plus/micro-os-plus-iii/issues/40)]
posix: add `statvfs()`/`fstatvfs()`
- [[#36](https://github.com/micro-os-plus/micro-os-plus-iii/issues/36)]
posix: add `tcdrain()`/`tcflush()`/`tcgetattr()`/`tcsendbreak()`/
`tcgetattr()` to POSIX aliases
- [[#29](https://github.com/micro-os-plus/micro-os-plus-iii/issues/29)]
add thread top try/catch for exceptions; support for C++ exceptions
was tested and is now available
- [[#20](https://github.com/micro-os-plus/micro-os-plus-iii/issues/20)]
add sys/ioctl.h

## Addressed bugs

- [[#44](https://github.com/micro-os-plus/micro-os-plus-iii/issues/44)]
os_main.cpp: add cast for `os_main_thread`
- [[#35](https://github.com/micro-os-plus/micro-os-plus-iii/issues/35)]
add missing `_fini()`
- [[#17](https://github.com/micro-os-plus/micro-os-plus-iii/issues/17)]
fix `_LITE_EXIT` redefinition
- rtos/thread: unlock dangling mutexes

## Other changes

- `file_descriptors_manager::alloc()` was renamed
`file_descriptors_manager::allocate()` and `file_descriptors_manager::free()`
was renamed `file_descriptors_manager::deallocate()`, to be more in line with
modern allocators
- the standard thread classes were reorganised to be visible both in `std::`
and `estd::` namespaces

## Known problems

- the header files are still located below a `cmsis-plus` folder; to be
replaced by `micro-os-plus` in a future major release.
- the `file_descriptors_manager` class is not yet synchronised

## Future developments

This will hopefully be the final release of µOS++ in the current monolithic
structure. Future versions will use a modular structure, based on xPacks.
