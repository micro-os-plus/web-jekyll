---
layout: page
lang: pt
permalink: /pt/user-manual/basic-concepts/
title: Conceitos básicos
author: Liviu Ionescu
translator: Carlos Delfino

date: 2016-06-30 14:39:00 +0300
last_modified_at: 2016-08-17 15:30:00 +300
---
{% comment %}
Start translate at: 2016-08-15 19:30:00 +300
Todo: 
 - Mudar URLs de sites externos para o português para fontes em português quando adequado em especial no wiki. Outros sites analisar com bastante cautelas e discutir fontes com terceiros.
 - Mudar a referência do livro "Java Threads" para português, e usar citação do texto original.
Base Commit: 
 - 9c7c14d9db312574e6b8bc281e962f8db58549cb
 - eebd7a5148f2dc3a7deb2d096ace7205d531b1c2
{% endcomment %}

## Sistemas Embarcados

Do ponto de vista do software, um [Sistema Embarcado](https://pt.wikipedia.org/wiki/Sistema_embarcado) é um pequeno computador, construído para funções específicas (em oposição aos [computadores](https://pt.wikipedia.org/wiki/Computadr) de propósito geral).

Há muitos tipos de sistemas embarcados, com vários níveis de complexidade, de pequenos sensores de proximidade usados em automação residencial, até roteadores de internet, câmeras de vigilância remota e até mesmo smart phones.

Sistemas complexos, especialmente aqueles com alta demanda de largura de banda para comunicação, são projetos com base versões embarcadas so sistemas GNU/Linux, que incluem um grande kernel, um sistema de arquivo, multiplos processadores, o que não difere muito de seus primos maiores que rodam em computadores desktop.

A _aplicação_ é geralmente uma combinação de processos rodando em um espaço de usuário ("user space"), e "device drivers", rodando dentro do kernel.

## Sistemas embarcados "Bare-metal"

Pequenos dispositivos tem muito menos recursos, e são construídos em torno de microcontroladores que não tem o hardware necessário para executar adequadamente um um kernel Unix.

Neste caso a aplicação é monolítica e executa diretamente no hardware, por isso o nome _bare-metal_.

µOS++ tem como foco as aplicações [bare-metal](https://en.wikipedia.org/wiki/Bare_machine), especialmente aquelas que rodam em dispositivos Cortex-M. Através do µOS++ pode-se portar para grandes cores ARM Cortex-A, inclusive os de 64-bits, que não tem planos de incluir suporte MMU, memória virtual, processos separados e outros tais como recursos específicos para o mundo Unix. 

## Sistemas de tempo real (Real-time)

Um sistema embarcado [real-time](https://en.wikipedia.org/wiki/Real-time_computing)é uma peça de software que gerencia os recursos e o comportamento com relação ao tempo de um dispositivo embarcado, normalmente construído em torno de um microcontrolador, enfatizando os valores calculados e a disponibilidade de tempo esperado por processo.
{% comment %} added "por processos" for contextualize the "expected time" {% endcomment %}

µOS++ é um sistema operacional real-time (do inglês Real-Time Operating System - RTOS).

## sistemas real-time, Soft vs hard

Há dois tipos de sistemas real-time, sistemas real-time soft e sistemas real-time hard.

A principal diferença entre eles é determinada pelas consequências associadas com a perda do _deadline_. Obter o valor computador corretamente mas após o prazo de execução (_deadline_) pode ser de inútil a perigoso.

Para um **Sistema Hard Real-Time** a tolerância para perda do _deadline_ é muito baixa, desde que a perda de uma **deadline** muitas vezes resulta numa catástrofe, que pode envolver perdas de vidas humanas.

Para um **Sistema Soft Real-Time** esta tolerância não é tão critica, desde que a _deadline_ perdida não seja em geral critica.

Absolutamente Sistemas Hard Real-Time, com tolerância próxima de zero, são tipicamente muito difícil de projetar, e é recomentado aborda-los com cautela.

Porem, com um projeto cuidadoso, razoável tolerância pode obtida, e   **µOS++ pode ser usado com sucesso em aplicações _Real-Time_**.

**Nota Jurídica:** De acordo com a licença do MIT, _"o software é fornecido _como é_, sem garantias de algum tipo"_, como tal seu uso em aplicações com risco de vida deve ser evitado.


## Aplicações _Superloop_ (_foreground_/_background_)

Há muitas técnicas para escrever um software para sistemas embarcados. Pra sistemas de baixa complexidade, há formas clássicas que não usam RTOS, mas padrões de desenvolvimento como sistemas _foreground_/_background_, ou **_superloops_**.

Uma aplicação consiste de um _loop_ infinito que chama uma ou mais funções em sucessão para executar as operações desejadas (**background**).

Rotinas de serviço de interrupção (Interrupt service routines - ISRs) são usados para tratar de forma assíncrona, partes _real-time_ da aplicação (**foreground**).

Nesta arquitetura, funções implementando várias funcionalidades são inerentes, ainda que não seja formalmente declarados como tal, um tipo de [máquina de estado finito](https://pt.wikipedia.org/wiki/M%C3%A1quina_de_estados_finitos), girando em torno de si e mudando estados baseado nas entradas fornecidas pelas **ISRs**..

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/superloop.png" />
<p>Superloop application</p>
</div>

A técnica de _superloop_ tem a vantagem de exigir apenas um _stack_ e algumas vezes pode resultar em uma aplicação simples, especialmente quando o funcionalidades são inteiramente executadas na ISRs, e a lógica do _background_ é resumida em um laço vazio aguardando por interrupções.

Porem, para aplicações ligeiramente mais complexas, expressando toda a lógica como um conjunto de maquinas de estados não é fácil e a manutenção torna-se um sério problema conforme o problema cresce.

A velocidade de reação pode ser um problema, desde que o atraso entre o momento que o _ISR_ torna disponível as entradas e o momento quando a rotina de _background_ pode usa-la não é determinístico, dependendo de muitas outras ações que podem acontecer ao mesmo tempo no _superloop_.

Para assegurar que ações urgentes sejam executadas em tempo hábil, ela deve ser movida para o _ISRs_, estendendo e tornando a resposta da aplicação pior.

## Multi-tasking

Independente de quão elaborado seja a técnica para implementação da maquina de estado finito (_finite state machine_), a mente humana ainda se sente a mais confortável com representações lineares de listas de passos a serem executadas, do que com grafos e tabelas de estados.


### Tasks

No contexto do µOS++, uma tarefa (_task_) é uma sequência de operações bem definidas, usualmente representadas em uma linguagem de programa por uma função.

Uma aplicação complexa pode ser decomposta com uma série de tarefas, algumas executadas em sucessão, algumas executadas em paralelo e possivelmente trocando dados.

_Multi-tasking_ é a técnica de executar múltiplas tarefas (_tasks_) em paralelo.

### Porque múltiplas _threads_?

O livro [Java Threads](http://www.amazon.com/Java-Threads-Scott-Oaks/dp/0596007825/) (uma das fontes de inspiração para as primeiras versões deste projeto) afirma:

> Historicamente, _threading_ foi explorado para tornar certos programas fáceis de escrever: se um programa pode ser separado em tarefas separadas, ele em muitos casos é fácil de ser escrito em _tasks_ ou _threads_… enquanto é possível escrever um programa _single-threaded_ para executar múltiplas tarefas, é fácil e mais elegante colocar cada tarefa em sua própria _thread_.


### Threads vs processos

_Threads_ e processos são mecanismos do sistema operacional para executar múltiplas tarefas em paralelo.

A principal diferença entre _threads_ e processos é como o espaço de memória é organizado. Processos rodam em separado, espaços de memoria virtual, enquanto _threads_ compartilham o mesmo espaço de memória.

A implementação de memoria virtual requer suporte de hardware para gerenciamento de memória (um Memory Management Unit - [MMU](https://pt.wikipedia.org/wiki/Unidade_de_gerenciamento_de_mem%C3%B3ria), disponível somente em processadores para uso em aplicações, como os dispositivos Cortex-A.

Pequenos dispositivos, como o ARM Cortex-M, podem até rodar múltiplas tarefas em paralelo, mas, sem um MMU e o beneficio de memórias virtuais, estas tarefas são executadas por múltiplas _threads_, todas compartilhando o mesmo espaço de memoria.

Como tal, µOS++ é um **sistema multi-threaded** (permite Múltiplas Threads), suportando **qualquer número de threads**, com o numero atual limitado apenas pela quantidade de memória disponível.

### Bloqueio por I/O

Um dos senários mais encontrados quando implementando tarefas, é aguardar por um tipo de dado de entrada, por exemplo executando um `read()`, então processar o dado e muitas vezes, repetir essa sequência em um laço. Quando o sistema executa uma chamada `read()`, a _thread_ pode precisar esperar pelo dado solicitado se tornar disponível antes que possa continuar a próxima instrução. este tipo de I/O é chamado bloqueio de I/O (**blocking I/O**): A _thread_ bloqueia até que algum dado esteja disponível para satisfazer a função `read()`.

Uma possível implementação é fazer um laço até que o dado se torne disponível. mas este tipo de comportamento simplesmente é um desperdício de recursos (ciclos de CPU e implicitamente energia) e deve ser evitado de todas as formas.

Bem, aplicações comportadas nunca devem entrar (longos) _loops_ ocupados esperando por condições por ocorrer, mas ao invés disso suspender a _thread_ e se organizar para que possa retomado quando a condição é encontrada. Durante este período de espera a _thread_ libera completamente a CPU, então a CPU se torna totalmente disponível para outra _thread_ disponível.

{% comment %} Rever a seguinte tradução, apesar de compreensível está difícil manter o texto em tradução direta:
For the sake of completeness, it should be noted that the only exception to the rule applies to short delays, where short means delays with durations comparable with the multitasking overhead required to suspend/resume threads (where the context switching time plays an important role). On most modern microcontrollers this is usually in the range of microseconds.
{% endcomment %}
Por razões de exaustividade, deve-se notar que a única exceção a regra se aplica a pequenos atrasos, onde quanto mais curtos significa que os atrasos com durações comparáveis com a sobrecarga da multitarefa necessários para suspender/resumir as _threads_ (enquanto o tempo necessário para a troca de contexto é um fator importante). Na maioria dos microcontroladores modernos esta é geralmente no intervalo de microssegundos.

### A **Idle** _thread_

Como vimos antes, a nível de _threads_, o objetivo é processar o dado assim que possível e suspender a si própria para aguardar por mais dados. E outras palavras, a forma ideal da _thread_ se manter é... não fazer nada|

Mas o que acontece se todas as _threads_ atender este requisito e não houver nada a ser feito?

Bem, entra a **idle** _thread_. Esta _thread_ interna é sempre criada antes do agendador (_scheduler_) ser iniciado; ela tem a prioridade mais baixa possível, e está sempre em execução quando não há nada mais para outras _threads_ executarem.

A _idle thread_ pode executar várias ações de manutenção de baixa prioridade (como destruir _threads_ finalizadas), mas em certos momentos até mesmo a _idle thread_ não terá nada para ser feito.


### _Sleep modes_ e economia de energia

Quando a _idle thread_ não tem nada a fazer, ele ainda pode ser útil: ela pode colocar a CPU em modo _sleep_ superficial e aguardar pela próxima interrupção (os dispositivos Cortex-M usam a instrução Aguardar Interrupção - **Wait For Interrupt** para isso).

Neste modo a CPU é inteiramente funcional, com todos os periféricos internos ativos, mas ela não executa nenhuma instrução, por isso é capaz de economizar certa quantidade de energia.

Se a aplicação tem momentos de inatividade relativamente longos, é possível se maior economia, por exemplo desligar todos os periféricos exceto o relógio de tempo real de baixa frequência. que usualmente dispara a cada segundo. Neste caso a tarefa inativa pode se preparar pra a CPU entrar em modo _deep sleep_, economizando uma quantidade significante de energia.

Como resumo, a estratégia de multinível usada para reduzir o consumo de energia implica em:

- Se não há nada a ser feito, cada _thread_ deve suspender a si mesma assim que possível, e liberar a CPU para outra _thread_ ativa;
- Se nenhum _thread_ ativa está disponível, a _idle thread_ deve preparar para que a CPU entre em modo _sleep_ assim que possível;
- Se todas as tarefas sabem que irão ficar inativas por um longo período, a tarefa inativa deve se preparar para a CPU entrar em modo _deep sleep_.

Em conclusão, pelo uso de uma vasta gama de técnicas de economias de energia, um RTOS pode ser usado com sucesso em uma variedade de aplicações e baixa energia.

### _Threads_ em execução e suspensas

Executando múltiplas _threads_ em paralelo é apenas aparente, já que internamente as _threads_ são decompostas em pequenas sequências de operações, serializadas em uma certa ordem, em cada cores disponíveis na CPU. Se há somente um core de CPU, há somente um core na CPU, há somente uma _thread_ **rodando** em certo momento. As outras _threads_ são **suspensas**, de certa forma são _congeladas_ e colocadas de lado para uso posterior; quando as condições se tornam favoráveis, cada uma pode ser _reanimada_ e, por um tempo, permitidas usar a CPU.
 
 _Threads_ suspensas são as vezes chamadas _sleeping_, ou _inativas_; este termo também é correto, mas ele deve ser claramente entendido que o estado da _thread_ é somente o estado do _software_, que não há nenhuma relação com o modo _sleep_ da CPU, que é relativo ao estado da CPU; A existência de _threads_ suspensas apenas significa que não há _threads_ agendadas para execução; isso não implica que a CPU entrará em algum dos modos _sleep_, que pode ocorrer somente quanto todas as _threadas_ são suspensas.
 
### Troca de Contexto

Reiniciar uma _thread_ suspensa requer restaurar exatamente o estado interno da CPU existente no momento quando a _thread_ foi suspensa. Fisicamente este estado é usualmente restaurado em um certo números de registradores da CPU. Quando a _thread_ está suspensa, o conteúdo destes registradores devem ser armazenados uma área de memória RAM separada, especifica para cada _thread_. Quando a _thread_ é continuada, os mesmos registradores devem ser restaurados com os mesmos valores.

Este conjunto de informações necessárias para resumir a _thread_ é também chamado de **Contexto de execução da Thread** (Thread execution context), em resumo **contexto** (context).

O conjunto de operações necessárias para armazenar o contexto da _thread_ em execução. selecionar a próxima _thread_ e restaurar seu contexto é chamado **Troca de Contexto** (context switching).

### Thread stacks

CPUs modernas, como os dispositivos ARM Cortex-M, fazem uso do _stack_ para implementar chamadas de funções intercaladas e armazenamento de funções locais.

O mesmo _stack_ pode ser usado para gravar o contexto da _thread_. Quando iniciando uma troca de contexto todos os registradores são armazenados no _stack_ da _thread_. Então o ponteiro resultante do _stack_ é gravado na área de contexto da _thread_. Em resumo a _thread_ está pronta na ordem reversa, por exemplo o ponteiro do _stack_ (pilha) é recuperado do contexto da _thread_, todos os registradores são puxados do _stack_ e a excussão é resumida.

Este mecanismo usualmente simplifica a implementação do agendador (_scheduler); ele é usado na implementação do agendador do µOS++ para o Cortex-M.

Observação Histórica: microcontroladores antigos, como o PIC antes da série 18, não tem um _stack_ de propósito geral; ao invez ele tem uma chamada limitada para o _stack_, permitindo somente uma pequena quantidade de chamadas aninhadas.

### Multi-tarefa cooperativa vs preemptiva

A razão mais frequênte para a troca de contexto é quando a _thread_ decide aguardar por recursos que não estão disponíveis ainda, como um novo caractere de um dispositivo, uma mensagem no _queue_, uma proteção por _mutex_ de um recurso compartilhado.

Neste caso, cedendo a CPU de uma _thread_ para outra é feito implicitamente pela função de sistema chamada para aguardar por este recurso.

No caso de longos cálculos, uma _thread_ bem comportada não deve manter a CPU inteiramente no período de calculo, mas explicitamente ceder (_yield_) a CPU de tempo em tempos, para dar a outras _threads_ a chance de rodar.

Este politica de comportamento, quando troca é executada pela própria _thread_ é chamada multi-tarefa cooperativa (**coperative**), uma vez que depende do bom comportamento de todas as tarefas rodando em paralelo.

A grande desvantagem da multi-tarefa cooperativa é uma possibilidade de reação de baixa velocidade, por exemplo quando uma interrupção deseja resumir uma _thread_ de alta prioridade, este pode não acontecer até que a prioridade de baixa prioridade decida ceder (_yield_).

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/scheduling-cooperative.png" />
<p>Cooperative context switching.</p>
</div>

Neste caso a solução é permitir a interrupção disparar uma troca de contexto de uma _thread_ de baixa prioridade para uma _thread_ de alta prioridade sem que as _threads_ tomem conhecimento do evento. Este tipo de troca de contexto é também chamado de multi-tarefa **preemptiva** (_preemptive_ multi-tasking), desta forma _threads_ de longo tempo de execução irão de forma preemptiva monopolizar a CPU em favor de prioridades de maior prioridade.


<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/scheduling-preemptive.png" />
<p>Preemptive context switching</p>
</div>

Uma vez o mecanismo para uma interrupção agir de forma preemptiva para uma _thread_ é funcional, uma melhoria futura pode ser adicionada: um _timer_ periódico (por exemplo o _timer_ usado para manter o tempo atualizado), pode ser usado para automaticamente agir de forma preemptiva sobre as _threads_  e dar a chance para _threads_ de prioridade igual de forma alternada ter acesso a CPU.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/scheduling-preemptive-timer.png" />
<p>Preemptive context switching with periodic timer</p>
</div>

Em geral multi tarefas cooperativas são fáceis de implementar e desde que a CPU seja liberada sobre o controle da aplicação, a condição de competição por sincronização _inter-threads_ são evitadas. Porém, em uma analise mais profunda, isso não é um recursos, mas uma forma de esconder outros erros de sincronização da aplicação, como a falta de seções criticas explicitas. Em outras palavras, uma aplicação bem comportada deve proteger um recursos compartilhado de uma seção critica de qualquer forma, já que desde que outras tarefas não pode executar dentro de outra tarefa, serviços de interrupção (ISR) podem, e sem uma seção critica é bem provável que uma uma condição de competição possa ocorrer.

Uma aplicação especialmente útil do modo cooperativo é para depuração de condições de competição _inter-thread_. Em casos de comportamento estranho que podem ser associados com problemas de sincronização, se desabilitar a preempção resolve o problema, então uma condição de competição _inter-threads_ é altamente provável. O problema permanece presente no modo cooperativo, então é muito provável que a condição de competição envolve o serviço de interrupção (IRS). Em ambos os casos a correção é usar seções criticas quando necessário.

µOS++ implementa ambos os modos multi-tasking preemptivo e cooperativo.

### O Cronometro do Escalonador

Muitos escalonadores mantem o rastro do temo, ao menos para tratar limites de tempo (timeouts). Tecnicamente isto é implementado através de um temporizador por hardware, e os limites de tempo são expressos como ticks deste temporizador.

Uma frequência comum para o temporizador do escalonador é 1000hz, que dá uma resolução de 1ms para a derivação do relógio do escalonador.

Para escalonadores preemptivos, o mesmo cronometro pode ser usado para disparar a troca de contextos.

Sabendo da importância de um cronometro do sistema, A ARM definiu **SysTick** como o cronometro comum para dispositivos Cortex-M, que fazem dele um recurso perfeito para o cronometro do escalonador.

### Interrompendo/Cancelando uma Thread

Em aplicações da vida real, há casos quando algumas _threads_, por vários motivos, devem ser interrompidos.

_Threads do µOS++ incluem suporte para interrupção, mas este suporte é cooperativo, por exemplo _threads_ que podem ser interrompidas devem verificar pela requisição de interrupção e e sair de seu loop de uma forma organizada.

### Blocos de controle de Threads (Thread Control Blocks - TCBs)

Um bloco de controle de _thread_ (thread control block - TCB) é uma estrutura de dados usada pelo escalonador para manter informações sobre a _thread_. Cada _thread_ requer seu próprio **TCB**.

Por trás de uma linguagem estruturada e orientada a objetos como o C++, as _threads_ do µOS++ tem de forma implícita uma instância da estrutura de dados associada com os objetos, que são funcionalmente equivalentes aos TCBs comuns; em outras palavras, o TCB do µOS++ são as instancia das _threads_ em si.

As variáveis internas das _threads_ são protegidas, e não podem ser diretamente acessadas pelo código do usuário, mas para todos os membros relevantes há assessores públicos e funções modificadores definidas.

## Escalonador

O mecanismo que permite a troca de contexto é também chamado de **escalonamento** (**_scheduling_**), e o código que implementa este mecanismo é também chamado de **escalonador** (**_scheduler_**).

### Estado da _Thread_ 

Durante seu tempo de vida, _threads_ podem ter diferentes estados.

Além de alguns estados usados durante a criação da _thread_ e sua destruição, os estados mais importantes são:

- **executando** (**running**) - uma _thread_ é marcada como **running** quando ela está usando a CPU;
- **pronta** (**read**) - uma _thread_ é marcada como **pronta** (**read**) para rodar, mas não está usando a CPU ainda;
- **suspensa** - (**suspended**) - uma _thread_ que não esteja pronta (**read**) para rodar e que deva aguardar por um recurso que não está disponível, ou por um evento que irá ocorrer no futuro.

### A lista READY

Para desempenhar suas funções de forma eficiente, o escalonador precisa manter o controle somente das _threads_ prontas para executar. _Threads_ que por um pequeno tempo devem aguardar vários eventos podem ser consideradas momentaneamente fora da jurisdição do escalonador, e outros mecanismos como cronômetros, objetos de sincronização, notificações etc, são esperados retornar então para o escalonador quando pronto para executar.

Objetivando manter o controle das _threads_ prontas, o escalonador mantem uma lista _ready_ (prontos). O termo lista é genérico, e independênte da implementação atual, pode ser qualquer coisa desde um simples _array_ até múltiplas listas duplamente encadeadas.

### Algoritmos de Escalonamento

A principal questão existencial na vida do escalonador é _como selecionar a próxima _thread_ para executar dentre as _threads_ na lista READY?_ Esta questão é atualmente muito mais difícil de responder quando tratando com uma aplicação _hard real-time_, com rigorosos prazos de vida ou morte definidos para as _threads_.

Informe jurídico: Deste ponto de vista pode ser claramente afirmado que o agendador do µOS++ não garante algum prazo na execução da _thread_.

Porém, o que o agendador do µOS++ faz, é ser o mais justos possível com as _threas_ existentes, e dar a melhor chance para cada uma ter acesso a CPU.

### Round-robin vs prioridade de escalonamento 

Uma das formas simples de gerenciar a lista de _threads_ prontas é uma lista do tipo[FIFO](https://pt.wikipedia.org/wiki/FIFO_(escalonamento)), com novas _threads_ sendo inseridas no final da fila, e o escalonador extraindo do inicio da fila. Este mecanismo funciona bem se não necessidade de garantir tempo de resposta.

Quando o tempo de resposta se torna importante, o mecanismo pode ser melhorado substancialmente adicionando prioridades para as _threads_, e ordenando a lista de _threads_ prontas pela prioridade.

Desta forma inserindo _threads_ de alta prioridades imediatamente na frente das _threads_ de baixa prioridades, dois objetivos são atingidos ao mesmo tempo:

- a _thread_ de maior prioridade está sempre na frente da lista, assim o escalonador sempre dará o controle para as _threads_ de alta prioridade;
- _threads_ com prioridades iguais não apenas são mantidas juntas, mas também manterão a ordem de inserção.

{% comment %}
define: round-robin -> https://pt.wikipedia.org/wiki/Round-robin
{% endcomment %}
Por padrão, as _threads_ de usuário no µOS++  são criadas com prioridade _normal_. Como resultado o comportamento padrão do escalonador é _round-robin_.

Assim que a prioridades são alteradas, o comportamento do escalonador muda automaticamente alterando o escalonamento das prioridades, voltando a usar _round-robin_ para _threads_ com prioridades iguais.


### Selecting thread priorities

As a general rule, threads that implement hard real-time functions should be assigned priorities above those that implement soft real-time functions. However, other characteristics, such as execution times and processor utilization, must also be taken into account to ensure that the entire application will never miss a hard real-time deadline.

One possible technique is to assign unique priorities, in accordance with the thread periodic execution rate (the highest priority is assigned to the thread that has the highest frequency of periodic execution). This technique is called Rate Monotonic Scheduling (RMS).

### Priority inversion / priority inheritance

Priority inversion is a problematic scenario in scheduling in which a high priority thread is indirectly prevented to run by a lower priority thread effectively "inverting" the relative priorities of the two threads.

The first scenario is the following:

- one low priority thread acquires a common resource
- following an ISR, a high priority thread becomes active, and tries to acquire the same resource, but is finds it busy and is blocked, waiting for the resource to be released
- the low priority thread is resumed, completes its job and releases the resource
- the high priority thread is resumed and can acquire the resource to perform its job

Although for the high priority thread this is an unfortunate scenario, there is not much that it can do but wait for the low priority thread to release the resource.

An even more unfortunate scenario is the following:

- one low priority thread acquires a common resource
- following an ISR, a high priority thread becomes active, and tries to acquire the same resource, but is finds it busy and is blocked, waiting for the resource to be released
- during this time, a medium priority thread becomes ready
- as soon as the high priority thread is suspended, the medium priority thread is resumed
- this prevents the low priority thread to run and release the resource, which prevents the high priority thread to run
- at a certain moment, the medium priority thread is suspended
- the low priority thread is resumed, completes its job and releases the resource
- the high priority thread is resumed and can acquire the resource to perform its job

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/priority-inversion.png" />
<p>Priority inversion</p>
</div>

The problem in this scenario is that although the high priority thread announced its intention to acquire the resource and knows it must wait for the low priority thread to release it, a medium priority thread can still prevent this to happen, behaving as like having the highest priority. This is known as **unbounded priority inversion**. It is unbounded because any medium priority can extend the time the high priority thread has to wait for the resource.

This problem was known for long, but many times ignored, until it was reported to have affected the [NASA JPL’s Mars Pathfinder](https://en.wikipedia.org/wiki/Mars_Pathfinder) spacecraft (see [What really happened on Mars?](http://research.microsoft.com/en-us/um/people/mbj/Mars_Pathfinder/)).

One of the possible solutions to avoid this is for the high priority thread to temporarily boost the priority of the low priority thread, to prevent other threads to interfere and so help the low priority thread to complete its job sooner. This is known as **priority inheritance**.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/priority-inheritance.png" />
<p>Priority inheritance</p>
</div>

To be noted that priority inheritance does not completely fix the priority inversion problem, the high priority thread still has to wait for the low priority thread to release the resource, but at least it does its best to prevent other middle priority threads to interfere. It is not a good practice to rely only on priority inheritance for correct system operation and the problem should be avoided at system design time, by considering how resources are accessed.


## Communicating between threads and/or ISRs

In a multi-tasking application, the threads and the ISRs are basically separate entities. However, in order to achieve the application's goals, they must work together and exchange information in various ways.

### Periodic polling vs event waiting

The easiest way to communicate between different pieces of code is by using global variables. In certain situations, it can make sense to communicate via global variables, but most of the time this method has disadvantages.

For example, if you want to synchronize a thread to perform some action when the value of a global variable changes, the thread must continually poll this variable, wasting precious computation time and energy, and the reaction time depends on how often you poll.

A better way is to suspend the waiting thread and, when the expected event occurs, to resume it. This method requires a bit of support from the system, to manage the operations behind suspend/resume, but has the big advantage that a suspended thread does not waste computation time and energy.

### Passing messages

A message queue is usually an array of structures accessed in a FIFO way. Threads or ISRs can send messages to the queue, and other threads or interrupts can consume them.

Threads can block while waiting for messages, and as such do not waste CPU cycles.

### Semaphores

Semaphores, and especially binary semaphores, are commonly used to pass notifications between different parts of the code, mostly from ISRs to threads. However, they have a richer semantic, especially the counting semaphores, and can also be used to keep track of the number of available resources (for example total positions in a circular buffer), which somehow places them at the border with managing shared resources.

### Event flags

An event flag is a binary variable, representing a specific condition that a thread can wait for. When the condition occurs, the flag is raised and the thread is resumed.

Multiple flags can be grouped and the thread can be notified when all or any of the flags was raised.

## Managing common resources

A shared resource is typically a variable (static or global), a data structure, table (in RAM), or registers in an I/O device, accessed in common by different parts of the code.

Typical examples are lists, memory allocators, storage devices, that all need a specific method to protect agains concurrent accesses.

The technique for obtaining exclusive access to shared resources is to create **critical sections**, which temporarily lock access.

### Disable/enable interrupts

When the resource is also accessed from ISRs, the usual solution to prevent an ISR to access the resource at the same time with a thread or another lower priority ISR, is to temporarily disable the interrupts while using the shared resource.

The overhead to disable/enable interrupts is usually low, and for some devices, like the Cortex-M[347] ones, it is even possible to disable interrupts only partially, from a given priority level down, keeping high priority interrupts enabled.

Although apparently simple, this technique is often misused in cases of nested critical sections, when the inner critical section inadvertently enables interrupts, leading to very hard to trace bugs. The correct and bullet proof method to implement the critical sections is to always save the initial interrupt state and restore it when the critical section is exited.

This method must be used with caution, since keeping the interrupts disabled too long impacts the system responsiveness.

Typical resources that might be protected with interrupts critical sections are circular buffers, linked lists, memory pools, etc.

### Lock/unlock the scheduler

If the resource is not accessed from ISRs, a simple solution to prevent other threads to access it is to temporarily lock the scheduler, so that no context switches can occur.

Locking the scheduler has the same effect as making the task that locks the scheduler the highest-priority task.

Similar to interrupts critical sections, the implementation of scheduler critical sections must consider nested calls, and always save the initial scheduler state and restore it when the critical section is exited.

This method must be used with caution, since keeping the scheduler locked too long impacts the system responsiveness.

### Counting semaphores

Counting semaphores can be used to control access to shared resources used on ISRs, like circular buffers.

Since they may be affected by priority inversions, their use to manage common resources should be done with caution.

### Mutual exclusion (mutex)

This is the preferred method for accessing shared resources, especially if the threads that need to access a shared resource have deadlines.

µOS++ mutexes have a built-in priority inheritance mechanism, which avoids unbound priority inversions.

However, mutexes are slightly slower (in execution time) than semaphores since the priority of the owner may need to be changed, which requires more CPU processing.

### Should a semaphore or a mutex be used?

A semaphore should be used when resources are shared with an ISR.

A semaphore can be used instead of a mutex if none of the threads competing for the shared resource have deadlines to be satisfied.

However, if there are deadlines to meet, you should use a mutex prior to accessing shared resources. Semaphores are subject to unbounded priority inversions, while mutexes are not. On the other hand, mutexes cannot be used on interrupts, since they need an owner thread.

### Deadlock (or deadly embrace)

A deadlock, also called a deadly embrace, is a situation in which two threads are each unknowingly waiting for resources held by the other.

Consider the following scenario where thread A and thread B both need to acquire mutex X and mutex Y in order to perform an action:

- thread A executes and successfully locks mutex X;
- thread A is pre-empted by thread B;
- thread B successfully locks mutex Y before attempting to also lock mutex X, but mutex X is held by thread A, so is not available to thread B. Thread B opts to enter the wait for mutex X to be released;
- thread A continues executing. It attempts to lock mutex Y, but mutex Y is held by thread B, so is not available to thread A. Thread A opts to wait for mutex Y to be released.

At the end of this scenario, thread A is waiting for a mutex held by thread B, and thread B is waiting for a mutex held by thread A. Deadlock has occurred because neither thread can proceed.

As with priority inversion, the best method of avoiding deadlock is to consider its potential at design time, and design the system to ensure that deadlock cannot occur.

The following techniques can be used to avoid deadlocks:

- do not acquire more than one mutex at a time
- do not acquire a mutex directly (i.e., let them be hidden inside drivers and reentrant library calls)
- acquire all resources before proceeding
- acquire resources in the same order

## Statically vs. dynamically allocated objects

Most system objects are self-contained, and the rule is that if the storage requirements are known, constant and identical for all instances, then the storage is allocated in the object instance data.

However some system objects require additional memory, different from one instance to the other. Examples for such objects are threads (which require stacks), message queues and memory pools.

This additional memory can be allocated either statically (at compile-time) or dynamically (at run-time).

By default, all base classes use the system allocator to get memory.

In C++ all such classes are doubled by templates which handle allocation.

Another solution, also available to the C API, is to pass user defined storage areas via the attributes used during object creation.

### The system allocator

For all objects that might need memory, µOS++ uses the system allocator `os::rtos::memory::allocator<T>`, which by default is mapped to an allocator that uses the standard new/delete primitives, allocating storage on the heap.

This allocator is a standard C++ allocator. The user can define another such standard allocator, and configure the system allocator to use it, thus customising the behaviour of all system objects.

Even more, system objects that need memory are defined as templates, which can be parametrised with an allocator, so, at the limit, each object can be constructed with its own separate allocator.

### Fragmentation

The biggest concern with using dynamic memory is fragmentation, a condition that may render a system unusable.

To be noted that internally µOS++ does not use dynamic allocation at all, so if the application is careful enough not to use objects that need dynamic allocation, the resulting code is fully static.

## Real-time clock

Most application handle time by using the scheduler timer.

However low power applications opt to put the CPU in a deep sleep, which usually powers down most peripherals, including the scheduler timer.

For these situations a separate low power real-time clock is required; powered by a separate power source, possibly a battery, this clock runs even when the rest of the device is sleeping.

This clock not only keeps track of time, it can also trigger interrupts to wakeup the CPU at desired moments.

The usual resolution of the real-time clock is 1 sec.

## Terms to use with caution

### Kernel

Many authors also refer to their RTOSes as "kernels". Well, even if _OS_ in RTOS stands for _operating system_, this definition is somehow stretched to the limit, since in bare-metal embedded systems the so called [operating system](https://en.wikipedia.org/wiki/Operating_system) is only a collection of functions handling thread switching and synchronisation, linked together with the application in a monolithic executable.

As such, the term [kernel](https://en.wikipedia.org/wiki/Kernel_(operating_system)) is even more inappropriate, since there is no distinct component to manage all available resources (memory, CPU, I/O, etc) and to provide them to the application in a controlled way; most of the time the application has full control over the entire memory space, which, for systems with memory mapped peripherals, also means full control over the I/O.

The only kernel specific function available in bare-metal embedded systems is CPU management; with multiple threads sharing the CPU, probably a more appropriate name for the RTOS core component is **scheduler**; the µOS++ IIIe documentation uses the term _operating system_ in its definition, occasionally refers to itself as a _scheduler_, and explicitly tries to avoid the term _kernel_.

### Tasks vs threads

Many authors refer to threads as "tasks". Strictly speaking, [threads](https://en.wikipedia.org/wiki/Thread_(computing)) (together with [processes](https://en.wikipedia.org/wiki/Process_(computing))) are the system primitives used to run multiple tasks in parallel in a multitasking system.
