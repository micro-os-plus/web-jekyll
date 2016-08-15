---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Deviations_from_standards/
title: Deviations from standards
author: Liviu Ionescu

date: 2013-05-03 16:58:06 +0000

---

Due to the embedded systems specifics, there are some implementation deviations from the standards or general purpose computers software recommendations.

atexit() not available
----------------------

Since embedded applications are generally running continuously and do not exit, like regular applications, the atexit() library function is not available. To inform the compiler of this decision, the option **-fno-use-cxa-atexit** is used when calling the compiler.

However, although rarely used, static destructors are called in the proper order.

std:: renamed os::std::
-----------------------

The **std::** namespace is not available as is, a full implementation of it being too heavy for embedded environments. Instead, a lighter version is available in the namespace **os::std::**.

A separate namespace has also the advantage of being able to run test applications on synthetic POSIX platforms, without name clashes.
