---
layout: page
lang: en
permalink: /user-manual/event-flags/
title: Event flags
author: Liviu Ionescu

date: 2016-07-15 10:09:00 +0300

---

## Overview

Together with semaphores, event threads are the basic µOS++ synchronisation mechanisms.

An event flag can be considered as a simplified binary semaphore, that can be posted from a thread or an ISR.

The additional value of event flags consist in their number: event flags come in groups, and threads can be synchronised on any number of flags in a group (defined by a mask). A thread may expect either all flags in a set to have occurred (conjunctive syncronisation, logical AND), or any flag in a set (disjunctive synchronisation, logical OR).

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/event-flags.png" />
<p>Event flags</p>
</div>

The event flags consists of a series of bits, based on the platform word size (32-bits for Cortex-M). The initial value for the event flags is zero (none of the flags are raised).

## Creating event flags

When used to synchronise threads with ISRs, the easiest way to access event flags is when they are created as global objects.

In C++, the global event flags are created and initialised by the global static constructors mechanism.

``` cpp
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// Create a global event flags object instance.
event_flags ev { "ev" };

int
os_main (int argc, char* argv[])
{
  // ...

  // Not much to do, the event flags were created by the static
  // constructors, before entering main().

  // ...

  return 0;
}

// All event flags are automatically destroyed if os_main() returns.

```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

// Global static storage for the event flags object instance.
os_evflags_t ev;

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a global event flags object instance.
  os_evflags_create(&ev, "ev", NULL);

  // ...

  // For completeness, destroy the event flags.
  os_evflags_destroy(&ev);

  return 0;
}
```

In C++, if it is necessary to control the moment when global objects instances are created, it is possible to separately allocate the storage as global variables, then use the placement `new` operator to initialise them.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// Global static storage for the event flags object instance.
// This storage is set to 0 as any uninitialised variable.
std::aligned_storage<sizeof(event_flags), alignof(event_flags)>::type ev1;

int
os_main (int argc, char* argv[])
{
  // ...

  // Use placement new, to explicitly call the constructor
  // and initialise the event flags.
  // Create a global event flags object instance.
  new (&ev1) event_flags { "ev1" };

  // Local static storage for the event flags object instance.
  static std::aligned_storage<sizeof(event_flags), alignof(event_flags)>::type ev2;

  // Use placement new, to explicitly call the constructor
  // and initialise the event flags.
  // Create a static event flags object instance.
  new (&ev2) event_flags { "ev2" };

  // ...

  // For completeness, call the event flags destructors, which for placement new
  // is no longer called automatically.
  ev1.~event_flags();
  ev2.~event_flags();

  return 0;
}
```

Event flags objects instances can also be created on the local stack, for example on the main thread stack. Just be sure the stack is large enough to store all defined local objects.

``` cpp
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a local event flags object instance.
  event_flags ev1 { "ev1" };

  // Beware of local static instances, since they'll use atexit()
  // to register the destructor; avoid and prefer placement new, as before.
  // static event_flags ev2 { "ev2" };

  // ...

  // The local event flags are destroyed automatically before exiting this block.
  return 0;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

int
os_main (int argc, char* argv[])
{
  // ...

  // Local storage for the event flags object instance.
  os_evflags_t ev1;

  // Create an event flags object instance.
  os_evflags_create(&ev1, "ev1", NULL);

  // ...

  // For completeness, destroy the event flags.
  os_evflags_destroy(&ev1);

  return 0;
}
```

For a total control over the event flags creation (for example to set a custom clock), the event flags attribute mechanism can be used.

``` cpp
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

int
os_main (int argc, char* argv[])
{
  // ...

  event_flags::attribute attr;
  attr.clock = &rtclock;

  // Create an event flags object instance.
  event_flags ev { "ev", attr };

  // ...

  // The local event flags are destroyed automatically before exiting this block.
  return 0;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

int
os_main (int argc, char* argv[])
{
  // ...

  os_evflags_attr_t attr;
  os_evflags_attr_init(&attr);

  attr.clock = os_clock_get_rtclock();

  // Local storage for the event flags object instance.
  os_evflags_t ev;

  // Create an event flags object instance.
  os_evflags_create(&ev, "ev", &attr);

  // ...

  // For completeness, destroy the event flags.
  os_evflags_destroy(&ev);

  return 0;
}
```

The application programmer can create an unlimited number of event flag groups (limited only by the available RAM).

## Raising event flags

In programing language terms, raising flags is equivalent to OR-ing the corresponding bits in the event flags mask. Once raised, the flags remain raised until they are checked, or explicitly cleared. Raising an already raised flag is a no-op.

When a thread or an ISR raises a flag, all threads that have their wait conditions satisfied will be resumed.

### Raising event flags from ISRs

It is perfectly possible to raise event flags from ISRs, generally to synchronise waiting threads with events occurring on interrupts.

## Waiting for event flags

A thread can check at any time if an expected set of flags are raised; it is possible to check if **all** flags in a set are raised, or if **any** flag in a set is raised.

It’s up to the application to determine what each bit in the event flags mask  means and it is possible to use as many event flags as needed.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

event_flags ev { "ev" };

// Thread function.
void*
th_func(void* args)
{
  // Wait for two event flags.
  result_t res;
  res = ev.timed_wait(0x3, 100);
  if (res == os_ok)
    {
      trace::printf("Both flags raised\n");
    }
  else if (res == ETIMEDOUT)
    {
      trace::printf("Timeout\n");
    }

  return nullptr;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Create the thread. Stack is dynamically allocated.
  thread th { "th", th_func, nullptr };

  // Raise one flag. The condition is not enough to resume the thread.
  ev.raise(0x1);

  // Pretend the thread has something important to do.
  sysclock.sleep_for(10);

  // Raise second flag. The thread will be resumed.
  ev.raise(0x2);

  // Wait for the thread to terminate.
  th.join();

  // ...
  return 0;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

// Global static storage for the event flags object instance.
os_evflags_t ev;

// Thread function.
void*
th_func(void* args)
{
  // Wait for two event flags.
  // In C there are no defaults, all parameters must be specified.
  os_result_t res;
  res = os_evflags_timed_wait(&ev, 0x3, 100, NULL, os_flags_mode_all | os_flags_mode_clear);
  if (res == os_ok)
    {
      trace_printf("Both flags raised\n");
    }
  else if (res == ETIMEDOUT)
    {
      trace_printf("Timeout\n");
    }

  return NULL;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a global event flags object instance.
  os_evflags_create(&ev, "ev", NULL);

  // Local storage for the thread object.
  os_thread_t th;

  // Initialise the thread object and allocate the thread stack.
  os_thread_create(&th, "th", th_func, NULL, NULL);

  // Raise one flag. The condition is not enough to resume the thread.
  os_evflags_raise(&ev, 0x1, NULL);

  // Pretend the thread has something important to do.
  os_sysclock_sleep_for(10);

  // Raise second flag. The thread will be resumed.
  os_evflags_raise(&ev, 0x2, NULL);

  // Wait for the thread to terminate.
  os_thread_join(&th, NULL);

  // ...

  // For completeness, destroy the thread.
  os_thread_destroy(&th);

  // For completeness, destroy the event flags.
  os_evflags_destroy(&ev);

  return 0;
}
```

To check if any flag in the set is raised, use `flags::mode::any` (in C use `os_flags_mode_any`).

## Multiple threads waiting on event flags

It is possible for several threads to wait on the same event flags object (regardless if the bits are the same bits or different), each thread with its own timeout.

When a thread or an ISR raises a flag in an event flags object, all threads that have their wait conditions satisfied will be resumed.

## Other event flags functions

As presented in the above example, the common use case of the event flags is to automatically clear the raised flags after testing. For special cases it might be useful to individually read and clear each flag.

### Getting the event flags name

The event flags name is an optional string defined during the event flags object instance creation. It is generally used to identify the event flags during debugging sessions.

The C++ API is:

``` c++
event_flags ev { "ev" };

const char* name = ev.name();
```

The C API is:

``` c
os_evflags_t ev;
os_evflags_create(&ev, "ev" };

const char* name = os_evflags_get_name(&ev);
```

### Getting individual flags

It is possible to selectively read event flags, and possibly clear them afterwards. To prevent clearing, pass a 0 mode value.

Only the flags present in the mask are affected.

``` c++
flags::mask_t mask = ev.get(0x2, flags::mode::clear);
```

A similar example, but written in C:

``` c
os_flags_mask_t mask = os_evflags_get(&ev, 0x2, os_flags_mode_clear);
```

### Clearing individual flags

It is possible to selectively clear event flags, and possibly get the value of the flags before clearing. If the passed pointer is null, the previous values of the selected flags are lost.

Only the flags present in the mask are affected.

``` c++
flags::mask_t mask;
ev.clear(0x2, &mask);
```

A similar example, but written in C:

``` c
os_flags_mask_t mask;
os_evflags_clear(&ev, 0x2, &mask);
```

## Destroying event flags

In C++, if the event flags were created using the normal way, the destructors are automatically invoked when the current block exits, or, for the global event flags instances, after the `main()` function returns. Event flags created with placement `new` need to be destructed manually.

In C, all event flags must be destructed by explicit calls to `os_evflags_destroy()`.

There should be no threads waiting on the event flags when the object is destroyed, otherwise an assert check will trigger.
