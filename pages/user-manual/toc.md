---
layout: page
permalink: /user-manual/
title: User's manual
author: Liviu Ionescu

date: 2016-06-28 19:39:00 +0300

---

Note: The Users's Manual is currently work in progress, actually in an early planning stage.

## RTOS

### [Getting started with µOS++]({{ site.baseurl }}/user-manual/getting-started/)
  * [Overview]({{ site.baseurl }}/user-manual/getting-started/#overview)
  * [The os_main() and the main thread]({{ site.baseurl }}/user-manual/getting-started/#the-osmain-and-the-main-thread)
  * [Multiple thread applications]({{ site.baseurl }}/user-manual/getting-started/#multiple-thread-applications)

### Basic concepts
  * Tasks / threads / processes
  * Context switching
    * Cooperative vs preemptive thread switching
  * Scheduling
    * Round-robin vs priority scheduling
    * Priority inversion / priority inheritance
  * Static vs. dynamically allocated objects
  * Communication between threads
    * Periodic polling
    * Passing messages
    * Event flags
    * Semaphores
  * Managing common resources
    * Disable/enable interrupts
    * Lock/unlock the scheduler
    * Use semaphores
    * Use mutual exclusion (mutex)
    * Should a semaphore or a mutex be used?
    * Deadlock (or deadly embrace)

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
