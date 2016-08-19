---
layout: page
lang: pt
permalink: /pt/user-manual/threads/
title: Threads
author: Liviu Ionescu
translator: Carlos Delfino

date: 2016-07-05 11:27:00 +0300
last_modified_at: 2016-08-19 14:22:00 +0300

---
{% comment %} 

Start translate at: 2016-08-19 00:10:00 +300 Todo:

Base Commit:
- f16bc9f0b4f524ee5ccd7f2929ebc6ceb84a644a
{% endcomment %}
 
## Visão Geral

Uma das primeiras decisões durante o projeto de uma aplicação _real-time_ é como particionar as funcionalidades demandada em cada tarefa em separado, tal que cada tarefa é tão simples quanto possível e tem o mínimo de interação com outras tarefas.


µOS++ torna fácil para um programador adotar este paradigma. Cada **tarefa** é executada por uma **thread separada** e pode conversar com as outras _threads_ e com ISRs via diversas primitivas de comunicação/sincronização.

Uma _thread_ é um simples programa que pensa ter a CPU toda para ele. Em uma simples CPU, somente uma _thread_ pode executar a cada certo tempo.

µOS++ suporta multi tarefa e permite a aplicação ter **qualquer quantidde de _threads_**. O máximo número de _threads_  é atualmente somente o limite de quantidade de memória disponível no processador (ambo espaço de código e dados).

Multitarefa é o processo de escalonamento e troca na CPU entre diversas _threads. A CPU chaveia sua atenção A CPU troca sua atenção entre diversas _threads_. Multitarefa prove a ilusão de ter múltiplas CPUs e, atualmente maximiza o uso da CPU.

Multitarefa também ajuda a criação de aplicação modular. Sem multitarefa, a aplicação é normalmente um superloop, com giros através de um ou varias máquinas de estado finitos. Com multitarefa, o programador da aplicação tem que gerenciar tarefas muito simples e lineares. Programação tipicamente fáceis de projetar e manter quando é usado multitarefa.

_Threads_ separadas são usadas para tais como monitoramento de entradas, atualização de saída, executar cálculos, controlar laços (loops), atualizar um ou mais _displays_, ler botões e teclados, comunicar com outros sistemas, e mais. Uma aplicação pode conter um punhado de _threads_ enquanto outra aplicação pode requer centenas. O número de _threads_ não estabelece o quanto bom ou efetivo um projeto pode ser, ele realmente depende do que a aplicação (ou produto) precisa fazer. A quantidade de trabalho que uma _thread_ executa também depende da aplicação. Uma _thread_ pode ter alguns microssegundos que valem a pena o trabalho executado enquanto outra _thread_ pode requerer dezenas de milissegundos.

Tarefas são implementadas como funções regulares em C, passadas para a chamadas de criação das _threads_ como parâmetros obrigatórios.

## Funções _Thread_

Há dois tipos de threads: *run-to-completion* (execute até terminar) e *infinite loop* (laço infinito). Em muitos sistemas embarcados, _threads_ tipicamente são executadas como laços infinitos.

Como especificado pelo POSIX, **_threads_ podem terminar**, e como tal,  µOS++ implementa adequamento ambas as _threads_ _run-to-completion_ e _infinit loop_.

Além de ter protótipo especifico, funções de _threads_ são funções tipicas do C; Como tal elas se beneficiam de todos os recursos da função C, incluindo ter variáveis locais em sua pilha, chamando quantas funções ela precisar, etc.

``` c++
// Thread function.
void*
th_func(void* args)
{
  // Define local variables, as needed.

  // Do something useful.
  // Consider args when multiple threads use the same function.

  // When nothing to do, return.
  return nullptr;
}
```

### Funções reentrantes de _Thread_

Quando uma _thread_ µOS++ inicia sua execução, é passado um argumento opcional do tipo `void*`, **args**. Este ponteiro é um veiculo universal que pode ser usado para passar para a _thread_ o endereço de uma variável, o endereço de uma estrutura, ou o endereço de uma função, se necessário. Com este ponteiro, é possível criar muitas _threads_ idênticas, todas usando o mesmo corpo de _thread_ reentrante, mas será executado com dados de tempo de execução diferentes.

Uma função _reentrante_ é uma função que não faz uso de código estático ou mesmo de variáveis globais mesmo que elas estejam protegidas.

Um exemplo de uma função não reentrante é a famosa `strtok()` fornecida pela maioria das bibliotecas C padrão. Esta função é usada para buscar em strings por _tokens_. A primeira vez que esta função é chamada, a _string_ a ser analisada e os _tokens_ devem ser informados. Assim que a função encontra o primeiro _token_, ela retorna. A função _lembra_ quando foi a última vez que ela foi chamada novamente, e pode extrair novos _tokens_, o que é claramente não reentrante.  Mas tais funções são identificadas e agora versões reentrantes estão disponíveis nas bibliotecas padrão (no caso desta `strtok_r()`).
s case `strtok_r()`).

Como um exemplo de funções _thread_ reentrante, uma aplicação pode ter quatro portas seriais assíncronas que são cada uma gerenciada pela sua própria _thread_. Porem, a função da _thread_ são atualmente idênticas, Ao invés de copiar o código quatro vezes, crie o código para uma _thread_ genérica que recebe um ponteiro para a estrutura de dados, qeu contem os parâmetros da porta serial (baud rate, endereço da porta I/O, numero do vetor de interrupção, etc.) como argumento. em outras palavras, instanciar o mesmo código de _thread_ quatro vez e passar dados diferentes para cada porta serial qeu cada instancia pode gerenciar.


### _Threads_ Run-to-completion (execute até terminar)

Uma _thread_ µOS++ _run-to-completion_é implementada como uma função que termina e opcionalmente retorna um ponteiro. alternativamente ela pode explicitamente chamar o  `this_thread::exit(void*)`, com resultados identicos.

Uma _thread_ _run-to-completion_ inicia, executa sua função, e termina, depois esta _thread_ pode ser reusada quantas vezes for necessário. Porém, há uma certa sobrecarga envolvendo a criação e destruição de _threads_, e, se a _thread_ não é configurada para usar uma pilha (_stack_) estático, a área de _stack_ deve ser alocada e desalocada cada vez, que não somente aumenta o _overhead_, mas também pode contribuir pra a fragmentação.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  // Do something useful.

  return nullptr;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Create the thread. Stack is dynamically allocated.
  thread th { "th", th_func, nullptr };

  // Wait for the thread to terminate.
  th.join();

  // ...

  // The local thread is destroyed automatically before exiting this block.
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
  // Do something useful.

  return NULL;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Local storage for the thread object instance.
  os_thread_t th;

  // Initialise the thread object and allocate the thread stack.
  os_thread_create(&th, "th", th_func, NULL, NULL);

  // ...

  // Wait for the thread to terminate.
  os_thread_join(&th, NULL);

  // ...

  // For completeness, destroy the thread.
  os_thread_destroy(&th);

  return 0;
}
```

### Infinite loop threads

The use of an infinite loop threads is more common in embedded systems because of the repetitive work needed in such systems (reading inputs, updating displays, performing control operations, etc).

Note that one could use a `while (true)` or `for (;;)` to implement the infinite loop, since both behave the same.

The infinite loop must call a µOS++ service that will cause the thread to pass control back to the scheduler, for example a service to wait for an event to occur, or sleep for a certain duration. It is important that each thread will pass control back to the scheduler, otherwise the thread would be a true busy wait loop and will simply hog the CPU for the time quanta it is allowed to run. This concept of **suspending waiting threads** is key to an efficient CPU use in any RTOS.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

typedef struct msg_s
{
  uint8_t id;
  uint8_t payload[7];
} msg_t;

// Define a queue of 7 messages.
// The queue itself will be dynamically allocated.
message_queue_typed<msg_t> mq { 7 };

// Thread function.
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
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

typedef struct msg_s
{
  uint8_t id;
  uint8_t payload[7];
} msg_t;

// Global static storage for the queue object instance.
// The queue itself will be dynamically allocated.
os_mqueue_t mq;

// Thread function.
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
```

The µOS++ service used in this example to pass control back to the scheduler is the queue receive function. The thread will have nothing to do until the message is received. Once a message is send to the queue, the thread will be resumed and the message consumed.

Another common situation the thread might be waiting for is the passage of time. For example, a design may need to scan a keyboard every 100 ticks. In this case, simply delay the thread for 100 ticks (`sysclock.sleep_for(100)`) then see if a key was pressed on the keyboard and, possibly perform some action based on which key was pressed.

It’s important to note that when a thread is suspended and waits for an event, it does not consume any CPU time.

## Thread priorities

The rules used by the µOS++ scheduler to select the next thread are simple:

- select the thread with the highest priority
- if there are multiple threads with this priority, select the one waiting for the longest time.

In short, this can be rephrased as:

> The oldest thread with the highest priority.

Thread priorities are unsigned values, with higher values meaning higher priorities.

µOS++ imposes no restrictions on how priorities can be assigned to threads. The choice can be anything from assigning a unique priority to every thread (as required by some special scheduling strategies), to assigning the same priority to all threads. By default, all threads are created with the `normal` priority.

## Creating threads

Creating threads is probably the most complex part of any RTOS API, and it is unfortunate that this is usually one of the first issues encountered when dealing with a new RTOS, but threads must be mastered as soon as possible as they are a fundamental component of multitasking systems.

For convenience reasons, µOS++ has a rich set of functions for creating threads. Threads can use either statically or dynamically allocated stacks, threads can be created as local objects on the function stack, or as global objects, threads can be created with default characteristics or with custom attributes, and so on.

For infinite loop threads, the easiest way to create threads is to make them global objects.

In C++, the global threads are created and initialised by the global static constructors mechanism, so they are already linked in the READY list when `main()` is executed.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>
#include <my-allocator.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return nullptr;
}

// Create a thread; the stack is allocated with the default RTOS allocator.
thread th1 { "th1", th_func, nullptr };

// Define a custom thread type, parametrised with the user allocator.
using my_allocated_thread = thread_allocated<my_allocator>;

// Create a thread; the stack is allocated with the user allocator.
my_allocated_thread th2 { "th2", th_func, nullptr };

constexpr std::size_t my_stack_size_bytes = 3000;

// Create a thread; the stack is statically allocated.
thread_static<my_stack_size_bytes> th3 { "th3", th_func, nullptr };

int
os_main (int argc, char* argv[])
{
  // ...

  // Not much to do, the threads were created by the static
  // constructors, before entering main(), and are already running.

  // ...

  // Wait for the threads to terminate.
  th1.join();
  th2.join();
  th3.join();

  return 0;
}

// All threads are automatically destroyed if os_main() returns.

```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>
#include <my-allocator.h>

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return NULL;
}

// Global static storage for the thread object instance.
os_thread_t th1;

// Global static storage for the thread object instance.
os_thread_t th2;

#define MY_STACK_SIZE_BYTES 3000
// Static storage for the thread stack.
os_thread_stack_allocation_element_t
th3_stack[MY_STACK_SIZE_BYTES/sizeof(os_thread_stack_allocation_element_t)];

// Global static storage for the thread object instance.
os_thread_t th3;

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a thread; the stack is allocated with the default RTOS allocator.
  os_thread_create(&th1, "th1", th_func, NULL, NULL);

  // The default stack size.
  size_t my_size = os_thread_stack_get_default_size();

  os_thread_attr_t attr2;
  os_thread_attr_init(&attr2);
  attr2.th_stack_address = my_allocator_allocate(my_size);
  attr2.th_stack_size_bytes = my_size;

  // Create a thread; the stack is allocated with the user allocator.
  os_thread_create(&th2, "th2", th_func, NULL, &attr2);

  os_thread_attr_t attr3;
  os_thread_attr_init(&attr3);
  attr3.th_stack_address = th3_stack;
  attr3.th_stack_size_bytes = sizeof(th3_stack);

  // Create a thread; the stack is allocated with the user allocator.
  os_thread_create(&th3, "th3", th_func, NULL, &attr3);

  // ...

  // Wait for the threads to terminate.
  os_thread_join(&th1, NULL);
  os_thread_join(&th2, NULL);
  os_thread_join(&th3, NULL);

  // For completeness, destroy the threads.
  os_thread_destroy(&th1);
  os_thread_destroy(&th2);
  os_thread_destroy(&th3);

  // Free the allocated stack.
  my_allocator_deallocate(attr2.th_stack_address, attr2.th_stack_size_bytes);

  return 0;
}
```

In C++, if it is necessary to control the moment when global objects instances are created, it is possible to separately allocate the storage as global variables, then use the placement `new` operator to initialise them.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>
#include <my-allocator.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return nullptr;
}

// Global static storage for the thread object instance.
// This storage is set to 0 as any uninitialised variable.
std::aligned_storage<sizeof(thread), alignof(thread)>::type th1;

int
os_main (int argc, char* argv[])
{
  // ...

  // Use placement new, to explicitly call the constructor
  // and initialise the thread.
  new (&th1) thread { "th1", th_func, nullptr };

  // Local static storage for the thread object instance.
  std::aligned_storage<sizeof(thread), alignof(thread)>::type th2;

  // Use placement new, to explicitly call the constructor
  // and initialise the thread.
  new (&th2) thread { "th2", th_func, nullptr };

  // ...

  // Wait for the thread to terminate.
  th1.join();

  // For completeness, call the threads destructors, which for placement new
  // is no longer called automatically.
  th1.~thread();
  th2.~thread();

  return 0;
}
```

Threads objects instances can also be created on the local stack, for example on the main thread stack. Just be sure the stack is large enough to store all defined local objects.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>
#include <my-allocator.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return nullptr;
}

constexpr std::size_t my_stack_size_bytes = 3000;

thread::stack::allocation_element_t
th3_stack[my_stack_size_bytes/sizeof(thread::stack::allocation_element_t)];

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a thread; the stack is allocated with the default RTOS allocator.
  thread th1 { "th1", th_func, nullptr };

  // Define a custom thread type, parametrised with the user allocator.
  using my_allocated_thread = thread_allocated<my_allocator>;

  // Create a thread; the stack is allocated with the user allocator.
  my_allocated_thread th2 { "th2", th_func, nullptr };

  thread::attributtes attr;
  attr.th_stack_address = th3_stack;
  attr.th_stack_size_bytes = sizeof(th3_stack);

  // Create a thread; the stack is statically allocated.
  thread th3 { "th3", th_func, nullptr, attr };

  // Beware of local static instances, since they'll use atexit()
  // to register the destructor; avoid and prefer placement new, as before.
  // static thread th4 { "th4", th_func, nullptr };

  // ...

  // Wait for the threads to terminate.
  th1.join();
  th2.join();
  th3.join();

  // The local threads are destroyed automatically before exiting this block.
  return 0;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>
#include <my-allocator.h>

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return NULL;
}

#define MY_STACK_SIZE_BYTES 3000
// Static storage for the thread stack.
os_thread_stack_allocation_element_t
th3_stack[MY_STACK_SIZE_BYTES/sizeof(os_thread_stack_allocation_element_t)];

int
os_main (int argc, char* argv[])
{
  // ...

  // Local storage for the thread object instance.
  os_thread_t th1;

  // Create a thread; the stack is allocated with the default RTOS allocator.
  os_thread_create(&th1, "th1", th_func, NULL, NULL);

  // The default stack size.
  size_t my_size = os_thread_stack_get_default_size();

  os_thread_attr_t attr2;
  os_thread_attr_init(&attr2);
  attr2.th_stack_address = my_allocator_allocate(my_size);
  attr2.th_stack_size_bytes = my_size;

  // Local storage for the thread object instance.
  os_thread_t th2;

  // Create a thread; the stack is allocated with the user allocator.
  os_thread_create(&th2, "th2", th_func, NULL, &attr2);

  os_thread_attr_t attr3;
  os_thread_attr_init(&attr3);
  attr3.th_stack_address = th3_stack;
  attr3.th_stack_size_bytes = sizeof(th3_stack);

  // Local storage for the thread object instance.
  os_thread_t th3;

  // Create a thread; the stack is statically allocated.
  os_thread_create(&th3, "th3", th_func, NULL, &attr3);

  // ...

  // Wait for the threads to terminate.
  os_thread_join(&th1, NULL);
  os_thread_join(&th2, NULL);
  os_thread_join(&th3, NULL);

  // Free the allocated stack.
  my_allocator_deallocate(attr2.th_stack_address, attr2.th_stack_size_bytes);

  // For completeness, destroy the threads.
  os_thread_destroy(&th1);
  os_thread_destroy(&th2);
  os_thread_destroy(&th3);

  return 0;
}
```

The application programmer can create an unlimited number of threads (limited only by the available RAM).

### ISO/IEC C++ threads

The 2011 release of the ISO/IEC C++ 14882 standard finally introduced a standard definition for the C++ threads objects.

This standard definition was designed with POSIX threads in mind, and the standard C++ threads do not intend to reimplement the POSIX threads in C++, but are seen as a C++ wrapper on top of the existing C POSIX threads.

With µOS++/CMSIS++ threads being a C++ reimplementation of the POSIX threads, the ISO/IEC wrapper approach matches almost 1:1 the native µOS++ threads.

To avoid clashes with the standard library when running tests on synthetic platforms that already implement the C++ standard threads, the µOS++/CMSIS++ definitions are part of the `os::estd::` namespace ("embedded" std), instead of the `std::` namespace.

When using the `os::estd::` namespace it is recommended to avoid `using namespace` definitions below the `os` namespace; instead, use the `rtos` and `estd` namespaces explicitly.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/iso/thread>

using namespace os;

// Thread function.
void*
th_func(int n, char* s, void* p)
{
  // Note the 3 different parameters.

  // Do something useful.

  return nullptr;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a standard thread.
  // The underlying implementation thread object and
  // stack are dynamically allocated.
  estd::thread th1 { th_func, 7, "str", nullptr };

  // ...

  // Wait for the thread to terminate.
  th1.join();

  // The local thread is destroyed automatically before exiting this block.
  return 0;
}
```

The expected standard implementation dynamically allocates the underlying `rtos::thread` object instance, which in turn allocates the stack; it is not possible to configure static stacks with ISO C++ threads, neither to set a name for the thread.

To be noted that standard C++ threads can have any number of arguments. The internal implementation uses tuples and `std::bind`, which also imply a dynamic memory allocation.

For more details, please read the _ISO/IEC 14882:2011(E), Programming Languages – C++_ specifications.

## Changing thread priorities

By default, threads are created with `thread::priority::normal` which is a middle value priority, but it can be changed at any moment during the thread lifetime.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  this_thread::thread().priority(thread::priority::high);

  // Do something useful.

  return nullptr;
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
  os_thread_set_priority(os_this_thread(), os_thread_priority_high);

  // Do something useful.

  return NULL;
}
```

If, for any reasons, the initial thread priority must be different, it can be set to any legal value during the thread creation call, using the `th_priority` thread attribute.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>
#include <my-allocator.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return nullptr;
}

int
os_main (int argc, char* argv[])
{
  // ...

  thread::attributtes attr;
  attr.th_priority = thread::priority::high;

  // Create a thread; the stack is allocated with the default RTOS allocator.
  // The initial priority is configured via the attributes as HIGH.
  thread th1 { "th1", th_func, nullptr, attr };

  // ...

  // Wait for the thread to terminate.
  th1.join();

  // The local thread is destroyed automatically before exiting this block.
  return 0;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>
#include <my-allocator.h>

// Thread function.
void*
th_func(void* args)
{
  while (true)
    {
      // Do something useful.
    }

  return NULL;
}

int
os_main (int argc, char* argv[])
{
  // ...

  os_thread_attr_t attr;
  os_thread_attr_init(&attr);
  attr.th_priority = os_thread_priority_high;

  // Local storage for the thread object instance.
  os_thread_t th1;

  // Create a thread; the stack is allocated with the default RTOS allocator.
  // The initial priority is configured via the attributes as HIGH.
  os_thread_create(&th1, "th1", th_func, NULL, &attr);

  // ...

  // Wait for the thread to terminate.
  os_thread_join(&th1, NULL);

  // For completeness, destroy the thread.
  os_thread_destroy(&th1);

  return 0;
}
```

## Other thread functions

The µOS++ thread API basically implements the POSIX threads, with several extensions.

### Getting the thread name

The thread name is an optional string defined during thread object instance creation. It is generally used to identify the thread during debugging sessions.

The C++ API is:

``` c++
thread th { "th", th_func, nullptr };

const char* name = th.name();
```

The C API is:

``` c
os_thread_t th;
os_thread_create(&th, "th", th_func, NULL, NULL };

const char* name = os_thread_get_name(&th);
```

### Setting/getting the thread priority

The thread priority can be accessed and modified by the thread itself, or by another thread.

The C++ API is:

``` c++
thread th { "th", th_func, nullptr };

thread::priority_t prio = th.priority();
th.priority(thread::priority::high);
```

The C API is:

``` c
os_thread_t th;
os_thread_create(&th, "th", th_func, NULL, NULL };

os_thread_priority_t prio = os_thread_get_priority(&th);
os_thread_set_priority(&th, os_thread_priority_high);
```

### Getting the thread stack

The `thread::stack` is a separate object, managing the thread stack; the stack storage itself is not included in this object, but only a pointer to it is available.

The C++ API is:

``` c++
thread th { "th", th_func, nullptr };

thread::stack& stack = th.stack();
std::size_t sz = stack.size();
std::size_t available = stack.available();
stack::element_t* bottom = stack.bottom();
stack::element_t* top = stack.top();
bool bm = stack.check_bottom_magic();
bool tm = stack.check_top_magic();
```

The C API is:

``` c
os_thread_t th;
os_thread_create(&th, "th", th_func, NULL, NULL };

os_thread_stack_t* stack = os_thread_get_stack(&th);
size_t sz = os_thread_stack_get_size(stack);
size_t available = os_thread_stack_get_available(stack);
os_thread_stack_element_t* bottom = os_thread_stack_get_bottom(stack);
os_thread_stack_element_t* top = os_thread_stack_get_top(stack);
bool bm = os_thread_stack_check_bottom_magic(stack);
bool tm = os_thread_stack_check_top_magic(stack);
```

### Getting the thread user storage

The thread user storage is a user defined structure added to each thread storage.

The C++ API is:

``` c++
thread th { "th", th_func, nullptr };

os_thread_user_storage_t* p = = th.user_storage();
```

A similar example, but written in C:

``` c
os_thread_t th;
os_thread_create(&th, "th", th_func, NULL, NULL };

os_thread_user_storage_t* p = os_thread_get_user_storage(&th);
```

The content of `os_thread_user_storage_t` must be defined in `os-app-config.h`, together with `OS_INCLUDE_RTOS_CUSTOM_THREAD_USER_STORAGE`, which enables the user storage feature.

### Thread interruption

For error processing purposes, it is sometimes useful for a monitoring thread to be able to interrupt another thread blocked in a waiting functions.

For this purpose, each thread has an "interrupted" flag, that can be set/reset and checked.

When this flag is set, the thread is resumed and the blocking function, if written carefully, should check this flag and return `EINTR`.

After detecting the `EINTR` condition, the interrupted thread must clear the flag, with `thread::interrupt(false)` (in C `os_thread_set_interrupt(false)`).

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// Thread function.
void*
th_func(void* args)
{
  // Block on a long sleep.
  result_t res = sysclock.sleep_for(99999999);
  if (res == EINTR)
    {
      this_thread::thread().interrupt(false);
    }

  return nullptr;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Create a thread; the stack is allocated with the default RTOS allocator.
  // The initial priority is configured via the attributes as HIGH.
  thread th1 { "th1", th_func, nullptr, nullptr };

  // Request for thread interruption.
  th1.interrupt();

  // ...

  // Wait for the thread to terminate.
  th1.join();

  // The local thread is destroyed automatically before exiting this block.
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
  // Block on a long sleep.
  os_result_t res = os_sysclock_sleep_for(99999999);
  if (res == EINTR)
    {
      os_thread_interrupt(os_this_thread(), false);
    }

  return NULL;
}

int
os_main (int argc, char* argv[])
{
  // ...

  // Local storage for the thread object instance.
  os_thread_t th1;

  // Create a thread; the stack is allocated with the default RTOS allocator.
  // The initial priority is configured via the attributes as HIGH.
  os_thread_create(&th1, "th1", th_func, NULL, &attr);

  // Request for thread interruption.
  os_thread_interrupt(&th1, true);

  // ...

  // Wait for the thread to terminate.
  os_thread_join(&th1, NULL);

  // For completeness, destroy the thread.
  os_thread_destroy(&th1);

  return 0;
}
```

## Destroying threads

If for infinite loop threads this is not an issue, since they are never destroyed, for run-to-completion threads it is important to properly terminate them, to ensure all resources are released.

There are several ways of terminating a thread:

- return from the thread function, which automatically invoke `this_thread::exit()`
- manually invoke `this_thread::exit()`
- one thread may kill another thread using `thread::kill()`
- for threads defined in a local scope, if the block terminates, the thread destructor is automatically invoked (in C, `os_thread_destroy()` must be manually invoked).

All these methods are functionally equivalent, in that the thread is destroyed, and, if the thread stack was dynamically allocated, this storage is automatically deallocated.

There is a subtle difference when the thread decides to terminate itself (by calling exit() or returning from the thread function, which is exactly the same): the thread termination can proceed only up to a point, but cannot complete the stack deallocation while still using the stack. To solve this, in µOS++ the thread adds itself to a list that will be later processed by the idle thread, and, by the next time idle is scheduled, the stack will be deallocated and the thread destruction will be finalised.

In a well behaved system this is not a problem, because the idle thread is scheduled quite often, but in a busy system it might take some time.

If the thread is needed for immediate reuse, it is recommended for the parent thread to invoke `thread::kill()`, which will destroy the thread on the spot, without having to wait for idle to act as a hitman.

## The current thread

Some thread functions (like `suspend()`) can be performed only on the current thread, in other words one thread cannot suspend another, only the thread itself can do it.

To access these special functions, in C++, a dedicated namespace `this_thread` is used (in C a family of functions prefixed with `os_this_thread_` is defined).

For more specific functions, a reference to the current thread can be obtained with `this_thread::thread()` (in C with `os_this_thread()`);

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// A thread function.
void*
th_func(void* args)
{
  trace::printf("Thread name: %s\n", this_thread::thread().name());

  // Do something.

  return nullptr;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

// A thread function.
void*
th_func(void* args)
{
  trace_printf("Thread name: %s\n", os_thread_name(os_this_thread());

  // Do something.

  return NULL;
}
```

## Thread states

A thread may be in one of several states at any given time. The main distinction is based on the presence of the thread in the READY list; a thread in the READY list is said to be in the **ready** state.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/thread-states.png" />
</div>

The memory area associated with a not-yet-created thread may have any content, and the thread is considered to be in the **undefined** state.

When a thread is created, it is placed into the **ready** state.

### The ready state

When threads become ready-to-run, they are inserted in the READY list and at the same time are placed in the **ready** state.

At the next scheduling point, the oldest high-priority ready thread gets the CPU and is placed in the **running** state.

### The running state

Only one thread may be **running** at a time. If a thread with higher priority becomes **ready**, the current running thread is preempted and moved back in the **ready** state; the higher priority thread becomes the **running** thread.

The **running** thread may found itself having nothing else to do for the moment; in this case it is placed into the **suspended** state and the next-highest-priority thread in the **ready** state is activated.

### The suspended state

When threads are removed from the READY list, they are placed in the **suspended** state.

Internally, µOS++ has a single function to suspend a thread (`this_thread::suspend()`), and it does not differentiate between suspended states; it makes no difference if the thread is suspended to wait for a mutex to become unlocked, for a software timer to expire or for a timeout to break a wait.

In the public APIs, all waiting functions, with or without timeouts, are implemented on top of the `this_thread::suspend()` function (actually on the internal `port::scheduler::reschedule()` used to implement `this_thread::suspend()` too).

The scheduler itself does not keep track of the suspended threads. It is the responsibility of the synchronisation objects that suspended the thread to link it to the specific object (mutex, semaphore, etc) waiting list, and possibly to the clock timeout list.

µOS++ has a single function to resume a thread (`thread::resume()`), and it makes no difference why the thread was suspended for, it is resumed and placed in the **ready** state anyway.

### The terminated state

When a thread is terminated, it is first put in the **terminated** state, and after resources associated to it are released, it is put in the **destroyed** state.

## The thread stack

The thread's stack has the same function as in a single-thread system: storage of return addresses of nested function calls, parameters and local variables, and temporary storage of intermediate results and register values.

### How much stack is required?

Each thread has its own stack, with a fixed size determined during thread creation, and each thread has its own stack usage pattern. It is very difficult to compute the exact stack space required by a thread, especially when recursive algorithms are used.

What most users do, is to start with some reasonable values, and adjust them if needed.

µOS++ provides support for computing the thread stack available space, and a user defined monitoring mechanism can invoke it and detect low stack conditions.

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

// A thread function.
void*
th_func(void* args)
{
  // Do something.

  // Check stack.
  thread::stack& st = this_thread::thread().stack();
  std::size_t available = st.available();
  if (available < (st.size() * 20 / 100))
    {
      trace::printf("Low stack!\n");
    }

  // Do something.

  return nullptr;
}
```

A similar example, but written in C:

``` c
/// @file app-main.c
#include <cmsis-plus/rtos/os-c-api.h>

// A thread function.
void*
th_func(void* args)
{
  // Do something.

  // Check stack.
  os_thread_stack_t* st = os_thread_get_stack(os_this_thread());
  size_t available = os_thread_stack_get_available(st);
  if (available < (os_thread_stack_get_size() * 20 / 100))
    {
      trace_printf("Low stack!\n");
    }

  // Do something.

  return NULL;
}
```

Note: For reentrancy reasons, the `trace::printf()` facility requires some stack space for its internal buffers, space that must be added to the effective space required by the application; for Cortex-M applications running in debugging mode, a stack of **2000 bytes** is a good starting point.

### Configuring the thread stack size

The stack size can be specified during creation time for each thread, using the `th_stack_size_bytes` thread attribute. If attributes are not used, or the provided value is zero, a default value is supplied.

This default value can be set at any time using `thread::stack::default_size(std::size_t)` (in C with `os_thread_stack_set_default_size(size_t)`), and applies to all threads created afterwords.

The initial value of the default stack size can be set during compile time with `OS_INTEGER_RTOS_DEFAULT_STACK_SIZE_BYTES`.

### The minimum stack size

For validation purposes, the thread creation code validates the thread stack size to be above a minimum value.

This value can be set at any time using `thread::stack::min_size(std::size_t)` (in C with `os_thread_stack_set_min_size(size_t)`), and applies to all threads created afterwords.

The initial value of the minimum stack size is defined by the port, but can be set during compile time with `OS_INTEGER_RTOS_MIN_STACK_SIZE_BYTES`.

The recommended location to set these defaults is at the beginning of the `os_main()` function:

``` c++
/// @file app-main.cpp
#include <cmsis-plus/rtos/os.h>

using namespace os;
using namespace os::rtos;

int
os_main (int argc, char* argv[])
{
  // ...

  thread::stack::min_size(1000);
  thread::stack::default_size(2500);

  // ...

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

  os_thread_stack_set_min_size(1000);
  os_thread_stack_set_default_size(2500);

  // ...

  return 0;
}
```

### Configuring a user defined stack

Except when using the `thread_static` template, by default threads are created with a dynamically allocated stack. This can be changed to a user defined stack using the `th_stack_address` and `th_stack_size_bytes` thread attributes.

``` c++
thread::attributtes attr;
attr.th_stack_address = th3_stack;
attr.th_stack_size_bytes = sizeof(th3_stack);

// Create a thread; the stack is statically allocated.
thread th3 { "th3", th_func, nullptr, attr };
```

A similar example, but written in C:

``` c
os_thread_attr_t attr3;
os_thread_attr_init(&attr3);
attr3.th_stack_address = th3_stack;
attr3.th_stack_size_bytes = sizeof(th3_stack);

// Local storage for the thread object instance.
os_thread_t th3;

// Create a thread; the stack is statically allocated.
os_thread_create(&th3, "th3", th_func, NULL, &attr3);
```

### Detecting stack overflow

Accurate stack overflow detection requires hardware support, not available on common Cortex-M devices.

Although not bullet proof, since it does not prevent the stack to overflow, but can tell if this event happened, is a software method, which stores a magic word at the bottom of the stack, and periodically checks it.

µOS++ uses this method, and checks the stack during each context switches; an assert `stack ().check_bottom_magic ()` is triggered in the `thread::_relink_running()` function if the stack overflow damaged the magic word.

## The idle thread

The **idle** thread is a mandatory internal component of µOS++. It is the lowest priority thread, always ready to run when no other threads are active. The initialisation code always creates the idle thread, way before the scheduler is started.

The idle thread manages a list of threads terminated and waiting to be destroyed. The `thread::exit()` call links the terminating thread to this list, since it cannot destroy the thread while still running on the thread stack.

When the idle thread is resumed, it first checks this list, and, if any threads are present, they are fully destroyed and possibly the stack space is deallocated.

When the idle thread has nothing else to do, it places the CPU into sleep, and waits for the next interrupt (the Cortex-M devices use the **Wait For Interrupt - WFI** instruction for this).

If needed, the **idle** thread stack size can be configured during compile time with `OS_INTEGER_RTOS_IDLE_STACK_SIZE_BYTES`.

## The main thread

The main thread is an optional internal component of µOS++. If the `main()` function is not defined by the application, a weak default version of it is provided by µOS++.

This default `main()` function creates an initial thread called exactly **main**, with normal priority, that is configured to start the user-provided function `os_main(int argc, char* argv[])` as the thread function.

If needed, the **main** thread stack size can be configured during compile time with `OS_INTEGER_RTOS_MAIN_STACK_SIZE_BYTES`.
