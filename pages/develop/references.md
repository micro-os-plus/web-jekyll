---
layout: page
lang: en
permalink: /develop/references/
title: References
author: Liviu Ionescu

date: 2014-11-16 08:48:09 +0000

---

## Standards and style

-   [IEEE Std 830-1998: IEEE Recommended Practice for Software Requirements Specifications](http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=720574), published in 1998
-   [MISRA C++:2008 Guidelines for the use of the C++ language in critical systems](https://www.misra.org.uk/Publications/tabid/57/Default.aspx#label-cpp), by Motor Industry Software Reliability Association, published in 2008
-   [Joint Strike Fighter Air Vehicle C++ Coding Standards](http://www.stroustrup.com/JSF-AV-rules.pdf), Lockheed Martin Corporation Doc. No. 2RDU00001 Rev D, dated June 2007
-   ISO/IEC 14882:2011 Information technology — Programming languages — C++
-   [C++11 - the new ISO C++ standard](http://www.stroustrup.com/C++11FAQ.html) - by Bjarne Stroustrup; although not really a standard, it reflects Stroustrup's thoughts about the standard, and it is also a great collection of links and references.
-   [Technical Report on C++ Performance](http://www.open-std.org/jtc1/sc22/wg21/docs/TR18015.pdf) - ISO/IEC TR 18015:2006(E)

## Embedded operating systems

Note: Since GNU/Linux derived embedded systems are intended for a different class of applications, they currently do not make the subject of this project.

### Written in C++

-   [eCos](http://ecos.sourceware.org/) - *The embedded configurable operating system* by Cygnus Solutions ([Wikipedia](http://en.wikipedia.org/wiki/ECos))
-   [ScmRTOS](http://scmrtos.sourceforge.net/ScmRTOS) - Single-Chip Microcontroller Real-Time Operating System
-   [Miosix embedded OS](http://miosix.org/index.html) - a kernel designed to run on 32bit microcontrollers; supports a priority-based scheduler, an innovative scheduler based on control theory which is the subject of academic research, and the EDF scheduler

### Written in C

-   [µC/OS-III](http://micrium.com/rtos/ucosiii/overview/) - **µC/OS-III** is a highly portable, ROMable, scalable, preemptive, real-time, deterministic, multitasking kernel for microprocessors, microcontrollers and DSPs, by [Micrium](http://micrium.com).
- [threadX](http://rtos.com/products/threadx/) - **ThreadX** has many advanced features, including its picokernel architecture, preemption-threshold scheduling, event-chaining, execution profiling, performance metrics, and system event tracing.
- [smx](http://www.smxrtos.com/rtos/kernel/smx.htm) - **smx** is an advanced RTOS kernel, which offers unique features related to memory management. 
-   [FreeRTOS](http://www.freertos.org) - is probably the most popular open source, cross platform, real time operating system, available from [Real Time Engineers Ltd.](http://www.freertos.org/RTOS-contact-and-support.html)
-   [CMSIS with RTOS API](http://www.arm.com/about/newsroom/arm-extends-cmsis-with-rtos-api-and-system-view-description.php) - CMSIS 3.0 is expanded with a standardized API for Real-Time Operating System (RTOS) kernels and support for System View Description (SVD) XML files; [Hitex PDF](http://www.hitex.co.uk/fileadmin/uk-files/downloads/ARM%20Day/Hitex%20Conference%20-%20CMSIS-RTOS%20Feabhas.pdf)
-   [Contiki](http://www.contiki-os.org) - The Open Source OS for the Internet of Things
-   [TNKernel](http://www.tnkernel.com/index.html) - a compact and very fast real-time kernel for the embedded 32/16/8 bits microprocessors inspired by the μITRON 4.0 specification
-   [NuttX](http://nuttx.org) - the NuttX Real-Time Operating System with TCP/IP, USB and more
-   [ChibiOS/RT](http://www.chibios.org/) - a complete, portable, open source, compact and extremely fast RTOS (German flavour)
-   [TinyOS](https://github.com/tinyos) - an open source, BSD-licensed operating system designed for low-power wireless devices
-   [RT-Thread](https://github.com/RT-Thread/rt-thread) - an open source real-time operating system for embedded devices
-   [uKOS-II](http://www.ukos.ch/) - RTOS µKernel

### Quantum Leaps (QP)

QP Active Object (Actor) Frameworks is a [SourceForge project](http://sourceforge.net/projects/qpc/). The QP family consists of QP/C, QP/C++, and QP-nano frameworks, which are all strictly quality controlled, superbly documented, and commercially licensable. It is backed by [Quantum Leaps LLC](http://www.state-machine.com) who also published a very good book [Practical UML Statecharts in C/C++, Second Edition: Event-Driven Programming for Embedded Systems](https://www.crcpress.com/Practical-UML-Statecharts-in-CC-Event-Driven-Programming-for-Embedded/Samek/p/book/9780750687065) also available from [Amazon](https://www.amazon.com/Practical-UML-Statecharts-Event-Driven-Programming/dp/0750687061).

## C/C++ language & libraries

-   [GNU Tools for ARM Embedded Processors](http://launchpad.net/gcc-arm-embedded) - Pre-built GNU toolchain from ARM Cortex-M & Cortex-R processors (Cortex-M0/M0+/M3/M4, Cortex-R4/R5)
-   [C++ reference](http://en.cppreference.com/w/cpp) - a wiki with lots of C++ language and libraries references
-   ["libc++" C++ Standard Library](http://libcxx.llvm.org) - a LLVM sub-project, also available via [ViewVC](http://llvm.org/viewvc/llvm-project/libcxx/trunk/)
-   [libstdc++-v3](http://gcc.gnu.org/libstdc++/) - The GNU Standard C++ Library v3, part of the GNU GCC
-   [GNU Common C++ and GNU uCommon C++](http://www.gnu.org/software/commoncpp/) - are both very portable and highly optimized class framework for writing C++ applications; *stream* classes are not included;
    -   [GNU Common C++](https://www.gnu.org/software/commoncpp/)
-   [Apache C++ Standard Library (STDCXX)](http://stdcxx.apache.org/index.html) - also available via [ViewVC](http://svn.apache.org/viewvc/stdcxx/trunk/)
-   [uClibc++](http://cxx.uclibc.org) - an embedded C++ library, also available for [Git browse](http://git.uclibc.org/uClibc++/); a good inspiration for embedded systems;
-   [uSTL](http://ustl.sourceforge.net) - the small STL library; a port of usTL 1.3 is also available on eCos; [SourceForge](http://sourceforge.net/projects/ustl/), including [Git browse](http://sourceforge.net/p/ustl/code/)
-   [boost](http://www.boost.org) - portable C++ source libraries; all kind of libraries, interesting to look at, but sometimes quite complicated;
-   [Platinum](http://www.pt-framework.org/htdocs/classes.html) - Platinum (Pt) is a comprehensive C++ framework, which allows developers to write high-performance applications for many platforms with only one codebase.
-   [Dinkum EC++ Library](http://www.qnx.com/developers/docs/6.4.1/dinkum_en/ecpp/index.html) - a conforming implementation of the Embedded C++ library, as specified by the Embedded C++ Technical Committee.
-   [Thumb2 Newlib Toolchain](http://dekar.wc3edit.net/2012/10/11/the-power-of-tnt-is-at-your-disposal/) - a GCC/Newlib based toolchain project
-   [libopencm3](http://www.libopencm3.org/wiki/Main_Page) - a free firmware library for various ARM Cortex-M3 microcontrollers including ST STM32, (a very elaborate doxygen configuration)
-   [STM32plus](http://andybrown.me.uk/wk/2013/02/10/stm32plus-2-0-0/) - a C++ library for STM32
-   [libstm32pp](http://github.com/JorgeAparicio/libstm32pp) - A template peripheral library for the STM32 microcontrollers, written in C++
- [xpcc](http://xpcc.io) - C++ microcontroller framework; efficient enough to be deployed on a small ATtiny, yet powerful enough to make use of advanced capabilities found on the 32bit ARM Cortex-M
- [etlcpp](http://www.etlcpp.com) - A C++ template library for embedded applications

## TCP/IP libraries

-   [lwIP](http://savannah.nongnu.org/projects/lwip/) - A Lightweight TCP/IP stack
-   [uIP](http://sourceforge.net/projects/uip-stack/) - The uIP Embedded TCP/IP Stack
-   [UDP/IP](http://www.freertos.org/FreeRTOS-Plus/FreeRTOS_Plus_UDP/FreeRTOS_Plus_UDP.shtml) - a Tiny Embedded UDP/IP Stack Implementation for FreeRTOS
-   [Practical C++ Sockets](http://cs.ecs.baylor.edu/~donahoo/practical/CSockets/practical/) - provides wrapper classes for a subset of the Berkeley C Socket API for TCP and UDP sockets
project
-   [C/C++ Sockets Library](https://github.com/dermesser/libsocket) - The ultimate socket library for C and C++
-   [Polar SSL](http://polarssl.org) - Straighforward, Secure Communication
-   [CycloneTCP](http://www.oryx-embedded.com/cyclone_tcp.html) - TCP/IP Solutions for Embedded Systems

## Testing

-   [Jenkins](http://jenkins-ci.org) - an extendable open source continuous integration server
-   [JUnit](http://junit.sourceforge.net) - the common Java framework for unit testing
-   [CppUnit](http://sourceforge.net/apps/mediawiki/cppunit/) - C++ port of JUnit
-   [CppTest](http://cpptest.sourceforge.net) - a portable and powerful, yet simple, unit testing framework for handling automated tests in C++
-   [xUnit++](http://bitbucket.org/moswald/xunit/wiki/Home) - a unit testing platform for C++
-   [Google Test](http://code.google.com/p/googletest/) - a great unit testing for C++
-   [Google Mock](http://code.google.com/p/googlemock/) - adds Hamcrest matchers and mocks

## Multi-tasking related links

-   [Python 3 threading](http://docs.python.org/3/library/threading.html) - thread-based parallelism
-   [Semaphores and other Wait-and-Signal mechanisms](http://www.uio.no/studier/emner/matnat/ifi/INF3150/h03/annet/slides/semaphores.pdf) - a PDF presentation

## Miscellaneous

-   [Doxygen](http://www.stack.nl/~dimitri/doxygen/index.html) - the de facto standard tool for generating documentation from annotated C++ sources

## Hardware

### Development boards

-   [LeafLabs](http://leaflabs.com) - a company that builds Maple, an ARM Cortex M3 board, programmed using an Arduino-like development environment.

## Books

-   [The C++ Standard Library - A Tutorial and Reference, 2nd Edition](http://www.cppstdlib.com) - The Best-Selling Programmer Resource - Now Updated for C++11
-   [Practical UML Statecharts in C/C++, Second Edition: Event-Driven Programming for Embedded Systems](https://www.crcpress.com/Practical-UML-Statecharts-in-CC-Event-Driven-Programming-for-Embedded/Samek/p/book/9780750687065) available from [Amazon](http://www.amazon.com/exec/obidos/ASIN/0750687061/quantumleap06-20)
