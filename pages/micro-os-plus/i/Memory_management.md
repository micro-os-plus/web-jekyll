---
layout: old-wiki-page
permalink: /micro-os-plus/i/Memory_management/
title: Memory management
author: Liviu Ionescu

date: 2010-11-10 14:09:23 +0000

---

As in most embedded systems the RAM is limited, the default µOS++ memory allocation is static, i.e. at build time.

In terms of C++, all needed objects should be declared as statically allocated object, preferably in **main.cpp**. The compiler guarantees to call all constructors, so static object will pe properly initialized. The developer should keep in mind that static constructors are called before entering **main()**, so the scheduler is not yet running; and second. Also the developer should not assume any special order for calling the constructors (well, there is a rule, object refering previously declared objects will be constructed after the refered objects, but it's safer not to assume any order).

However, for devices with enough RAM, it is possible to dynamicaly allocate objects on the heap, via standard C++ **new/delete**. For this to work, the following definition should be included in the system configuration header:

    #define OS_INCLUDE_NEW_DELETE 1

When this option is enabled, allocation is done on the heap, via **malloc()/free()**.
