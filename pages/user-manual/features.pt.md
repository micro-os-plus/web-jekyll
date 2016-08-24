---
layout: page
lang: pt
permalink: /pt/user-manual/features/
title: Recursos do µOS++ IIIe features
author: Liviu Ionescu
translator: Carlos Delfino

date: 2016-08-23 17:55:00 +0300
last_updated_at:  2016-08-23 21:05:00 +0300

---
{% comment %}

start_translate_at:  2016-08-23 17:55:00 +0300

{% endcomment %}

## Visão Geral

µOS++ IIIe é um sistema operacional POSIX-like, portável, código aberto, livre de royalties, multi tarefa, real-time, destinado a aplicações embarcadas 32/64-bits.


µOS++ IIIe é escrito no **Moderno C++ 11**, com aplicações C++ em mente, mas também oferece funcionalidades iguais através de APIs em C.

µOS++ IIIe é a terceira edição do µOS++, oferecendo todos os serviços esperados de um sistema real-time moderno, incluindo gerencimaneto de recursos, sincronização, comunicação _inter-thread_, e mais. µOS++ IIIe também oferece muitos recursos não encontrados em muitos outros sistemas real-time, como ambas as APIs em C++ e C, _threads_ POSIX-like, sincronização POSIX de objetos, uso de alocadores de memória em C++ e muito mais.

## Recursos

Há uma lista de recursos oferecidos pelo µOS++ IIIe.

### Código Fonte

µOS++ é um **projeto de código aberta (Open Source)**, fornecido sobre altamente **permissivos termos da licença do MIT**.

O código aberto disponível não somente ajuda a depurar, mas também melhora grandemente o entendimento geral de todo o ambiente de execução, resultando em uma aplicação melhor e mais robusta.

### Multiplas APIs C++ e C

µOS++ é baseado no CMSIS++, e fornece serviços via multiplas APIs, convergindo aplicações C++ e C.

As APIs suportadas são:

- CMSIS++ RTOS C++ API - A API C++ nativa do µOS++ IIIe C++ API, dá acesso direto aos serviços de sistemas;
- CMSIS++ RTOS C API - Um Wrapper C 1 por 1 no topo da API C++;
- ISO C++ Threads API - Uma implementação do padrão ISO de _threads_ sobre a API C++;
- ARM CMSIS RTOS v1 API - Uma camada de compatibilização com ARM CMSIS RTOS.

A API C do CMSIS++ permite escrever aplicações em C puro, mesmo se o core é escrito em C++.

A API  ARM CMSIS RTOS permite rodar aplicações legadas, escrita para ARM RTOS API

A API _Threads_ ISO C++ fornece uma forma conviniente para executar código ISO padrão sem nenhuma alteração.

### APIs POSIX-like

O projeto das APIs de core foram fortemente influenciadas pelas especificações de _threads_ do POSIX. Deste ponto  de vista, µOS++ pode também ser visto com  **POSIX++**, uma versão  C++ do POSIX.

A compatibilidade com POSIX é um recurso muito importante, desde que o POSIX é um padrão portável maduro e bem estabelecido e experiência obtida enquanto usando um grande sistema POSIX pode aumentar também a produtividade de desenvolvedores de aplicação embarcadas.

### ISO thread C++ API

µOS++ também implementa o padrão de API ISO C++ para _threads_, incluindo a funcionalidade `chrono`.

O ISO C++ 14882:2011 introduziu uma API padrão para _threads_, mutexes, variáveis condicionais, locks, funções relacionadas a tempo, etc.

Esta API é relativamente fácil de usar, a sobrecarga é baixa e se compartilhar código com algum ambiente de servidor é necessário, isto pode ser uma solução bem interessante.


### APIs Consistente

As APIs usadas pelo µOS++ são altamente consistente. Uma com as convenções de código usadas, é simples prever qual função chamar para um serviços necessário, e também prever quais argumentos são necessários. Por exemplo, na API C um ponteiro para um objeto é sempre o primeiro argumento, muitas funções retornam um código de erro POSIX, etc.


Isso se traduz em aumento de produtividade e melhoria de legibilidade do código ao longo do tempo.


### Preemptição de multi-tarefa

µOS++ implementa um escalonador baseado em prioridade, preemptivo, multi tarefa e para este fim, µOS++ sempre roda a a thread mais importante pronta para executar.

Para um sistema real-time, isso melhora a velocidade de reação e ajuda encontrar os prazos requeridos.

### Escalonador Round robin 

µOS++ permite múltiplas _theards_ executar no mesmo nível de prioridade. Quando múltiplas _threads_ no mesmo nível de prioridade estão prontas para executar, elas são agendadas através do método round-robin.

Este algoritmo de agendamento, fornece uma distribuição justa do tempo da CPU para _threads_ comuns que não tem necessidades especiais, e pode compartilhar uma prioridade comum.

### Baixo tempo de desativação de interrupções

µOS++ tem um número interno de estruturas de dados e variáveis que precisam ser acessadas atomicamente, Para assegurar isso, µOS++  desabilita interrupções por um curto período, para assegurar a latência mínima.

Mantendo as seções criticas curtas, dá a chance de interrupções rápidas ocorrerem e e a capacidade de resposta do sistema é aumentada.

### Seções criticas seguras aninhadas

para evitar bugs sutis, as seções criticas do µOS++ são definidas para serem facilmente aninhadas, armazenando o estado inicial durante a entrada e restaurando as quando saindo.

Estas implementação de armazenamento permite invocar chamadas de sistemas do µOS++  de qualquer ambiente, incluindo callbacks desenvolvidos com código que usam implementações inadequadas de seções criticas (por exemplo aqueles que usam contadores para informar quando re-abilitar interrupções).

Deve ser observado que o inverso não verdade, chamar bibliotecas de funções que implementam seções criticas usando contadores do ambiente quando a interrupção estão desabilitadas possibilita introduzir um problema de sincronização, desde que estas funções erroneamente habilitarão as interrupções.

### Configurável

As configurações (ambos dados e códigos) podem ser ajustadas baseadas nas demandas da aplicação. Isso é executado em tempo de compilação através de muitos `#define` disponíveis (veja òs-app-config.h`). µOS++ também executa um número de verificações em tempo de execução nos argumentos passados para seus serviços, como não passar ponteiros NULL, não chamar serviços de nível _threads_ de dentro de ISRs, quais argumentos estão na faixa permitida, e opções informadas são válidas, etc. Estas verificações podem ser desabilitadas (em tempo de compilação) para reduzir o tamanho do código e melhorar a performance.

### Modular

Por um cuidado do projeto, somente as funções que são necessárias são lincadas em uma aplicação, mantendo o tamanho da ROM pequeno.

### Portabilidade

Por projeto µOS++/CMSIS++ é altamente portável; ele foi desenvolvido boa parte em um MacOS e seus testes são constantemente executados tanto em plataforma 32 como 64-bits.

### Habilitado para ROM

µOS++ foi projetado especialmente para sistemas embarcados e pode ser gravado na ROM juntamente com o código da aplicação.

Isso é importante para microcontroladores modernos, que incluem larga quantidade de memória flash internamente, e pode executar codigo dela, sem ter que copiar para RAM.

### Totalmente alocado estaticamente

µOS++ por sí é totalmente alocado estaticamente, ele não requer memória dinâmica.que o torna perfeito para aplicações especiais que não toleram riscos associados com fragmentações.

### Escolha do usuário para alocação de memória

Para objetos que requerem memoria adicional, o usuário tem total controle de usar ou memória alocada estaticamente ou dinamicamente.

µOS++ pode ser usado para construir aplicações especiais que não são permitidas usar alocação dinâmica.

### Alocadores de memória personalizados

Na API C++ do µOS++, todos os objetos que requerem memória adicional podem ser configurados para usar um alocador de memória personalizado, para, com limite, cada objeto possa ser alocado usando um alocador separado.

### Ilimitado números de threads

µOS++ suporta um número ilimitado de _threads_. De um ponto de vista prático, porém, o numero de _threads_ é atualmente limitado pela quantidade de memória (ambos os espaços de código e dados) que o processador pode acessar, Cada _thread_ requer sua própria pilha (_stack_); µOS++ fornece recursos que permite monitorar em tempo de execução o crescimento da pilha.

O tamanho padrão do pilha e o tamanho mínimo da pilha pode ser configurado pelo usuário.

### Número ilimitado de objetos de sisteas.

µOS++ permite qualquer quantidade de _threads_, semáforos, _mutexes_, _flags_ de eventos, filas de mensagens, _timers_, e bancos de memória, etc. O usuário em tempo de execução aloca todos os objetos de sistemas, seja como objetos estáticos globais, pilha de objetos ou objetos alocados dinamicamente.

Não tendo que definir estaticamente em tempo de compilação o numero máximo de objetos é muito conveniente.

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
