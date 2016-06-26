---
layout: old-wiki-page
permalink: /micro-os-plus/ii/Criticism_of_previous_versions/
title: Criticism of previous versions
author: Liviu Ionescu

date: 2014-06-15 06:44:58 +0000

---

In order to do things better, the first step is to acknowledge that some aspects were not as good as expected, and so are candidates for improving.

I guess the main problem of µOS++ SE was the complex structure, making hard to find something without an accurate indexer or a full search.

Other critics:

-   no integration with Eclipse; the entire build system, based on xCDL was highly functional, but being written in Python, had no chance of being integrated into Eclipse (anyway, this was a rapid prototyping phase, to prove the concept)
-   the complete separation from standard C/C++ libraries requires changes in the sources
-   the C++ only, without any possibility to call anything from C, restricted usability
-   the lack of standard interfaces for network and file systems

Valued experiences, to be kept:

-   the idea behind the configuration mechanism implemented by xCDL
-   the separate name spaces for the standard C++ libraries allowed a good testability of library functions

Lessons for the new version:

-   allow to write C applications, even if linked with C++ libraries
-   stay as compatible as possible to C11 and C++11 (threads and other special features)
-   eventually implement a CMSIS-RTOS compatibility layer
-   use a standard startup/exit code
-   use standard testing infrastructure (Google tests, running on POSIX synthetic platforms and over semihosting on embedded ARM platforms)
-   use ARM CMSIS for C projects
-   use the POSIX read()/write() API for network and storage
-   more usage models (copy files to local project, create libraries, reference to several central repo of libraries), with better Eclipse integration
-   by default the standard libraries should be in the standard namespace, but for testing it should be possible to generate separate namespaces
