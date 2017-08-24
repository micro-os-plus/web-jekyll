---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/The_uOS++_(micro_os_plus_plus)/
title: The µOS++ (micro os plus plus)
author: Liviu Ionescu

date: 2015-09-28 10:51:34 +0000

---

* * * * *

Note: These pages were converted from the wiki created for the first edition of this project. The second edition was documented in separate [pages]({{ site.baseurl }}/micro-os-plus/ii/The_uOS++_Second_Edition_Wiki/) and a [Doxygen site](http://micro-os-plus.sourceforge.net/doc/).

* * * * *

The "µOS++" (micro OS plus plus) project is a [SourceForge hosted](http://sourceforge.net/projects/micro-os-plus/) open source, royalty-free, multi-tasking operating system intended for embedded systems. It is based on a simple preemptive scheduler running on ARM Cortex M3 and Atmel AVR8/AVR32 devices. Being carefully written in a subset of C++, it is elegant, convenient to use, easy to maintain, yet efficient and has a small footprint.

µOS++ provides basic synchronization primitives based on Unix sleep/wakeup mechanisms, multiple system timers (counting ticks or seconds), advanced customizable timers, mutual exclusion objects, synchronized flags, USB and USART character device drivers, MMC/SD Card drivers, SDI-12 sensor drivers and more.

The build mechanism is highly granular, allowing a very small ROM+RAM footprint.

The authoritative documents on how to use µOS++ can be found in the [project Wiki (no longer valid, redirected to new site)](http://micro-os-plus.github.io). The source code itself, publicly available for browsing via the web [Git Browse](http://micro-os-plus.git.sourceforge.net/git/gitweb-index.cgi) interface is another good source of information. (Additional resources are the [Trac](https://sourceforge.net/projects/micro-os-plus/) and the [SVN](http://micro-os-plus.svn.sourceforge.net/viewvc/micro-os-plus/trunk/).

The current version is 4.3, as Release Candidate in 2012. Since there are no clear milestones on this project (yet), there will be no periodic releases, and the download section will probably not be updated very often. For an up-to-date version of this project, it is recommended to use the Git sources instead of the released packages.

Technicalities
==============

Install the build environment
-----------------------------

-   [How to install]({{ site.baseurl }}/micro-os-plus/i/How_to_install)

Overview
--------

-   [Features]({{ site.baseurl }}/micro-os-plus/i/Features)
-   [The Scheduler]({{ site.baseurl }}/micro-os-plus/i/Scheduler)
-   [Synchronisation events]({{ site.baseurl }}/micro-os-plus/i/Synchronisation_events)
-   [System timers]({{ site.baseurl }}/micro-os-plus/i/System_Timers)
-   [Advanced/Custom timers]({{ site.baseurl }}/micro-os-plus/i/Advanced_(Custom)_Timers)
-   [Tasks]({{ site.baseurl }}/micro-os-plus/i/Tasks)
-   [Device drivers]({{ site.baseurl }}/micro-os-plus/i/Device_drivers)
-   [Memory management]({{ site.baseurl }}/micro-os-plus/i/Memory_management)
-   [Interrupt service routines]({{ site.baseurl }}/micro-os-plus/i/Interrupt_service_routines)

APIs
----

-   [Classes overview]({{ site.baseurl }}/micro-os-plus/i/Classes_overview)
-   [Configuration definitions index]({{ site.baseurl }}/micro-os-plus/i/Configuration_definitions_index)
-   [Class page template]({{ site.baseurl }}/micro-os-plus/i/Class_page_template)

Samples
-------

-   [Samples]({{ site.baseurl }}/micro-os-plus/i/Samples)

Debug support
-------------

-   [Debug support]({{ site.baseurl }}/micro-os-plus/i/Debug_support)
-   [Using LEDs]({{ site.baseurl }}/micro-os-plus/i/Using_LEDs)

Usage
-----

-   [How to use]({{ site.baseurl }}/micro-os-plus/i/How_to_use)
-   [The build mechanism]({{ site.baseurl }}/micro-os-plus/i/The_build_mechanism)
-   [Application configuration]({{ site.baseurl }}/micro-os-plus/i/Application_configuration) (includes an explanation of the headers structure)
-   [Configuration variables]({{ site.baseurl }}/micro-os-plus/i/Configuration_variables)

Portability
-----------

-   [Portability]({{ site.baseurl }}/micro-os-plus/i/Portability)
-   [How to port]({{ site.baseurl }}/micro-os-plus/i/How_to_port)

Processor specific pages
------------------------

### AVR32

-   [Programing the chip via the bootloader]({{ site.baseurl }}/micro-os-plus/i/Using_the_AVR32_bootloader)

Performances
------------

-   [Footprint]({{ site.baseurl }}/micro-os-plus/i/Footprint)

Misc
----

-   [FAQ]({{ site.baseurl }}/micro-os-plus/i/FAQ)
-   [Reporting problems]({{ site.baseurl }}/micro-os-plus/i/Reporting_problems)
-   [Change log]({{ site.baseurl }}/micro-os-plus/i/Change_log)
-   [The µOS++ SE]({{ site.baseurl }}/micro-os-plus/ii/The_uOS++_Second_Edition_Wiki)

Style guides
============

-   [Wiki pages style guide]({{ site.baseurl }}/micro-os-plus/i/Wiki_pages_style_guide)
-   [C++ source code style guide]({{ site.baseurl }}/micro-os-plus/i/C++_source_code_style_guide)
-   [C++ naming convention]({{ site.baseurl }}/micro-os-plus/i/C++_naming_convention)
-   [Class page template]({{ site.baseurl }}/micro-os-plus/i/Class_page_template)

Other references:

-   Joint Strike Fighter Air Vehicle C++ Coding Standards for the System Development and Demonstration Program, Lockheed Martin Corporation, 2005
-   MISRA-C: 2008 – Guidelines for the use of the C++ language in critical systems, MIRA Limited, 2008

Misc
====

-   [Project history]({{ site.baseurl }}/micro-os-plus/i/Project_history)
-   [My wiki preferences]({{ site.baseurl }}/micro-os-plus/i/Recommended_preferences)
-   [My backup procedure]({{ site.baseurl }}/micro-os-plus/i/Project_backup)

Other resources
===============

-   [HTML-to-wiki converter](https://www.mediawiki.org/wiki/Extension:Html2Wiki)
-   [Excel to MediaWiki convertor](http://excel2wiki.net/)
-   [Wikipedia Tools](http://en.wikipedia.org/wiki/Wikipedia:Tools)

Final thoughts
==============

Althought not required by the license, I would be very happy if you could drop me a notice after downloading these sources.

Any comments/critics/suggestions/etc will be highly appreciated.

Enjoy,

Liviu Ionescu
