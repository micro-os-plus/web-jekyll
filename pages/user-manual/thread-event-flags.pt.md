---
layout: page
lang: pt
permalink: /pt/user-manual/thread-event-flags/
title: Thread event flags
author: Liviu Ionescu
translator: Carlos Delfino

date: 2016-07-08 09:37:00 +0300
last_updated_at:  2016-08-24 20:20:00 +0300

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

## Ativar flag de eventos da _thread_

Assim que a identidade da _thread_ é conhecida, alguma outra _thread_ ou ISR pode ativar um conjunto de _flags_, a qualquer momento.

Em termos de linguagem de programação, ativar flags é o equivalente a fazer um OR (OU Lógico) nos bits correspondentes na mascara de eventos da _flag_ da _thread_. Uma vez ativado, a _flag_ se mante ativa até ela ser verificada pela _thread_, ou explicitamente limpa pela _thread_. Ativar uma _flag_ já ativada é um no-op.

Se a _thread_ foi suspensa e aguarda por _flags_, ela é retomada.

## Esperando pelas flags de eventos de _thread_

Uma _thread_ pode verificar a qualquer momento se um conjunto de _flags_ esperados foram ativados; é possível verificar se todas as _flags_ em um conjunto são ativados, ou se alguma _flag_ em um conjunto foi ativada.

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
Um exemplo similar, mas escrito em C:

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

Para verificar se alguma _flag_ no conjunto está ativa, use  `flags::mode::any` (em C use `os_flags_mode_any`).

## Outras funções de flags de eventos de _thread_

Como apresentado no exemplo acima, o caso comum de uso das _flags_ de eventos da _thread_  é automaticamente limpar as _flags_ lançadas após testar. Para casos especiais isso pode ser útil para individualmente ler ou limpar cada _flag_.

### Obtendo _flags_ individuais

É possível para uma _thread_ seletivamente ler sua própria _flags_ e possívelmene limpar então depois, para evitar limpa-la, passe um valor modo 0.

Somente os _flags_ presentes na mascara serão afetados.

``` c++
flags::mask_t mask = this_thread::flags_get(0x2, flags::mode::clear);
```

Um exemplo similar, mas escrito em C:

``` c
os_flags_mask_t mask = os_this_thread_flags_get(0x2, os_flags_mode_clear);
```

### Limpando _flags_ individuais

É possível para uma _thread_ limpar seletivamente suas próprias _flags_, e possivelmente obter o valor das _flags_ antes de limpa-las. Se o ponteiro informado é _null_, os valores anteriores das _flags_ selecionadas são perdidos.

Somente as _flags_ presentes no mascara serão afetadas.

``` c++
flags::mask_t mask;
this_thread::flags_clear(0x2, &mask);
```

Um exemplo similar, mas escrito em C:

``` c
os_flags_mask_t mask;
os_this_thread_flags_clear(0x2, &mask);
```
