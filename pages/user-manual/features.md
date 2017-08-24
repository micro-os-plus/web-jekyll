---
layout: page
lang: en
permalink: /user-manual/features/
title: µOS++ IIIe features
author: Liviu Ionescu

date: 2016-07-03 01:04:00 +0300

---

## Overview

µOS++ IIIe is a POSIX-like, portable, open source, royalty-free, multi-tasking real-time operating system intended for 32/64-bits embedded applications.

µOS++ IIIe is written in **modern C++ 11**, with C++ applications in mind, but also provides equally functional C APIs.

µOS++ IIIe is the third edition of µOS++, offering all of the services expected from a modern real-time system including resource management, synchronization, inter-thread communication, and more. µOS++ IIIe also offers many features not found in many other real-time systems, such as both C++ and C APIs, POSIX-like threads, POSIX synchronisation objects, use of standard C++ memory allocators, and more.

## Features

Here is a list of features provided by µOS++ IIIe.

### Source code

µOS++ is an **open source project**, provided under the very **permissive terms of the MIT license**.

The source code availability not only helps debugging, but also greatly improves the general understanding of the entire run environment, resulting in better and more robust applications.

### Multiple C++ and C APIs

µOS++ provides services via multiple APIs, covering both C++ and C applications.

The supported APIs are:

- µOS++ RTOS C++ API - the native µOS++ IIIe C++ API, giving direct access to the system services;
- µOS++ RTOS C API - a 1:1 C wrapper on top of the C++ API;
- ISO C++ Threads API - an implementation of the standard ISO threads on top of the C++ API;
- ARM CMSIS RTOS v1 API - a compatibility layer with ARM CMSIS RTOS

The µOS++ RTOS C API allows to write plain C applications, even if the RTOS core is written in C++.

The ARM CMSIS RTOS API allows to run legacy applications, written for the ARM RTOS API.

The ISO C++ Threads API provides a convenient way to run ISO standard code with almost no changes.

### POSIX-like APIs

The design of the core APIs was heavily influenced by the POSIX threads specs. From this point of view, µOS++ can also be seen as **POSIX++**, a C++ version of POSIX.

POSIX compatibility is a very important feature, since POSIX is a mature and well established portable standard, and the experience gained while using POSIX on larger systems can improve productivity of embedded application developers too.

### ISO thread C++ API

µOS++ also implements the standard ISO C++ thread API, including the `chrono` functionality.

The ISO C++ 14882:2011 introduced a standard API for threads, mutexes, condition variables, locks, time related functions, etc.

This API is relatively easy to use, the overhead is low, and, if sharing code with some server environments is required, this may be a very interesting solution.

### Consistent APIs

The APIs used by µOS++ are highly consistent. Once familiar with the coding conventions used, it is simple to predict the functions to call for the services required, and even predict which arguments are needed. For example, in the C API a pointer to an object is always the first argument, most functions return a POSIX error code, etc.

This translates into increased productivity and improved code readability over time.

### Preemptive multi-tasking

µOS++ implements a priority based, preemptive, multi-tasking scheduler and therefore, µOS++ always runs the most important ready-to-run thread.

For real-time systems, this improves the reaction speed and helps meeting the required deadlines.

### Round robin scheduling

µOS++ allows multiple threads to run at the same priority level. When multiple threads at the same priority are ready to run, they are scheduled in a round-robin way.

This scheduling algorithm provides a fair distribution of the CPU time to common threads that do not have special needs, and can all share a common priority.

### Low interrupt disable time

µOS++ has a number of internal data structures and variables that it needs to access atomically. To ensure this, µOS++ disables interrupts for very short periods, to ensure minimal interrupt latency.

Keeping the critical sections short gives a chance to fast interrupts to occur and system responsiveness is increased.

### Safe nested critical sections

To avoid subtle bugs, the µOS++ critical sections are designed to be easily nested, saving the initial status during enter and restoring it while exiting.

This save implementation allows to invoke µOS++ system calls from any environment, including from callbacks coming from code using poorly implemented critical sections (for example those using counters to tell when to re-enable interrupts).

To be noted that the reverse is not true, calling library functions that implement critical sections using counters from environments where the interrupts are disabled possibly introduces a synchronisation problem, since the those functions will erroneously enable the interrupts.

### Configurable

The footprint (both code and data) can be adjusted based on the requirements of the application. This is performed at compile time through many available `#defines` (see `os-app-config.h`). µOS++ also performs a number of run-time checks on arguments passed to its services, like not passing NULL pointers, not calling thread level services from ISRs, that arguments are within allowable range, and options specified are valid, etc. These checks can be disabled (at compile time) to further reduce the code footprint and improve performance.

### Modular

By a careful design, only those functions that are required are linked into an application, keeping the ROM size small.

### Portable

By design µOS++ is highly portable; it was developed mostly on macOS and its tests are constantly run on both 32 and 64-bits platforms.

### ROMable

µOS++ was designed especially for embedded systems and can be ROMed along with the application code.

This is important for modern microcontrollers, which include large amounts of flash internally, and can execute code from there, without having to copy it to RAM.

### Fully statically allocated

µOS++ itself is fully statically allocated, it does not require dynamic memory, which makes it a perfect fit for special applications that cannot tolerate the risks associated with fragmentation.

### Users choice of memory allocation

For objects that require additional memory, the user has full control on using either **statically** or **dynamically** allocated memory.

µOS++ can be used to build special applications that are not allowed to use dynamic allocations.

### Custom memory allocators

In the µOS++ C++ API, all objects requiring additional memory can be configured to use a custom memory allocator, so, at the limit, each object can be allocated using a separate allocator.

### Unlimited number of threads

µOS++ supports an unlimited number of threads. From a practical standpoint, however, the number of threads is actually limited by the amount of memory (both code and data space) that the processor has access to. Each thread requires its own stack; µOS++ provides features to allow stack growth to be monitored at run-time.

The default stack size and the minimum stack size can be configured by the user.

### Unlimited number of system objects

µOS++ allows for any number of threads, semaphores, mutexes, event flags, message queues, timers, memory pools, etc. The user at run-time allocates all system objects, either as global static objects, stack objects, or dynamically allocated objects.

Not having to statically define at compile time the maximum number of objects is very convenient.

### POSIX mutexes

Mutexes with POSIX functionality are provided for resource management. Both normal and recursive mutexes are available. Mutexes can be configured to have built-in priority inheritance, which eliminate unbounded priority inversions.

### Software timers

Timers are countdown counters that perform a user-definable action upon counting down to 0. Each timer can have its own action and, if a timer is periodic, the timer is automatically reloaded and the action is executed every time the countdown reaches zero.

### Thread Signals

µOS++ allows an ISR or thread to directly signal a thread. This avoids having to create an intermediate system object such as a semaphore or event flag just to signal a thread, and results in better performance.

### Thread user data

Threads can include a user-definable user data structure, where the application can store any custom data.

The definition of this data structure is a plain C `struct`, and the content is fully under user control.

### Error checking

µOS++ verifies that NULL pointers are not passed, that the user is not calling thread-level services from ISRs, that arguments are within allowable range, that options specified are valid, that a handler is passed to the proper object as part of the arguments to services that manipulate the desired object, and more.

Generally these additional validations are enabled in the Debug configurations, and disabled in Release, to save significant space and some run-time.

### Thread statistics

µOS++ has built-in features to measure the execution time of each thread, stack usage, the number of times a thread executes, CPU usage, and more.

This can be used monitor the system behaviour at run-time, and detect possible busy wait inefficient implementations.

### Deadlock prevention

All of the µOS++ blocking calls have versions that include timeouts, which help avoid deadlocks.

### Object names

Each µOS++ system object can have a name associated with it. This makes it easy to recognize what the object is assigned to. Assign a name to a thread, a semaphore, a mutex, an event flag group, a message queue, a memory pool, and a timer. The object name can have any length, but must be NULL terminated.

These names can be inspected during debug sessions, to identify objects, and can also be displayed by advanced instrumentation tools.

### Support for thread aware debuggers

This feature allows thread aware debuggers to examine and display µOS++ variables and data structures in a user-friendly way. (Work in progress).

### Support for instrumentation

This feature allows integration with instrumentation tools like SEGGER SystemView. (Work in progress).

### Multiple clocks

The classic solution for handling time in most embedded systems is to use the scheduler timer. By default in µOS++ the resolution for this clock is 1 ms, acceptable for most applications.

µOS++ also defines a standard API to access the real-time clock, which has a resolution of 1 sec, and can be used to configure timeouts even when the CPU is in deep sleep.

For accurate time measurements, down to the CPU cycle level, a high resolution timer derived from the scheduler timer, is also available.

µOS++ provides a common API for all clocks, and all synchronisation objects that can be configured to use any of the available clocks.
