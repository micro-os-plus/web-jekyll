---
layout: page
lang: en
permalink: /micro-os-plus/iii/project-history/
title: Project history
author: Liviu Ionescu

date: 2016-06-28 15:53:09 +0300

---

## The early years

My interest in system programming dates from the first moments when I started to play with computers. After learning FORTRAN in my first college year, I wondered how does the big computer compile my programs and how is it able to run multiple jobs at the same time. However, my first hands-on experience with multitasking code was in the late 80s, when I ported the [Version 7 Unix](http://en.wikipedia.org/wiki/Version_7_Unix) system on the [Motorola MC68000](http://en.wikipedia.org/wiki/68000) microprocessor. Soon after this I designed and implemented a simple scheduler running on [Zilog Z80](http://en.wikipedia.org/wiki/Z80), that was successfully used in a commercial product. Another significant step towards the embedded world was in the late 90s, when I ported [eCos](http://en.wikipedia.org/wiki/ECos) to run on [Intel i960](http://en.wikipedia.org/wiki/I960).

## Why a new embedded operating system?

There were many embedded operating systems available by the time this project was initiated. However, the context I planned to use this embedded OS was slightly more specific, i.e. aviation instruments. I started to experiment with aviation instruments some years before, and one determining factor on the decision was an article stating that for the design of an aviation instrument, a framework is acceptable if it allows to complete the design within one day. Although this seems rather extreme, the idea is quite valid, and has important consequences.

The first consequence is that is promotes modular design, i.e. instead of do-it-all box (a kind of a Swiss army knife like design), it is better to split the design into multiple independent modules, each at the limit of simplicity.

The second consequence is that the framework should be very well structured, easily configurable and as light as possible, in order to run with limited resources on simple processors. By well structured I understand modular, object oriented design, favouring a high degree of code reuse, both between related projects, and between different hardware platforms.

After a long and detailed search, there were many partial solutions identified, but none was able to address all the requirements; so, based on my previous experience with multitasking systems, the decision to develop an in-house solution came naturally.

## Why C++?

The decision for C++ was a tough one, and I'm convinced it raises a lot of questions and critics. However, I'm also convinced it was a good decision, and those who take the time to seriously consider it will probably reach the same conclusion.

First of all, by C++ I do not mean the full C++ implementation, but a limited subset: no exceptions, no real time typing, possibly no multiple inheritance; more or less a kind of *Embedded C++*, i.e. a more structured way of writing C. Writing object oriented code is perfectly possible in C too, but the syntax is significantly more complex. One usual argument agains C++ is a performance penalty, but most of those who claim this have no compile expertise, since for the subset of C++ that is needed for embedded applications the performance gain for C vs C++ is null for regular classes, and almost null for classes that require polymorphism.

Finally, the contributing factor on making the decision to use C++ came after reading Michael Barr's book, [Programming Embedded Systems in C and C++](http://www.amazon.com/Programming-Embedded-Systems-C/dp/1565923545), that came with some good code samples written in C++.

## The µOS++ first edition

### The original AVR8 version

The original µOS++ implementation was done in 2007, and although initially it was intended to run on [Atmel AVR8](http://en.wikipedia.org/wiki/AVR8) processors, the design was modular and portable from the very beginning.

Central to the µOS++ design was the scheduler and the low-level synchronisation primitives. Based on my previous Unix experience, the main synchronisation primitives were inspired by the original Unix `sleep()` and `wakeup()` primitives. However, the names, and slightly the functionality, were also influenced by the Java Threads implementation of `wait()` and `notify()`, and so the current names of `eventWait()` and `eventNotify()` were born.

### The ARM Cortex M3 port

In 2009 the µOS++ was easily ported to [ARM](http://en.wikipedia.org/wiki/ARM_architecture) Cortex M3, during an evaluation phase for the next generation of the aviation instruments.

### The AVR32 port

A more difficult and complex port of µOS++ was the [Atmel AVR32](http://en.wikipedia.org/wiki/AVR32) port, done in 2011. The difficulty was inherent to the hardware design of the AVR32 architecture, way less software-friendly than the ARM Cortex M3 (my personal feeling is that the ARM Cortex M3 design team was leaded by a software guy, with good knowledge of operating system intricacies, while the AVR32 architecture seems to be designed by a team where access for software guys was strictly forbidden).

But not everything was bad with the AVR32 experience: since this architecture uses 4 nested interrupts levels, now the µOS++ is able to properly handle nested interrupts.

Another significant addition to µOS++ was a mechanism to handle very fast interrupts, required for some Real Time applications.

## The µOS++ second edition

### Use of the XCDL experimental version

The need for second edition of µOS++ become obvious while using it for several commercial projects, but active work started in early 2013, after the XCDL (eXtended Components Definition Language) project become functional.

The major critics of the first version was the lack of support for [Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration) and [Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development), requirements more and more observed for modern projects.

Starting from scratch, the first version of a unit testing infrastructure was implemented on the OS X synthetic platform.

The SE project wiki was created, initially hosted in the SourceForge project web space, then moved to the livius.net domain due to major SourceForge shortcomings.

### The Cortex-M port

In April 2013 the general framework with functional initialisation code for STM32F1 and STM32F4 was implemented and tested on several development boards.

### Full version functional

The project grew steadily, with the core classes functional, the preemptive scheduler was functional on STM32Fx cores, and the cooperative also on synthetic POSIX platforms (OS X and GNU/Linux). The sources compiled without warnings on GCC 4.7, GCC 4.8 and LLVM clang 3.2/3.3, in 32/64-bit variants, and a multitude of tests were running on OS X and Ubuntu.

The repository increased steadily, and in Octomber 2013 it counted more than 700 files, with more than 150K lines.

Acknowledging the need for a better Eclipse integration, in Oct. 2013 the development was temporarily interrupted, with focus changes to [GNU ARM Eclipse plug-ins](http://gnuarmeclipse.livius.net/blog/).

## The µOS++ third edition

### February 2014

The need for the third edition of µOS++ become evident after the experience with GNU ARM Eclipse plug-ins and the obvious need to integrate µOS++ with Eclipse.

Work on µOS++ IIIe officially started with creation of the new Git repository and the update of the Wiki.

### March 2014

After experimenting with several implementation for the GpioPort & Pin, it was concluded that best readability for accessing the hardware registers is offered by using the CMSIS large device header; the second choice was offered by using RegisterAccess policies, with the advantage of compile time checks for read/write violations, but with loss of readability.

### CMSIS packages?

In mid 2014 the documentation for the ARM CMSIS packages was studied and some tests were performed with the Keil tools and an experimental package manager was implemented as an Eclipse plug-in; something derived from the CMSIS packages might become the preferred distribution mechanism.

A more C-friendly approach was adopted.

### xPacks/XCDL & migration to GitHub

Further research concluded that CMSIS Packs alone are not enough, and a more elaborate solution is necessary; inspired from yotta, in late 2015 the xPacks format was tested and adopted.

In December 2015 the project was migrated to GitHub and restructured as xPacks, stored as separate sub-projects.

### CMSIS++

In Jan 2016, the CMSIS++ repository was created, with a double intent: to act as a proposal for the next generation CMSIS, due in June 2016, and to serve as a portable API for the third edition of µOS++.

### CMSIS++ RTOS API v0.2

In June 20 the reference implementation was complete, with two functional ports, one for Cortex-M and one for a synthetic POSIX platform.

The CMSIS++ RTOS API was tagged as v0.2.1.
