---
layout: page
permalink: /user-manual/
title: User's manual
author: Liviu Ionescu

date: 2016-06-28 19:39:00 +0300

---

Note: The Users's Manual is currently work in progress.

## RTOS

### [Getting started with µOS++]({{ site.baseurl }}/user-manual/getting-started/)
  * [Overview]({{ site.baseurl }}/user-manual/getting-started/#overview)
    * [Multiple APIs]({{ site.baseurl }}/user-manual/getting-started/#multiple-apis)
  * [The `os_main()` and the main thread]({{ site.baseurl }}/user-manual/getting-started/#the-osmain-and-the-main-thread)
  * [Multiple thread applications]({{ site.baseurl }}/user-manual/getting-started/#multiple-thread-applications)

### [Basic concepts]({{ site.baseurl }}/user-manual/basic-concepts/)

* [Soft vs hard real-time systems]({{ site.baseurl }}/user-manual/basic-concepts/#soft-vs-hard-real-time-systems)
* [Superloop (foreground/background) applications]({{ site.baseurl }}/user-manual/basic-concepts/#superloop-foregroundbackground-applications)
* [Multi-tasking]({{ site.baseurl }}/user-manual/basic-concepts/#multi-tasking)
  * [Tasks]({{ site.baseurl }}/user-manual/basic-concepts/#tasks)
  * [Why multiple threads?]({{ site.baseurl }}/user-manual/basic-concepts/#why-multiple-threads)
  * [Threads & processes]({{ site.baseurl }}/user-manual/basic-concepts/#threads--processes)
  * [Blocking I/O]({{ site.baseurl }}/user-manual/basic-concepts/#blocking-io)
  * [The idle thread]({{ site.baseurl }}/user-manual/basic-concepts/#the-idle-thread)
  * [Sleep modes and power savings]({{ site.baseurl }}/user-manual/basic-concepts/#sleep-modes-and-power-savings)
  * [Context switching]({{ site.baseurl }}/user-manual/basic-concepts/#context-switching)
  * [Thread stacks]({{ site.baseurl }}/user-manual/basic-concepts/#thread-stacks)
  * [Cooperative vs preemptive multi-tasking]({{ site.baseurl }}/user-manual/basic-concepts/#cooperative-vs-preemptive-multi-tasking)
  * [Thread interruption/cancellation]({{ site.baseurl }}/user-manual/basic-concepts/#thread-interruption-cancellation)
* [Scheduling]({{ site.baseurl }}/user-manual/basic-concepts/#scheduling)
  * [Thread states]({{ site.baseurl }}/user-manual/basic-concepts/#thread-states)
  * [The READY list]({{ site.baseurl }}/user-manual/basic-concepts/#the-ready-list)
  * [Scheduling algorithms]({{ site.baseurl }}/user-manual/basic-concepts/#scheduling-algorithms)
  * [Round-robin vs priority scheduling]({{ site.baseurl }}/user-manual/basic-concepts/#round-robin-vs-priority-scheduling)
  * [Selecting thread priorities]({{ site.baseurl }}/user-manual/basic-concepts/#selecting-thread-priorities)
  * [Priority inversion / priority inheritance]({{ site.baseurl }}/user-manual/basic-concepts/#priority-inversion--priority-inheritance)
* [Communicating between threads and/or ISRs]({{ site.baseurl }}/user-manual/basic-concepts/#communicating-between-threads-andor-isrs)
  * [Periodic polling vs event waiting]({{ site.baseurl }}/user-manual/basic-concepts/#periodic-polling-vs-event-waiting)
  * [Passing messages]({{ site.baseurl }}/user-manual/basic-concepts/#passing-messages)
  * [Event flags]({{ site.baseurl }}/user-manual/basic-concepts/#event-flags)
  * [Semaphores]({{ site.baseurl }}/user-manual/basic-concepts/#semaphores)
* [Managing common resources]({{ site.baseurl }}/user-manual/basic-concepts/#managing-common-resources)
  * [Disable/enable interrupts]({{ site.baseurl }}/user-manual/basic-concepts/#disable-enable-interrupts)
  * [Lock/unlock the scheduler]({{ site.baseurl }}/user-manual/basic-concepts/#lock-unlock-the-scheduler)
  * [Counting semaphores]({{ site.baseurl }}/user-manual/basic-concepts/#counting-semaphores)
  * [Mutual exclusion (mutex)]({{ site.baseurl }}/user-manual/basic-concepts/#mutual-exclusion-mutex)
  * [Should a semaphore or a mutex be used?]({{ site.baseurl }}/user-manual/basic-concepts/#should-a-semaphore-or-a-mutex-be-used)
  * [Deadlock (or deadly embrace)]({{ site.baseurl }}/user-manual/basic-concepts/#deadlock-or-deadly-embrace)
* [Statically vs. dynamically allocated objects]({{ site.baseurl }}/user-manual/basic-concepts/#statically-vs-dynamically-allocated-objects)
  * [The system allocator]({{ site.baseurl }}/user-manual/basic-concepts/#the-system-allocator)
  * [Fragmentation]({{ site.baseurl }}/user-manual/basic-concepts/#fragmentation)

### [Features]({{ site.baseurl }}/user-manual/features/)

### Threads
  * Overview
  * Thread functions
  * Thread priorities
  * Creating threads
  * Changing thread priorities
  * Other thread functions
  * Destroying threads
  * The current thread
  * Thread states
  * Determining the size of a thread stack
  * Detecting stack overflow

### Thread signal flags
  * Overview
  * Raising thread signal flags
  * Waiting for thread signal flags
  * Other signal flags functions

### Semaphores
  * Overview
    * Binary semaphores
    * Counting semaphores
  * Creating semaphores
  * Posting tokens to semaphores
    * Posting tokens from ISRs
  * Waiting on semaphores
  * Other semaphore functions
  * Destroying semaphores  

### Mutexes
  * Overview
    * Normal mutexes
    * Recursive mutexes
  * Creating mutexes
  * Acquiring a mutex
  * Releasing a mutex
  * Other mutex functions
  * Destroying mutexes
  * Priority inversion
  * Priority inheritance
  * Deadlock (or deadly embrace)

### Condition variables
  * Overview
  * TODO

### Event flags
  * Overview
  * Creating event flags
  * Raising event flags
    * Raising event flags from ISRs
  * Waiting for event flags
  * Other event flags functions
  * Destroying event flags

### Message queues
  * Overview
  * Queue storage
  * Message priorities
  * Creating queues
  * Sending messages to queues
    * Sending messages from ISRs
  * Receiving messages from queues
  * Other message queue functions
  * Destroying queues

### Fixed size memory pools
  * Overview
  * Pool storage
  * Creating memory pools
  * Getting a memory block
    * Getting a memory block from ISRs
  * Returning a memory block
  * Other memory pools functions
  * Destroying memory pools

### Software timers
  * Overview
  * Timer functions
  * Creating timers
  * Start a timer
  * Stop a timer
  * Other timer functions
  * Destroying timers

### Clocks
  * Overview
  * The system clock
  * The real time clock
  * The high resolution clock

### Interrupts & critical sections
  * Overview
  * High/low priority interrupts
  * Interrupt nesting
  * Critical sections
  * Uncritical sections

### Memory allocators
  * TODO

### The scheduler
  * Scheduling points
  * The ready list
  * The scheduling algorithm
  * Waiting lists
  * The idle thread

### Run-time statistics
  * Per-thread number of context switches
  * Per-thread number of CPU clocks used

### Iterating threads

### Credits

As the saying goes, _"Books are written from books, and software from software"_. As such, this manual too did not appear from nothing, but was influenced by the following manuals:

- _"Using the FreeRTOS Real Time Kernel"_, by Richard Barry
- _"µC/OC-III The Real-Time Kernel - User's Manual"_, by Micriµm
- _"embOS & embOS-MPU - Real-Time Operating System - CPU-independent - User & Reference Guide"_, by SEGGER

Many thanks for their impressive work and for providing the inspiration.
