---
layout: page
lang: pt
permalink: /pt/user-manual/getting-started/
title: Começando com μOS++ IIIe
author: Liviu Ionescu

date: 2016-06-29 21:28:00 +0300

---

## Overview

**µOS++ IIIe** _(micro oh ɛs plus plus third edition)_ is the third iteration of µOS++, a POSIX-like, portable, open source, royalty-free, multi-tasking real-time operating system intended for 32/64-bits embedded applications.

**µOS++ IIIe** is written in modern C++, with C++ applications in mind, but also provides equally functional C APIs.

### Multiple APIs

µOS++ provides services via multiple APIs, covering both C++ and C applications.

<div style="text-align:center">
<img alt="Overview" src="{{ site.baseurl }}/assets/images/2017/cmsis-plus-rtos-overview.png" />
</div>

The supported APIs are:

- **µOS++ RTOS C++ API** - the native µOS++ IIIe C++ API, giving direct access to the system services;
- **µOS++ RTOS C API** - a 1:1 C wrapper on top of the C++ API;
- **ISO C++ Threads API** - an implementation of the standard ISO threads on top of the C++ API;
- **ARM CMSIS RTOS v1 API** - a compatibility layer with ARM CMSIS RTOS

The functions in these APIs provide services to manage threads, semaphores, message queues, mutexes and more. As far as the user code is concerned, the calls to the µOS++ system functions are exactly as any other function calls, using the toolchain standard [ABI](https://en.wikipedia.org/wiki/Application_binary_interface); no system service calls (SVC) are used to switch from user to system modes.

In this chapter, the reader will appreciate how easy it is to start using µOS++. Refer to [CMSIS++ Reference](http://micro-os-plus.github.io/reference/cmsis-plus/) for the full descriptions of the µOS++ functions used.

For this introductory chapter, the project setup (files and folders, toolchain and other tools, hardware initialisations) are considered not relevant and are not addressed.

## The `os_main()` and the main thread

For user convenience, the default `main()` function creates an initial thread (not surprisingly called `main`) and arranges for the `os_main()` function to be called on this thread context.

This arrangement relieves the user from the concerns of initialising and starting the scheduler, and also provides a parent for the user threads created from here.


A simple C++ _blinky_ application that toggles a LED at 1 Hz might look like this:

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>
#include <user-led.h>

using namespace os;
using namespace rtos;

int
os_main (int argc, char* argv[])
{
  // At this point the scheduler is running, the CPU is
  // on a thread context, and all system functions are available.

  user_led led;

  led.initialize();

  while (true)
  {
    sysclock.sleep_for(clock_systick::frequency_hz);

    led.toggle();
  }

  return 0;
}
```

The example is generally self explanatory. The LED functions are provided by the application. The only system function used is `sleep_for()`, which, when called for the `sysclock` object, puts the current thread to sleep for the given number of ticks, which, in this case, is the number of SysTick ticks per second, resulting in an 1 second sleep.

A similar application, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>
#include <user-led.h>

int
os_main (int argc, char* argv[])
{
  // At this point the scheduler is running, the CPU is
  // on a thread context, and all system functions are available.

  user_led_t led;

  led_initialize(&led);

  while (true)
  {
    os_sysclock_sleep_for(OS_INTEGER_SYSTICK_FREQUENCY_HZ);

    led_toggle(&led);
  }

  return 0;
}
```

Please note that for plain C applications, the system include header is different.

## Multiple thread applications

In addition to the blinking LED, the next example adds a message queue where messages are enqueued from an interrupt callback, and a user thread that gets messages from the queue and prints them on the trace channel.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>
#include <user-led.h>

using namespace os;
using namespace rtos;

typedef struct msg_s
{
  uint8_t id;
  uint8_t payload[7];
} msg_t;

// Define a queue of 7 messages.
// The queue itself will be dynamically allocated.
message_queue_typed<msg_t> mq { 7 };

// Called from an ISR context.
void
some_irq_callback(const msg_t* msg)
{
  // If possible, enqueue the message.
  mq.try_send(msg);
}

// Thread function. Wait to receive a message and print it.
void*
th_func(void* args)
{
  while (true)
  {
    msg_t msg;
    mq.receive(&msg);

    trace::printf("id: %d\n", msg.id);
  }

  return nullptr;
}

// The thread definition.
thread th { "th", th_func, nullptr };

int
os_main (int argc, char* argv[])
{
  // At this point the scheduler is running, the CPU is
  // on a thread context, and all system functions are available.

  // No need to explicitly initialise the queue or the thread, they where
  // properly initialised by the static constructors.

  user_led led;

  led.initialize();

  while (true)
  {
    sysclock.sleep_for(clock_systick::frequency_hz);

    led.toggle();
  }

  return 0;
}
```

A similar application, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>
#include <user-led.h>

typedef struct msg_s
{
  uint8_t id;
  uint8_t payload[7];
} msg_t;

// Storage for the queue object.
// The queue itself will be dynamically allocated.
os_mqueue_t mq;

// Called from an ISR context.
void
some_irq_callback(const msg_t* msg)
{
  // If possible, enqueue the message.
  os_mqueue_try_send(&mq, msg, sizeof(msg_t), 0);
}

// Thread function. Wait to receive a message and print it.
void*
th_func(void* args)
{
  while (true)
  {
    msg_t msg;
    os_mqueue_receive(&mq, &msg, sizeof(msg), NULL);

    trace_printf("id: %d\n", msg.id);
  }

  return NULL;
}

// Storage for the thread object.
os_thread_t th;

int
os_main (int argc, char* argv[])
{
  // At this point the scheduler is running, the CPU is
  // on a thread context, and all system functions are available.

  // Initialise the queue object and allocate the queue storage.
  os_mqueue_construct(&mq, "q", 7, sizeof(msg_t), NULL);

  // Initialise the thread object and allocate the thread stack.
  os_thread_construct(&th, "th", th_func, NULL);

  user_led_t led;

  led_initialize(&led);

  while (true)
  {
    os_sysclock_sleep_for(OS_INTEGER_SYSTICK_FREQUENCY_HZ);

    led_toggle(&led);
  }

  // Not reached if the LED loop never ends.
  os_thread_destruct(&th);
  os_mqueue_destruct(&mq);

  return 0;
}
```

The visible difference is that in C the queue and the thread objects need to be explicitly created, while in C++ the constructors are called implicitly by the compiler.
