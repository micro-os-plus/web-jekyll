---
layout: page
lang: pt
permalink: /pt/user-manual/features/
title: Recursos do µOS++ IIIe
author: Liviu Ionescu
translator: Carlos Delfino

date: 2016-08-23 17:55:00 +0300
last_updated_at:  2016-11-09 23:30:00 +0300

---
{% comment %}

start_translate_at:  2016-08-23 17:55:00 +0300

 Base Commit: 
 - aac11b8d05198ec0a390c2c046e9578e92726ad0

{% endcomment %}

## Visão Geral

µOS++ IIIe é um sistema operacional POSIX-like, portável, código aberto, livre 
de royalties, multi tarefa, real-time, destinado a aplicações embarcadas 
32/64-bits.

µOS++ IIIe é escrito no **Moderno C++ 11**, com aplicações C++ em mente, mas 
também oferece funcionalidades iguais através de APIs em C.

µOS++ IIIe é a terceira edição do µOS++, oferecendo todos os serviços esperados 
de um sistema real-time moderno, incluindo gerencimaneto de recursos, sincronização, 
comunicação _inter-thread_, e mais. µOS++ IIIe também oferece muitos recursos 
não encontrados em muitos outros sistemas real-time, como ambas as APIs em C++ 
e C, _threads_ POSIX-like, sincronização POSIX de objetos, uso de alocadores de 
memória em C++ e muito mais.

## Recursos

Há uma lista de recursos oferecidos pelo µOS++ IIIe.

### Código Fonte

µOS++ é um **projeto de código aberta (Open Source)**, fornecido sobre altamente 
**permissivos termos da licença do MIT**.

O código aberto disponível não somente ajuda a depurar, mas também melhora 
grandemente o entendimento geral de todo o ambiente de execução, resultando em 
uma aplicação melhor e mais robusta.

### Múltiplas APIs C++ e C

µOS++ é baseado no CMSIS++, e fornece serviços via multiplas APIs, convergindo 
aplicações C++ e C.

As APIs suportadas são:

 - CMSIS++ RTOS C++ API - A API C++ nativa do µOS++ IIIe C++ API, dá acesso 
   direto aos serviços de sistemas;
 - CMSIS++ RTOS C API - Um Wrapper C 1 por 1 no topo da API C++;
 - ISO C++ Threads API - Uma implementação do padrão ISO de _threads_ sobre a 
   API C++;
 - ARM CMSIS RTOS v1 API - Uma camada de compatibilização com ARM CMSIS RTOS.

A API C do CMSIS++ permite escrever aplicações em C puro, mesmo se o core é 
escrito em C++.

A API  ARM CMSIS RTOS permite rodar aplicações legadas, escrita para ARM RTOS 
API

A API _Threads_ ISO C++ fornece uma forma conviniente para executar código ISO 
padrão sem nenhuma alteração.

### APIs POSIX-like

O projeto das APIs de core foram fortemente influenciadas pelas especificações 
de _threads_ do POSIX. Deste ponto  de vista, µOS++ pode também ser visto com  
**POSIX++**, uma versão  C++ do POSIX.

A compatibilidade com POSIX é um recurso muito importante, desde que o POSIX é 
um padrão portável maduro e bem estabelecido, a experiência obtida enquanto 
usando um grande sistema POSIX pode aumentar também a produtividade de 
desenvolvedores de aplicação embarcadas.

### ISO thread C++ API

µOS++ também implementa o padrão de API ISO C++ para _threads_, incluindo a 
funcionalidade `chrono`.

O ISO C++ 14882:2011 introduziu uma API padrão para _threads_, mutexes, variáveis 
condicionais, locks, funções relacionadas a tempo, etc.

Esta API é relativamente fácil de usar, a sobrecarga é baixa e se compartilhar 
código com algum ambiente de servidor é necessário, isto pode ser uma solução 
bem interessante.


### APIs Consistente

As APIs usadas pelo µOS++ são altamente consistente. Uma com as convenções de 
código usadas, é simples prever qual função chamar para um serviços necessário, 
e também prever quais argumentos são necessários. Por exemplo, na API C um 
ponteiro para um objeto é sempre o primeiro argumento, muitas funções retornam 
um código de erro POSIX, etc.

Isso se traduz em aumento de produtividade e melhoria de legibilidade do código 
ao longo do tempo.


### Preempção de multi-tarefa

µOS++ implementa um escalonador baseado em prioridade, preemptivo, multi tarefa 
e para este fim, µOS++ sempre roda a _thread_ mais importante pronta para executar.

Para um sistema real-time, isso melhora a velocidade de reação e ajuda encontrar 
os prazos requeridos.

### Escalonador Round-Robin 

µOS++ permite múltiplas _theards_ executar no mesmo nível de prioridade. Quando 
múltiplas _threads_ no mesmo nível de prioridade estão prontas para executar, 
elas são agendadas através do método round-robin.

Este algoritmo de agendamento, fornece uma distribuição justa do tempo da CPU 
para _threads_ comuns que não tem necessidades especiais, e pode compartilhar 
uma prioridade comum.

### Baixo tempo de desativação de interrupções

µOS++ tem um número interno de estruturas de dados e variáveis que precisam ser 
acessadas atomicamente, Para assegurar isso, µOS++  desabilita interrupções por 
um curto período, para assegurar a latência mínima.

Mantendo as seções criticas curtas, dá a chance de interrupções rápidas ocorrerem 
e a capacidade de resposta do sistema é aumentada.

### Seções criticas seguras aninhadas

Para evitar bugs sutis, as seções criticas do µOS++ são definidas para serem 
facilmente aninhadas, armazenando o estado inicial durante a entrada e restaurando 
as quando saindo.

Estas implementação de armazenamento permite invocar chamadas de sistemas do 
µOS++  de qualquer ambiente, incluindo callbacks desenvolvidos com código que 
usam implementações inadequadas de seções criticas (por exemplo aqueles que usam 
contadores para informar quando re-habilitar interrupções).

Deve ser observado que o inverso não é verdade, chamar bibliotecas de funções que 
implementam seções criticas usando contadores do ambiente quando a interrupção 
estão desabilitadas, possibilita introduzir um problema de sincronização, desde 
que estas funções erroneamente habilitarão as interrupções.

### Configurável

As configurações (ambas dados e códigos) podem ser ajustadas baseadas nas 
demandas da aplicação. Isso é executado em tempo de compilação através de muitos 
`#define` disponíveis (veja `os-app-config.h`). µOS++ também executa um número de 
verificações em tempo de execução nos argumentos passados para seus serviços, 
como não passar ponteiros NULL, não chamar serviços de nível _threads_ de dentro 
de ISRs, quais argumentos estão na faixa permitida, e opções informadas são 
válidas, etc. Estas verificações podem ser desabilitadas (em tempo de compilação) 
para reduzir o tamanho do código e melhorar a performance.

### Modular

Por um cuidado do projeto, somente as funções que são necessárias são lincadas 
em uma aplicação, mantendo o tamanho da ROM pequeno.

### Portabilidade

Por projeto µOS++/CMSIS++ é altamente portável; ele foi desenvolvido boa parte 
em um MacOS e seus testes são constantemente executados tanto em plataforma 32 
como 64-bits.

### Habilitado para ROM

µOS++ foi projetado especialmente para sistemas embarcados e pode ser gravado 
na ROM juntamente com o código da aplicação.

Isso é importante para microcontroladores modernos, que incluem larga quantidade 
de memória flash internamente, e pode executar codigo dela, sem ter que copiar 
para RAM.

### Totalmente alocado estaticamente

µOS++ por sí é totalmente alocado estaticamente, ele não requer memória dinâmica.
que o torna perfeito para aplicações especiais que não toleram riscos associados 
com fragmentações.

### Escolha do usuário para alocação de memória

Para objetos que requerem memoria adicional, o usuário tem total controle de 
usar ou memória alocada estaticamente ou dinamicamente.

µOS++ pode ser usado para construir aplicações especiais que não são permitidas
 usar alocação dinâmica.

### Alocadores de memória personalizados

Na API C++ do µOS++, todos os objetos que requerem memória adicional podem ser 
configurados para usar um alocador de memória personalizado, para, com limite, 
cada objeto possa ser alocado usando um alocador separado.

### Ilimitado números de threads

µOS++ suporta um número ilimitado de _threads_. De um ponto de vista prático, 
porém, o numero de _threads_ é atualmente limitado pela quantidade de memória 
(ambos os espaços de código e dados) que o processador pode acessar, Cada 
_thread_ requer sua própria pilha (_stack_); µOS++ fornece recursos que permite 
monitorar em tempo de execução o crescimento da pilha.

O tamanho padrão do pilha e o tamanho mínimo da pilha pode ser configurado pelo 
usuário.

### Número ilimitado de objetos de sisteas.

µOS++ permite qualquer quantidade de _threads_, semáforos, _mutexes_, _flags_ 
de eventos, filas de mensagens, _timers_, e bancos de memória, etc. O usuário 
em tempo de execução aloca todos os objetos de sistemas, seja como objetos 
estáticos globais, pilha de objetos ou objetos alocados dinamicamente.

Não tendo que definir estaticamente em tempo de compilação o numero máximo de 
objetos é muito conveniente.

### POSIX mutexes

Mutexes com funcionalidades POSIX são fornecidos para gerenciamento de recursos. 
Ambos mutexes, normal e recursivos, estão disponíveis. Mutexes podem ser 
configurados para ter herança de prioridade embutida, que eliminam as inversões 
de prioridades ilimitadas.

### _Timers_ por softwares

_Timers_ são contadores regressivos que executam uma ação definida pelo usuário 
a cada vez que a contagem chega a 0. Cada _timer_ pode ter sua própria ação e, 
se um _timer_ é periódico, o _timer_ é automaticamente recarregado e a ação é 
executada a cada vez que a contagem atinge zero.

### Sinalização de _Thread_

µOS++ permite uma ISR ou _threads_ sinalizar diretamente uma _thread_. Isso 
evita ter que criar um objeto de sistema intermediário como um semaforo ou _flat_ 
de evento exatamente para sinalizar uma thread, e assim resulta em uma melhor 
performance.

### Dados de usuário na _thread_

_Threads podem incluir uma estrutura de dados de usuário definivel pelo usuário, 
onde a aplicação pode gravar dados personalizados.

A definição desta estrutura de dados em C puro é um `struct` e o conteúdo é 
totalmente sobre o controle do usuário.

### Verificação de Error

µOS++ verifica que ponteiros NULL não sejam passados, que o usuário não está 
chamando um serviço de nível de _thread_ de dentro de uma ISR, que faixa de 
argumentos são permitidos, que opções especificas são válidas, qual _handler_ 
é passado para o objeto correto com parte de argumentos de serviços que manipulam 
o objeto desejado, e mais.

Geralmente estas validações adicionais são habilitadas em configurações de 
depuração, e desabilitadas nos _Releases_, para salvar espaço significante e 
algum tempo de execução.

### Estatísticas da _thread_

µOS++ tem recursos embutidos para medir o tempo de execução de cada _thread_, 
uso do _stack_ o numero de vezes que uma _thread_ é executada, uso da CPU e mais.

Isso pode ser usado para monitorar o comportamento do sistema em tempo de execução, 
e detectar possibilidades de implementações de esperas ocupadas ineficientes.

### Prevenção de Deadlock

Todas as chamadas de bloqueio do µOS++ tem versões que incluem prazos de espera, 
que ajudam a evitar _deadlocks_.

### Nome de Objetos

Cada objeto de sistema no µOS++ pode ter um nome associado com ele. Isso faz com
que seja mais fácil de reconhecer qual objeto é designado para o que. Designando 
um nome para uma _thread_, um semáforo, um _mutex_, uma _flat_ de evento de grupo, 
uma fila de mensagem, um banco de memória, e um timer. O nome do objeto  pode 
ter qualquer comprimento, mas deve ser terminado com NULL.

Estes nomes podem ser inspecionados durante a seção de depuração, para identificar 
objetos, e pode também ser exibido por ferramentas de instrumentação avançadas.

### Suporte para depuradores de Threads.

Este recurso permite depuradores de _threads_ examinar e exibir variáveis e 
estruturas de dados do µOS++ em uma forma amigáveis ao usuário. (Ainda em implementação)

### Suporte para instrumentação

Este recurso permite integração com ferramentas de instrumentação como SEGGER, 
SystemView. (Ainda em implementação)

### Múltiplos relógios

A solução clássica para tratar o tempo em muito sistemas embarcados é usar um 
timer de agendamento, Por padrão no µOS++ a resolução do relógio é de 1ms, 
aceitável para as maiores aplicações.

µOS++ também define uma API padrão para acessar o relógio real-time, que tem 
resolução de 1 segundo, e pode ser usado para configurar prazos mesmo quando a 
CPU esteja em suspensão profunda (_Deep Sleep_).

Para medição apurada do tempo, até o nível do ciclo da CPU, um timer de alta 
resolução derivado do timer do escalonador, que também está disponível.

µOS++ fornece uma API comum para todos os relógios, e objetos de sincronização 
que podem ser configurados para usar algum dos relógios disponíveis.
