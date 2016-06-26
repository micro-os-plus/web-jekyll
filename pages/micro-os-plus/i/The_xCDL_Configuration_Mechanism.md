---
layout: old-wiki-page
permalink: /micro-os-plus/i/The_xCDL_Configuration_Mechanism/
title: The xCDL Configuration Mechanism
author: Liviu Ionescu

date: 2011-11-13 22:41:03 +0000

---

Overview
========

Scope
-----

The xCDL mechanism was designed for the µOS++ SE, but should be general enough to be used for other C/C++ embedded frameworks too.

Goals
-----

The first goal of the configuration mechanism is to help the build mechanism compile only the desired sources. In other words, to define the dependencies between various source files, so that when a certain platform is selected, all needed files are present. Even more, unused source files should not be compiled at all.

The second goal is to automatically generate header files, with various configuration definitions, like preprocessor defines, type definitions, etc.

Credits
-------

The xCDL mechanism is inspired from the eCos CDL mechanism. For details please see:

-   **The eCos Component Writer's Guide** by Bart Veer and John Dallaway, and
-   **Embedded software development with eCos** by Anthony J. Massa.

The XML format used to store the configuration data is the **.plist**, the Apple [property list](http://en.wikipedia.org/wiki/Property_list). For details please see:

-   [The plist(5) manual page](http://developer.apple.com/documentation/Darwin/Reference/ManPages/man5/plist.5.html)
-   [Apple's Property List Document Type Definition](http://www.apple.com/DTDs/PropertyList-1.0.dtd)

Misc:

-   **Software Build Systems: Principles and Experience** by Peter Smith

Package organisation
====================

The xCDL language
=================

The build process
=================

Monolithic vs component based builds.

The xCDL reference
==================