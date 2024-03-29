---
layout: page
lang: en
permalink: /project/history/
title: Project history
author: Liviu Ionescu

date: 2016-06-28 15:53:09 +0300

redirect_from:
  - /micro-os-plus/iii/project-history/

---

{% include note.html content="A major milestone was reached in July 2023,
with v7.0.0, the first release that came with fully automated tests." %}

## The early years - a personal journey

My interest in system programming dates from the first moments when
I started to play with computers. After learning FORTRAN in my first
high school year, I wondered how does the refrigerator size box
understand my
programs and how is it able to run multiple jobs at the same time.

{% include note.html content="The journey from this child curiosity
to µOS++ was long and fascinating." %}

### The Unix era and the first scheduler

In 1985 I met **Unix** for the first time, running on a PDP-11 compatible
mini-computer and, remarkable for those years, also accompanied by a
tape with the
[Version 7 Unix](http://en.wikipedia.org/wiki/Version_7_Unix) source code.

Not only that I studied it thoroughly, but by 1989 I already had **a functional
C compiler** ported on [Motorola MC68000](http://en.wikipedia.org/wiki/68000)
microprocessor, and a **good knowledge of the Unix kernel**.

This knowledge of the **context switching mechanism** was put to test when
I needed a multi-threaded scheduler running on
[Zilog Z80](http://en.wikipedia.org/wiki/Z80); later it was successfully
used in a commercial product (a telex machine).

{% include note.html content="This scheduler can be considered
the precursor of µOS++." %}

### The eCos experience (CDL & C++)

In the first years of the 2000s I was involved in a project
running on the [Intel i960](http://en.wikipedia.org/wiki/I960) CPU,
which also required a multi-threaded system.

To implement it, I chose [eCos](http://ecos.sourceware.org), which was the
major RTOS available as open source and with a permissive license.

There were many remarkable things to be noted about **eCos**, but
relevant for this story are two: first, at its core, it was **written in C++**,
(a language that I met in 1990 when I ported the **AT&T C++ translator** on
lots of Unix machines)
and, second, that it came with an elaborate **mechanism for managing
project configurations**, the
[eCos CDL](http://ecos.sourceware.org/docs-1.3.1/cdl/language.html),
which used [TCL](https://en.wikipedia.org/wiki/Tcl) scripts to
define the configuration metadata.

{% include note.html content="C++ is the reason behind the **++** in µOS++,
and eCos CDL is the reason behind
using a component based design for the planned
**xPack Project Builder** (tentatively called **xpmake**)." %}

By that time, `vi` and `make` appeared to be my friends, but the
experience of manually maintaining the **make** files turned into a
nightmare.

## Why a new embedded operating system?

There were many embedded operating systems available by the time
this project was initiated. However, the context I planned to use
this embedded system was slightly more specific, i.e. as firmware for
aviation instruments to be used in ultralight aircraft.

I started to experiment with aviation instruments several years before,
and one determining factor on the decision was an article stating
that for the design of aviation instruments, a framework is acceptable
if it allows to complete the design within one day. Although this
seems rather extreme, the idea is quite valid, and has important
consequences.

The first consequence is that **it promotes modular design**, i.e.
instead of a do-it-all box (a kind of a _Swiss army knife_ like design),
it is better to split the design into multiple independent modules,
each performing a specific job.

The second consequence is that **the framework should be very well
structured**, easily configurable and as light as possible, in order
to run with limited resources on simple processors. By well structured
I mean modular, object oriented design, favouring a high degree of
code reuse, both between related projects, and between different
hardware platforms.

After a long and detailed search, there were many partial solutions
identified, but none was able to address all the requirements; so,
based on my previous experience with multi-tasking systems, the
decision to develop an in-house solution came naturally.

However, this decision was clouded from the very beginning by a doubt:
_"How do I know that my software really works as expected?"_ And
_"What is the best way to ensure that everything still works fine
after I make some changes?"_.

{% include note.html content="This is where the need for thorough
testing comes into play. This permanent quest to improve the quality
will eventually lead
to the kindred **xPack project**, as a tool to automate testing." %}

## Why C++?

The decision for **C++** was a tough one, and I'm convinced it raises
a lot of questions and critics. However, I'm also convinced that it was
a good decision, and, those who take the time to seriously consider
it, will probably reach to the same conclusion.

First of all, by C++ I do not mean the full C++ implementation, but
a limited subset: no real time typing, possibly no multiple inheritance,
limited or no use of exceptions.
{% include note.html content="Writing object oriented code
is also possible in C, but the syntax is significantly more
complicated." %}
One common argument against C++ is the alleged performance
penalty, but most of those who claim this have no compiler expertise,
since for the subset of C++ that is needed for embedded applications
the performance gain for C vs C++ is null for regular classes, and
almost null for classes that require polymorphism.

Finally, the contributing factor on making the decision to use
C++ came after reading Michael Barr's book,
[Programming Embedded Systems in C and C++](http://www.amazon.com/Programming-Embedded-Systems-C/dp/1565923545),
that came with some good code samples written in C++.

## The µOS++ first edition

### The original AVR8 version

In the second half of the 2000s decade, I was searching for a solution
to write firmware for simple aviation instruments, running on
AVR-class microcontrollers. With eCos too heavy for resource restrained
devices, I decided to reimplement the Z80 scheduler on the
[Atmel AVR8](http://en.wikipedia.org/wiki/AVR8) microcontroller, and in 2007
I had the first functional version of
[µOS++](https://github.com/micro-os-plus/micro-os-plus-i).

{% include note.html content="Although the initial version ran
only on AVR8, the design was modular
and portable from the very beginning." %}

Central to the µOS++ design was the **scheduler** and the low-level
**synchronisation primitives**. Based on my previous Unix experience,
the main synchronisation primitives were inspired by the original
Unix `sleep()` and `wakeup()` primitives. Later they were changed
to better match the needs of multi-threaded systems,
but the basic functionality was more or less the same.

### The Eclipse encounter

Given the bad experience I had with manually maintaining **make** files,
it is no surprise that when I first met Eclipse, and discoverd
[CDT](https://github.com/eclipse-cdt/),
I immediately started to searched for a solution to use it for µOS++.

### GNU ARM Eclipse

The initial use of Eclipse CDT was quite difficult, since direct support for
embedded toolchains was not available.

At the same time I started to play with the new
[Arm Cortex-M](https://en.wikipedia.org/wiki/ARM_Cortex-M) devices,
which looked very promising, given how easy it is to implement the
context switching code and the scheduler timer.

{% include note.html content="The GNU ARM Eclipse was born,
as a solution that greatly simplified
the build process for µOS++ Cortex-M projects,
given the **CDT managed build** system,
which automatically generated the **make** files." %}

### The ARM Cortex M3 preliminary port

In 2009 the µOS++ was easily ported to
[ARM Cortex M3](https://en.wikipedia.org/wiki/ARM_Cortex-M),
during an evaluation phase for the next generation of the
aviation instruments.

### The AVR32 port

A more difficult and complex port of µOS++ was the
[Atmel AVR32](http://en.wikipedia.org/wiki/AVR32) port, done in 2011.
The difficulty was inherent to the hardware design of the AVR32
architecture, way less software-friendly than the ARM Cortex M3
(my personal feeling is that the ARM Cortex M3 design team
included a software guy, with good knowledge of operating system
intricacies, while the AVR32 architecture seems to be designed by
a team where access for software guys was strictly forbidden).

But not everything was bad with the AVR32 experience: since
this architecture uses 4 nested interrupts levels, now the µOS++
is able to properly handle nested interrupts.

Another significant addition to µOS++ was a mechanism to handle
very fast interrupts, required for some Hard Real Time applications.

### The testing dead-end

The initial enthusiasm of using Eclipse for building µOS++ applications
was soon
shaded by **the difficulties of building and running tests in a scriptable
environment**.

It must be mentioned that Eclipse CDT advertises a way of
running headless builds, but it proved unreliable, so the only
way of running test was manually, as regular Eclipse projects, which
was very inconvenient, to say the least.

{% include note.html content="With µOS++ already used in some
commercial projects, I was afraid that the lack of proper testing
will eventually bite; it did not, but each release still came with
a good load of stress." %}

## The µOS++ second edition

### The XCDL experimental version

The need for a second edition of µOS++ became obvious while
using it for several commercial projects, and active work
started in early 2013, after the
[XCDL](http://xcdl.github.io) (eXtended Components Definition Language)
project, implemented in Python, become functional.

The major criticism of the first edition was the lack of support for
[Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration) and
[Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development),
requirements more and more expected for modern projects.

Starting from scratch, the first version of a unit testing infrastructure
was implemented on the macOS synthetic platform.

The new system was renamed
[µOS++ SE](https://github.com/micro-os-plus/micro-os-plus-ii) as the
**Second Edition**.

The µOS++ SE project wiki was created, initially
hosted in the SourceForge project web space, then moved to a private
domain due to major SourceForge shortcomings.

{% include note.html content="The experience with the XCDL component
based configuration and build
system was considered a success, and it validated the concept." %}

The major weakness was the limitation introduced by
having the build configuration metadata as a Python code:
it could be edited only manually, and not via a GUI based
IDE, like, for example, the C/C++ settings in Eclipse CDT,
which writes back the XML configuration file.

### The Cortex-M port

In April 2013 the general framework with functional startup
code for STM32F1 and STM32F4 was implemented and tested on several
development boards.

### Functional full version

The project grew steadily, with the scheduler running on most STM32Fx
cores (in pre-emptive mode), and on synthetic POSIX platforms
(OS X and GNU/Linux, in cooperative mode). The sources compiled
without warnings on GCC 4.7, GCC 4.8 and LLVM clang 3.2/3.3,
in 32/64-bit variants, and a multitude of tests were running
on OS X and Ubuntu.

The repository increased steadily, and in October 2013 it numbered
more than 700 files, with more than 150K lines.

Acknowledging the need for a better Eclipse integration, in October 2013
the development was temporarily interrupted, with focus changed to
GNU ARM Eclipse plug-ins, later rebranded as the
[Eclipse Embedded CDT](https://eclipse-embed-cdt.github.io).

{% include note.html content="The quest for a solution to
automate testing continued, with no answer in the short term." %}

## The µOS++ third edition

### February 2014

The need for the third edition of µOS++ become evident after the
experience with GNU ARM Eclipse plug-ins and the obvious need to
better integrate µOS++ with Eclipse.

Work on µOS++ IIIe officially started with the creation of a new
Git repository [micro-os-plus](https://github.com/micro-os-plus)
and a new [web](http://micro-os-plus.github.io).

### CMSIS packages

In mid 2014 the documentation for the new
[ARM CMSIS Packs](https://www.open-cmsis-pack.org) was
released; some evaluations were performed with the Keil tools and
an experimental package manager was implemented as an Eclipse plug-in;
something derived from the CMSIS packages was considered to be a possible
candidate for a distribution mechanism, but later the idea was dismissed,
as unsuitable.

Also a more C-friendly approach was adopted, by adding **C wrappers** to the
core C++ API.

### More and more testing

Compared to the previous edition, testing was more thorough,
using the **CMSIS OS Validator** and several stress tests. The majority
of tests were performed via the synthetic POSIX platform on macOS
and Linux; another fair share of the tests were performed via QEMU
on the emulated STM32F4DISCOVERY, and only a very small were performed
on physical hardware.

But, as the number of tests and their complexity grew,
the problem of automating these tests became more and more critical.

{% include note.html content="I ended with the tests split
across multiple projects, each with multiple
Eclipse projects, each with different prerequisites and workflows to build
and invoke the tests, up to the point when everything became
un-manageable." %}

### The XCDL packages and the migration to GitHub

Further research concluded that CMSIS Packs alone are not enough,
and a more elaborate solution is necessary; initially the
[yotta](https://github.com/ARMmbed/yotta) tool was considered,
and in late 2015 the first XCDL packs format based on yotta were tested.

In December 2015 the project was migrated to GitHub and restructured as
XCDL packs, stored as separate sub-projects.

Later Arm decided to discontinue development for yotta,
and another solution was needed.

### CMSIS++

In January 2016, the CMSIS++ repository was created, with a double intent:
to act as a proposal for the next generation CMSIS, due in June 2016,
and to serve as a portable API for the third edition of µOS++.

Unfortunately, the experience with CMSIS RTOS, CMSIS Drivers and
other components
was disappointing (to say the least), and further support for CMSIS
was no longer considered appropriate.

### RISC-V

In mid 2017 support for **RISC-V** was added and, for more portability,
the use of the CMSIS name, associated with ARM, was discontinued.

### The npm/xpm era

While searching for a new solution to automate the tests for
the µOS++ projects, I discovered
[npm](https://en.wikipedia.org/wiki/Npm_(software)) as the industry
standard package manager for JavaScript packages, and the
[npmjs.com](https://www.npmjs.com) as the hugely popular public
repository, with millions of packages and billions of downloads.

I contacted Isaac Schlueter, its author, and asked if it is acceptable to
use the repository for non-JavaScript packages; he replied that unless
I do something really stupid like storing my photo library there,
nobody will chase down my packages.

{% include note.html content="This was a very kind answer,
and it was the turning point
in the xPack project, which became part of the node/npm ecosystem." %}

On April 2017 the first release of **xpm** was ready, and packages
managed by it were named **xPacks**.

### The binary xPacks

In the initial design, the xPacks were intended to store C/C++ source
files, and they worked just fine.

However, while **xpm** was used to automate testing, it was noted that
tests need to run with multiple toolchains, even multiple
versions of the same
toolchain, and these tools can also be defined as `devDependencies`
(development dependencies).

{% include note.html content="**xpm** was extended to also support
installing binary packages, and a new class of tools was created as
[xPack 3rd Party Development Tools](https://github.com/xpack-dev-tools/)." %}

### The xPack Build Box (XBB) nightmare

Building the multi-platform binary packages proved a very difficult
task. The challenge was how to address the contradiction between having to
build the **very latest tools** that run on **very old
versions** of the corresponding operating systems (Windows, GNU/Linux
and macOS).

The initial [XBB](https://github.com/xpack/xpack-build-box)
solution was to start with a Docker image of an old release
(Ubuntu 12, to also provide support for RedHat 7), and compile from
sources the required new versions of the compilers and other
development tools.
Unfortunately this was not always possible directly,
and an extra step was needed,
to compile a bootstrap set of tools with some slightly older versions,
and with them
to compile the most recent versions.

This got more and more complicated, and the Docker image grew to
4-5 GB; the builds took many hours to complete,
especially for the Raspberry Pi OS images.

The solution was functional, it eventually allowed to build all GCC
toolchains,
native and cross for Arm & RISC-V, but maintenance for the Docker
images was close to _mission impossible_; after the second
release it was evident that this is a dead end and a
better solution is needed.

### The XBB breakthrough

In the last months of 2022, work on a new XBB release started, and was
completed in February 2023, with XBB v5.0.0.

The new solution was a big improvement, since it used completely
standard Ubuntu 18 Docker images, without any customisations, and all modern
tools were installed with **xpm** as existing binary xPacks.

This was a **major milestone** in the life of xPack project, since it
proved two things:

- that **the technology is standalone** with the newer versions of the tools
being built with existing xPacks
- that the **xpm** workflow is **generic enough** to be usable not only for
small embedded projects, but for complex tools, like compilers.

{% include note.html content="With this milestone reached, the problem of
binary dependencies required for
µOS++ was considered solved. The light at the end of the tunnel was real,
xPacks will eventually automate testing for the µOS++ projects." %}

### µTest++ - a lightweight testing framework for embedded platforms

The early µOS++ tests used the CMSIS OS validation suite, and there
were several attempts to use a testing framework for other tests,
but the results were unsatisfactory,
since the frameworks required a lot of resources.

Further work was done with
[Boost UT](https://github.com/xpack-3rd-party/boost-ut-xpack),
[Catch2](https://github.com/xpack-3rd-party/catch2-xpack),
[GoogleTest](https://github.com/xpack-3rd-party/googletest-xpack),
which resulted in functional packages that can be used in projects.

They were all functional, but quite heavy and not really suited
for testing embedded projects; thus a lighter solution was considered.

This resulted in
[µTest++](https://github.com/micro-os-plus/micro-test-plus-xpack),
released in February 2021,
which was initially inspired by [node tap](https://node-tap.org).

In a later iteration it was reworked, and since v3.x (released in
April 2022), it provides most of the **Boost UT** primitives,
but with a lighter footprint.

### The utils-list source code xPack

With most of the tools in place, the
[@micro-os-plus/utils-lists](https://github.com/micro-os-plus/utils-lists-xpack/)
project was selected as the first candidate to be fully tested
using the new xPack tools.

The result was a very large set of tests, running both on the native
platform (gcc and clang), and on lots of embedded platforms
(Arm **Cortex-M0 & M7**, **Cortex A15 & A72**, **RISC-V 32/64**), running on
QEMU. I doubt that there are many projects so thoroughly tested
on so many platforms and build tools.

{% include note.html content="This was finally in line with the
expectations. There are good chances
that the automation provided by xPacks will allow me to sleep well
after each µOS++ release."%}

### The Doxygen configuration

In April 2023 the documentation for the project was **utils-list**
added, using
a site generated by Doxygen and a custom CSS theme, resulting in a
nice [web site](https://micro-os-plus.github.io/utils-lists-xpack/).

### µOS++ v7.0.0 - the first fully tested release

A major milestone was reached in July 2023: after updating the project
to the more strict requirements of modern toolchains (GCC & clang),
the tests that previously were performed manually in Eclipse were
reworked to use CMake and the workflow was fully automated with
**xpm** in order to allow the multi-platform tests to run in
scriptable CI environments, like GitHub Actions.

The tests run natively on the synthetic POSIX platform (macOS & GNU/Linux)
compiled with multiple GCC & clang versions,
and on Cortex-M0+/M3/M7F, emulated by QEMU.

## The µOS++ fourth edition

The next edition of µOS++ aims to further modularise the project
in order to better test each separate module.

Work has already started to replace the monolithic repository
with multiple xpm/npm packages.

### To be continued

...
