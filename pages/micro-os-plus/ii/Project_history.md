---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Project_history/
title: Project history
author: Liviu Ionescu

date: 2014-03-12 21:47:32 +0000

---

Mar. 2014
---------

After experimenting with several implementation for the GpioPort & Pin, it was concluded that best readability for accessing the hardware registers is offered by using the CMSIS large device header; the second choice was offered by using RegisterAccess policies, with the advantage of compile time checks for read/write violations, but with loss of readability.

The documentation for the ARM CMSIS packages was studied and some tests were performed with the Keil tools; CMSIS packages might become the preferred distribution mechanism.

A more C-friendly approach was adopted.

Feb. 2014
---------

The need for the third edition of µOS++ become evident after the experience with GNU ARM Eclipse plug-ins and the obvious need to integrate µOS++ with Eclipse.

Work on µOS++ IIIe officially started with creation of the new Git repository and the update of the Wiki.

Oct. 2013
---------

The project grew steadily, with the core classes functional, the preemptive scheduler was functional on STM32Fx cores, and the cooperative also on synthetic POSIX platforms (OS X and GNU/Linux). The sources compiled without warnings on GCC 4.7, GCC 4.8 and LLVM clang 3.2/3.3, in 32/64-bit variants, and a multitude of tests were running on OS X and Ubuntu.

The repository increased to more than 700 files, with more than 150K lines.

Acknowledging the need for a better Eclipse integration, in Oct. 2013 the development was temporarily interrupted, with focus changes to [GNU ARM Eclipse plug-ins](http://gnuarmeclipse.livius.net/blog/).

Apr. 2013
---------

The general framework with functional initialisation code is available for STM32F1 and STM32F4, for several development boards.

Jan. 2013
---------

The need for second edition of µOS++ become obvious while using it for several commercial projects, but active work started in early 2013, after the XCDL (eXtended Components Definition Language) project become functional.

The major critics of the first version was the lack of support for [Continuous Integration](http://en.wikipedia.org/wiki/Continuous_integration) and [Test Driven Development](http://en.wikipedia.org/wiki/Test-driven_development), requirements more and more observed for modern projects.

Starting from the beginning, the first version of a unit testing infrastructure is functional on the OS X synthetic platform.

The SE project wiki was created, initially hosted in the SourceForge project web space, then moved to the livius.net domain due to major SourceForge shortcomings.

Early history
-------------

The [early history]({{ site.baseurl }}/micro-os-plus/ii/Early_history "wikilink"), copied from the first edition wiki, with the reasons for a new micro OS and the decision to use C++.
