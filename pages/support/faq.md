---
layout: page
lang: en
permalink: /support/faq/
title: FAQ
author: Liviu Ionescu

date: 2015-09-11 20:28:00 +0300

---

## Why I can’t step into the sprintf() function?

Stepping into any function requires the presence of the debug information. Normally, the implementation of the `printf()` family of functions is in the standard C library, which does not include debugging information.

However, for common GCC setups, using the open source **newlib** library, the source code of any function is available; it can be (temporarily) brought into the project and compiled with debugging information.

The [newlib](https://sourceware.org/newlib/) sources can be cloned from:

```
git clone git://sourceware.org/git/newlib-cygwin.git
```

Create a subfolder in the source folder (for example `newlib-libc`) and copy the desired files from `newlib-cygwin.git/newlib/libc/stdio`. You may also need to copy some additional headers, from related folders.

For example, to step into `snprintf()` and `trace::printf()`, the following files were required:

```
$ tree newlib-libc
newlib-libc
├── locale
│   └── setlocale.h
├── stdio
│   ├── dtoa.c
│   ├── fvwrite.h
│   ├── local.h
│   ├── mprec.c
│   ├── mprec.h
│   ├── nano-vfprintf.c
│   ├── nano-vfprintf_float.c
│   ├── nano-vfprintf_local.h
│   ├── snprintf.c
│   ├── vfieeefp.h
│   └── vsnprintf.c
└── stdlib
    └── local.h

3 directories, 13 files
```

For the build to pass, it might be necessary to define some macros; for the above tree, the following definitions were required:

```
STRING_ONLY
```

Please note that the newlib sources are far from warning free, and it is recommended to disable any warning checks for the `newlib-libc` folder.

If the newlib nano version is used (as in the example above), and printing floats is desired, the routines to convert floats need to be explicitly included, by adding `-u _printf_float` to the linker.

