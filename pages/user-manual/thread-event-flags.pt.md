---
layout: page
lang: pt
permalink: /pt/user-manual/thread-event-flags/
title: Thread event flags
author: Liviu Ionescu
translator: Carlos Delfino

date: 2016-07-08 09:37:00 +0300
last_updated_at:  2016-08-24 18:45:00 +0300

---
{% comment %}

start_translate_at:  2016-08-24 18:45:00 +0300

{% endcomment %}


## Visão Geral

Tradicionalmente, um dos primeiros métodos de comunicação entre processos oferecidos pelo Unix foi enviar sinais de um processo a outro. Apesar de limitado, este método tem beneficios, e todos os sistemas POSIX posteriores preservaram e aperfeiçoaram isso.

Porém, para sistemas embarcados, a implementação é um pouco mais pesada e para o momento não tem sido considerada apropriada.

Ao invés disso, um mecanismo mais leve foi adotado, flags de eventos de _threads_, muito similar a flags de eventos genéricos, mas especifico pra cada _thread_.

Este mecanismo fornece um número separado de flags para cada _thread_, que pode ser lançado para outras _threads_ ou ISRs, e pode ser verificado pelo proprietário da _thread_ de várias formas, incluindo com esperas bloqueadas em múltiplas flags.

Cada flag de evento pode ser considerado como um semáforo binário simplificado, que pode ser postado de fora e a _thread_ pode aguadar por ele.

## Raising thread event flags

As long as the thread identity is known, any other thread or ISR can raise any set of flags, at any time.

In programing language terms, raising flags is equivalent to OR-ing the corresponding bits in the thread event flags mask. Once raised, the flag remains raised until it is checked by the thread, or explicitly cleared by the thread. Raising an already raised flag is a no-op.

If the thread was suspended and waits for flags, it is resumed.

## Waiting for thread event flags

A thread can check at any time if an expected set of flags are raised; it is possible to check if all flags in a set are raised, or if any flag in a set is raised.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  // Wait for two event flags.
  result_t res;
  res = this_thread::flags_timed_wait(0x3, 100);
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
  th.flags_raise(0x1);

  // Pretend the thread has something important to do.
  sysclock.sleep_for(10);

  // Raise second flag. The thread will be resumed.
  th.flags_raise(0x2);

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

// Thread function.
void*
th_func(void* args)
{
  // Wait for two event flags.
  // In C there are no defaults, all parameters must be specified.
  os_result_t res;
  res = os_this_thread_flags_timed_wait(0x3, 100, NULL, os_flags_mode_all | os_flags_mode_clear);
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

  // Local storage for the thread object.
  os_thread_t th;

  // Initialise the thread object and allocate the thread stack.
  os_thread_create(&th, "th", th_func, NULL, NULL);

  // Raise one flag. The condition is not enough to resume the thread.
  os_thread_flags_raise(&th, 0x1);

  // Pretend the thread has something important to do.
  os_sysclock_sleep_for(10);

  // Raise second flag. The thread will be resumed.
  os_thread_flags_raise(&th, 0x2);

  // Wait for the thread to terminate.
  os_thread_join(&th, NULL);

  // ...

  // For completeness, destroy the thread.
  os_thread_destroy(&th);

  return 0;
}
```

To check if any flag in the set is raised, use `flags::mode::any` (in C use `os_flags_mode_any`).

## Other thread event flags functions

As presented in the above example, the common use case of the thread event flags is to automatically clear the raised flags after testing. For special cases it might be useful to individually read and clear each flag.

### Getting individual flags

It is possible for one thread to selectively read its own flags, and possibly clear them afterwards. To prevent clearing, pass a 0 mode value.

Only the flags present in the mask are affected.

``` c++
flags::mask_t mask = this_thread::flags_get(0x2, flags::mode::clear);
```

A similar example, but written in C:

``` c
os_flags_mask_t mask = os_this_thread_flags_get(0x2, os_flags_mode_clear);
```

### Clearing individual flags

It is possible for one thread to selectively clear its own flags, and possibly get the value of the flags before clearing. If the passed pointer is null, the previous values of the selected flags are
lost.

Only the flags present in the mask are affected.

``` c++
flags::mask_t mask;
this_thread::flags_clear(0x2, &mask);
```

A similar example, but written in C:

``` c
os_flags_mask_t mask;
os_this_thread_flags_clear(0x2, &mask);
```
