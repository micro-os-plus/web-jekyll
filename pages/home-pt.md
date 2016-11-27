---
layout: main
lang: pt
permalink: /pt/
title: O Projeto µOS++ IIIe
author: Liviu Ionescu
translator: Carlos Delfino 

date: 2016-03-03 22:35:00 +0300
last_modified_at: 2016-11-10 19:30:00 +300
---
{% comment %}
Start translate at: 2016-11-10 19:30:00 +300

Base Commit: 
 - aac11b8d05198ec0a390c2c046e9578e92726ad0

{% endcomment %}

O  projeto **µOS++ IIIe** _(micro oh ɛs plus plus terceira edição)_ é a terciera
interação do µOS++, um POSIX-like, portável, código aberto, royalty-free, sistema
operacional multi-tarefa real-time planejado para aplicações embarcadas de 
32/64-bits, escrito em C++. O projeto é hospedado no GitHub como 
[micro-os-plus](https://github.com/micro-os-plus). Ele tem um 
[Manual de Usuário]({{ site.baseurl }}/{{ page.lang }}/user-manual/) abrangente.

**CMSIS++** é uma proposta para o futuro CMSIS, escrito em C++, e é o 
componente interno base do **µOS++ IIIe**, definindo as APIs do sistema. Estas
APIs são documentadas na [referência do CMSIS++]({{ site.baseurl }}/{{ page.lang}}/reference/cmsis-plus/).

**POSIX++** é outro ponto de vista do projeto, que a maioria das APIs de sistemas
usam a semantica do POSIX, mas sendo escrito em C++, as APIs do **µOS++ IIIe** 
podem podem ser vistas com versões C++ do POSIX, por isso o nome **POSIX++**.

## Dupla identidade

O projeto **µOS++ IIIe** pode ser considerado de dois pontos de vista.

### O pacote µOS++

De um ponto de vista modular, o **µOS++ IIIe** é uma **coleção de pacotes**
hospedado no GitHub em duas localizações:

 * O código original é agrupado sobre uma coleção de projetos no 
 [µOS++ IIIe / CMSIS++](https://github.com/micro-os-plus)
 * Projetos baseado em código de terceiros são agrupadossobre
   coleção [xPacks](https://github.com/xpacks) collection.

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-collection.png" />
</div>

### O RTOS µOS++ 

De um ponto de vista do sistema embarcado, o **µOS++ IIIe** fornece 
**referências de implementação** para o **escalonador** do CMSIS++ e
objeto de sincronização portaveis (como mutex, semaforos, etc).

<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-rtos.png" />
</div>

## Licença

A não ser quando mencionado ao contrário, todos os componentes do 
**µOS++ IIIe / CMSIS++** são fornecidos **livres de taxas** sobre os termos da 
[Licença do MIT](https://opensource.org/licenses/MIT).
