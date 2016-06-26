---
layout: old-wiki-page
permalink: /micro-os-plus/i/Project_history/
title: Project history
author: Liviu Ionescu

date: 2011-03-01 15:22:29 +0000

---

The early years
===============

My interest in system programming dates from the first moments when I started to play with computers. After learning FORTRAN in my first college year, I wondered how does the big computer compile my programs and how is it able to run multiple jobs at the same time. However, my first hands-on experience with multitasking code was in the late 80s, when I ported the [Version 7 Unix](http://en.wikipedia.org/wiki/Version_7_Unix) kernel on the [Motorola MC68000](http://en.wikipedia.org/wiki/68000) microprocessor. Soon after this I designed and implemented a simple scheduler running on [Zilog Z80](http://en.wikipedia.org/wiki/Z80), that was successfully used in a commercial product. Another significant step towards the embedded world was in the late 90s, when I ported [eCos](http://en.wikipedia.org/wiki/ECos) to run on [Intel i960](http://en.wikipedia.org/wiki/I960).

Why a new embedded operating system?
====================================

There were many embedded operating systems available by the time this project was initiated. However, the context I planned to use this embedded OS was slightly more specific, i.e. aviation instruments. I started to experiment with aviation instruments some years before, and one determining factor on the decision was an article stating that for the design of an aviation instrument, a framework is acceptable if it allows to complete the design within one day. Although this seems rather extreme, the idea is quite valid, and has important consequences.

The first consequence is that is promotes modular design, i.e. instead of do-it-all box (a kind of a Swiss army knife like design), it is better to split the design into multiple independent modules, each at the limit of simplicity.

The second consequence is that the framework should be very well structured, easily configurable and as light as possible, in order to run with limited resources on simple processors. By well structured I understand modular, object oriented design, favouring a high degree of code reuse, both between related projects, and between different hardware platforms.

After a long and detailed search, there were many partial solutions identified, but none was able to address all the requirements; so, based on my previous experience with multitasking systems, the decision to develop an in-house solution came naturally.

Why C++?
========

The decision for C++ was a tough one, and I'm convinced it raises a lot of questions and critics. However, I'm also convinced it was a good decision, and those who take the time to seriously consider it will probably reach to the same conclusion.

First of all, by C++ I do not mean the full C++ implementation, but a limited subset: no exceptions, no real time typing, no templates, no multiple inheritance; more or less a kind of *Embedded C++*, i.e. a more structured way of writing C. Writing object oriented code is perfectly possible in C too, but the syntax is significantly more complex. One usual argument agains C++ is a performance penalty, but most of those who claim this have no compile expertise, since for the subset of C++ that is needed for embedded applications the performance gain for C vs C++ is null for regular classes, and almost null for classes that require polymorphism.

Finally, the contributing factor on making the decision to use C++ came after reading Michael Barr's book, [Programming Embedded Systems in C and C++](http://www.amazon.com/Programming-Embedded-Systems-C/dp/1565923545), that came with some good code samples written in C++.

The original AVR8 version
=========================

The original µOS++ implementation was done in 2007, and although initially it was intended to run on [Atmel AVR8](http://en.wikipedia.org/wiki/AVR8) processors, the design was modular and portable from the very beginning.

Central to the µOS++ design was the scheduler and the low-level synchronisation primitives. Based on my previous Unix experience, the main synchronisation primitives were inspired by the original Unix **sleep()** and **wakeup()** primitives. However, the names, and slightly the functionality, were also influenced by the Java Threads implmentation of **wait()** and **notify()**, and so the current names of **eventWait()** and **eventNotify()** were born.

The ARM Cortex M3 port
======================

In 2009 the µOS++ was easily ported to [ARM](http://en.wikipedia.org/wiki/ARM_architecture) Cortex M3, during an evaluation phase for the next generation of the aviation instruments.

The AVR32 port
==============

A more difficult and complex port of µOS++ was the [Atmel AVR32](http://en.wikipedia.org/wiki/AVR32) port, done in 2011. The difficulty was inherent to the hardware design of the AVR32 architecture, way less software-friendly than the ARM Cortex M3 (my personal feeling is that the ARM Cortex M3 design team was leaded by a software guy, with good knowledge of operating system intricacies, while the Avr32 architecture seems to be designed by a team where access for software guys was strictly forbidden).

But not everything was bad with the AVR32 experience: since this architecture uses 4 nested interrupts levels, now the µOS++ is able to properly handle nested interrupts.

Another significant addition to µOS++ was a basic Real Time functionality.
