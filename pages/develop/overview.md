---
layout: page
lang: en
permalink: /develop/
title: Developer resources
author: Liviu Ionescu

date: 2016-03-09 12:04:00 +0300

---

## Standards

µOS++ source should comply with **C++ 20** and **C 11**

- GCC: `-std=c++-20` or `-std=c11`
- clang: `-std=c++-20` or `-std=c11`

Therecommended compilers are **GCC 10** or newer, or
**LLVM clang 11** or newer.

- [GCC C++ status](https://gcc.gnu.org/projects/cxx-status.html)
- [clang C++ status](https://clang.llvm.org/cxx_status.html)

For a summary of the changes:

- <https://github.com/AnthonyCalandra/modern-cpp-features>

## Coding styles

> ... the likelihood a program will work is significantly enhanced by our ability to read it, which also increases the likelihood that it actually works as intended. It is also the nature of software to be extensively modified over its productive life. If we can read and understand it, then we can hope to modify and improve it. (Douglas Crockford)

- [C++ coding style]({{ site.baseurl }}/develop/coding-style/)
- [C/C++ naming conventions]({{ site.baseurl }}/develop/naming-conventions/)
- [Doxygen style]({{ site.baseurl }}/develop/doxygen-style-guide/)
- [Jekyll style]({{ site.baseurl }}/develop/jekyll-style-guide/)
- [Herb Sutter: C++ Coding Standards]({{ site.baseurl }}/develop/sutter-101/)

## Misc

- [Predefined compiler macros]({{ site.baseurl }}/develop/predefined-macros/)
- [Modular projects]({{ site.baseurl }}/develop/modular-projects/)
- [Web preview](https://micro-os-plus.github.io/web-preview/)

- [Modules the beginner's guide - Daniela Engert - Meeting C++ 2019](https://www.youtube.com/watch?v=Kqo-jIq4V3I)

- [STM32CubeMX]({{ site.baseurl }}/develop/stm32cubemx/)

## Procedures

- [How to release]({{ site.baseurl }}/develop/how-to-release/)

## CMake resources

- [CMake 3.18](https://cmake.org/cmake/help/v3.18/)
- [An Introduction to Modern CMake](https://cliutils.gitlab.io/modern-cmake/)
- [Effective Modern CMake](https://gist.github.com/mbinna/c61dbb39bca0e4fb7d1f73b0d66a4fd1)
- [Craig Scott - Professional CMake: A Practical Guide](https://crascit.com/professional-cmake/)

YouTube

- [C++Now 2017: Daniel Pfeifer “Effective CMake"](https://www.youtube.com/watch?v=bsXLMQ6WgIk)
- [CppCon 2017: Mathieu Ropert “Using Modern CMake Patterns to Enforce a Good Modular Design”](https://www.youtube.com/watch?v=eC9-iRN2b04)
- [CppCon 2018: Mateusz Pusz “Git, CMake, Conan - How to ship and reuse our C++ projects”](https://www.youtube.com/watch?v=S4QSKLXdTtA)
- [Deep CMake for Library Authors - Craig Scott - CppCon 2019](https://www.youtube.com/watch?v=m0DwB4OvDXk)
- [More Modern CMake - Deniz Bahadir - Meeting C++ 2018](https://www.youtube.com/watch?v=y7ndUhdQuU8)
- [Oh No! More Modern CMake - Deniz Bahadir - Meeting C++ 2019](https://www.youtube.com/watch?v=y9kSr5enrSk)

## Links & References

- [Standards and style]({{ site.baseurl }}/develop/references#standards-and-style)
- [Embedded operating systems]({{ site.baseurl }}/develop/references#embedded-operating-systems)
- [C/C++ language libraries]({{ site.baseurl }}/develop/references#cc-language--libraries)
- [TCP/IP libraries]({{ site.baseurl }}/develop/references#tcpip-libraries)
- [Testing]({{ site.baseurl }}/develop/references#testing)
- [Multi-tasking related links]({{ site.baseurl }}/develop/references#multi-tasking-related-links)
- [Miscellaneous]({{ site.baseurl }}/develop/references#miscellaneous)
- [Books]({{ site.baseurl }}/develop/references#books)

## Hardware

- [Test boards]({{ site.baseurl }}/develop/boards/)
