---
layout: page
permalink: /cmsis-plus/rtos/
title: CMSIS++ RTOS API
author: Liviu Ionescu

date: 2016-03-09 12:04:00 +0300

---

## Overview

The CMSIS++ RTOS API is a portable RTOS interface, but designed to best match the ARM Cortex-M processor-based devices.

![CMSIS++ RTOS]({{ site.baseurl }}/assets/images/2016/cmsis-plus-overview.png)

## Project highlights

The project highlights are:

- the core CMSIS++ RTOS is based on a C++ API (namespace `os::rtos`), defined in [<cmsis-plus/rtos/os.h>](https://github.com/micro-os-plus/cmsis-plus/blob/xpack/include/cmsis-plus/rtos/os.h);

- exactly the same functionality is provided in C, with a C wrapper, for those who prefer to use plain C; the C API is defined in [<cmsis-plus/rtos/os-c-api.h>](https://github.com/micro-os-plus/cmsis-plus/blob/xpack/include/cmsis-plus/rtos/os-c-api.h);

- for compatibility reasons, the actual CMSIS API is also implemented in the C wrapper; it is defined in [<cmsis\_os.h>](https://github.com/micro-os-plus/cmsis-plus/blob/xpack/include/cmsis-plus/legacy/cmsis_os.h) (functional, passed the CMSIS RTOS validation, using the [FreeRTOS port](https://github.com/xpacks/freertos/blob/xpack/cmsis-plus/include/cmsis-plus/rtos/port/os-inlines.h));

- on top of the core C++ API, the ISO standard thread library is fully implemented (namespace `os::estd`), and this is the recommended C++ API for future applications; the definitions are available from [<cmsis-plus/iso/*>](https://github.com/micro-os-plus/cmsis-plus/tree/xpack/include/cmsis-plus/iso);

- all RTOS objects are based on the core C++ objects, and objects created in C++ can be used in C and similarly objects created in C can be used in C++ (there is no mystery here, they represent exactly the same objects);

- the C++ API was originally derived from the original CMSIS RTOS C API, but was adjusted to match the POSIX and ISO requirements as close as possible, so now it is generally a C++ version of the POSIX pthread library;

- the CMSIS++ RTOS specification will go one step further then the original CMSIS, it will also suggest a portable scheduler API, and a set of portable synchronisation primitives, calling the portable scheduler; the portable synchronisation objects can be considered a 'reference implementation', however CMSIS++ does not mandate the use of these objects, it is quite easy to forward all calls to the underlaying implementation, as the current version using FreeRTOS does (partly implemented, to be completed soon);

- there will also be a reference scheduler implementation (called µOS++ III), that will also be highly portable; it will run in 32-bits and 64-bits environments but will be specifically tailored for Cortex-M cores; it'll also run on synthetic POSIX platforms, for example as a user mode POSIX process, on OS X and GNU/Linux, possibly on Windows if MinGW-w64 will allow an easy port. (will be based on prior µOS++ versions, which are fully functional);

- CMSIS++ also includes a POSIX IO interface (namespace `os::posix`), bringing together access to terminal devices, files and sockets, via a unified and standard API (functional in a separate project, will be updated and moved here shortly);

- CMSIS++ Drivers are the response to CMSIS Drivers, but designed in C++ (namespace os::drivers), and with a C API on top of them (CMSIS++ serial, USB Device and USB Host already defined and partly implemented);

- the CMSIS++ packaging solution will extend and complement CMSIS Packs with **xPack/XCDL** packs.
