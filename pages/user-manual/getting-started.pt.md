---
layout: page
lang: pt
permalink: /pt/user-manual/getting-started/
title: Começando com o μOS++ IIIe
author: Liviu Ionescu

date: 2016-06-29 21:28:00 +0300
last_modified_at: 2016-08-17 23:25:00 +0300
---
% comment %} 

Start translate at: 2016-08-17 21:30:00 +300 Todo:

Todo:
 - Translate text comment on source code?
 
Base Commit:
- f16bc9f0b4f524ee5ccd7f2929ebc6ceb84a644a

{% endcomment %}

## Visão Geral

**µOS++ IIIe** _(micro oh ɛs plus plus terceira edição)_ é a terceira interação do µOS++, um POSIX-like, portavel, open source, royalty-free, sistema operacional multi-tarefa real-time criado para aplicações embarcadas de 32/64-bits.

**µOS++ IIIe** é escrito em C++ moderno, com aplicações C++ em mente, mas também fornece igualmente API C funcional.

### Multiplas APIs

µOS++ é baseado no CMSIS++, e como tal prover serviços via multiplas APIs, cobrindo ambas aplicações C++ e C.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/cmsis-plus-rtos-overview.png" />
</div>

As API suportadas são:

- **CMSIS++ RTOS C++ API** - Uma API C++ nativa do µOS++ IIIe C++ API, dá acesso direto para os serviços do sistema;
- **CMSIS++ RTOS C API** - Um Wrapper C 1:1  no topo da API C++;
- **ISO C++ Threads API** - Uma implementação do padrão ISO para _threads_ no topo da API C++;
- **ARM CMSIS RTOS v1 API** - Uma camada de compartibilização com o ARM CMSIS RTOS

A função nestas APIs é fornecer serviços para gerenciar _threads_, semáforos, fila de mensagens, _mutexes_ entre outros. A medica que o código do usuário é desenvolvido, as chamadas para as funções do sistema µOS++ exatamente como outras chamadas de função, usando o padrão [ABI](https://pt.wikipedia.org/wiki/Interface_bin%C3%A1ria_de_aplica%C3%A7%C3%A3o) para o _toolchain_; não são feitas chamadas de serviços de sistema (SVC) para trocar do modo de sistema para usuário.

Neste capítulo, o leitor irá perceber o quanto é fácil iniciar usando o µOS++. Use a [Referência CMSIS++](http://micro-os-plus.github.io/reference/cmsis-plus/) para  uma descrição completa das funções do µOS++ usadas.

Para este capítulo introdutório, a configuração do projeto (arquivos e pastas, _toolchain_ e outras ferramentas, inicialização do hardware) são considerados irrelevantes e não serão apontados aqui.


## O `os_main()` e a _thread_ principal

Para conveniência do usuário, a função `main()` padrão cria uma thread inicial (não surpreendentemente chamada `main`) e demandas para a função `os_main()` ser chamada neste contexto da _thread_.

Esta organização libera o usuário de se preocupar com a inicialização e execução do escalonador, e também prove uma referência para as _threads_ criadas a partir ai.

Uma aplicação _blinky_ simples em C++ que pisca um LED a cada 1 Hz pode se parecer como isso:

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
O exemplo em geral é auto explicativo. as funções do LED são fornecidas pela aplicação. A unica função de sistema usada é `sleep_for()`, que, quando chamada pelo objeto `sysclock`, coloca a thread corrente em modo _sleep_ pelo número de ticks informado, que, neste caso é o numero de _SysTick ticks_ por segundos, resultando em um 1 segundo de suspensão.

Uma aplicação similar, mas escrita em C:

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

Por favor, observe que uma aplicação pura em C, o cabeçalho de sistema incluso é diferente.

## Aplicação múltiplas _threads_

Em adição a aplicação piscar o LED, o próximo exemplo adiciona uma fila (_queue_) de mensagens onde as mensagens são enfileiradas por  um _callback_ de interrupção, e uma _thread_ de usuário que pega as mensagens da fila e então imprime no canal de rastreamento.

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

Uma aplicação semelhante escrita em C:

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
  os_mqueue_create(&mq, "q", 7, sizeof(msg_t), NULL);

  // Initialise the thread object and allocate the thread stack.
  os_thread_create(&th, "th", th_func, NULL);

  user_led_t led;

  led_initialize(&led);

  while (true)
  {
    os_sysclock_sleep_for(OS_INTEGER_SYSTICK_FREQUENCY_HZ);

    led_toggle(&led);
  }

  // Not reached if the LED loop never ends.
  os_thread_destroy(&th);
  os_mqueue_destroy(&mq);

  return 0;
}
```

A diferença visível é que em C a fila de mensagens e o os objetos _threads_ precisam ser explicitamente criados, enquanto em C++ o construtor são chamados implicitamente pelo compilador.