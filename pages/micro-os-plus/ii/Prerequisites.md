---
layout: old-wiki-page
permalink: /micro-os-plus/ii/Prerequisites/
title: Prerequisites
author: Liviu Ionescu

date: 2013-09-06 11:12:50 +0000

---

There are several ways to evaluate **µOS++ SE**, from running the unit tests to inspecting the source code. Depending on your needs and on the platform you are using, one or more toolchains need to be installed. For inspecting the source code, although direct access to the repository is available, due to the high complexity of the project, the preferred method is via Eclipse, to take full advantage of the indexer and cross reference features.

Currently the supported platforms for building µOS++ SE projects are **OS X** and **GNU/Linux**.

If testing software is generally a delicate issue, testing embedded software is an even more complicated story, since images must be written into embedded processor flash and some form of interaction with the hardware is needed to validate the software behaviour.

In order to simplify things, one of the early µOS++ design decision was to include a POSIX synthetic platform, running on OS X and GNU/Linux. In this configuration, each µOS++ application is executed within the context of a POSIX process, running as a command line application.

OS X
----

The main toolchain for building µOS++ SE synthetic POSIX applications is the default **Apple LLVM clang**.

Optionally, µOS++ SE tests can be built with GNU GCC 4.7 and GCC 4.8.

With all three compilers, in both the 32 and 64-bit versions, in both the *Debug* and *Release* configurations, a total of 12 versions for each test are checked.

### LLVM clang

The shortcut method for installing **clang** is to download and install the optional package **Command Line Tools for Xcode** available from the [Apple Developper site](http://developer.apple.com/downloads/).

However, the recommended method is to first install **Xcode** from App Store, then to download the **Command Line Tools** additional component in the Preferences → Downloads → Components window.

[Image:Xcode-clt.png]({{ site.baseurl }}/micro-os-plus/ii/Image:Xcode-clt.png "wikilink")

To check if the compiler is available, invoke the compiler using **--version**:

    clang++ --version

    Apple LLVM version 4.2 (clang-425.0.28) (based on LLVM 3.2svn)
    Target: x86_64-apple-darwin12.4.0
    Thread model: posix

### Git

Installing the **Command Line Tools** will also install the **git** support.

    git --version
    git version 1.7.12.4 (Apple Git-37)

For reference, here is the **git** global configuration that I use:

    git config --global user.name "Liviu Ionescu"
    git config --global user.email ilg@livius.net

    git config --global core.filemode false
    git config --global core.autocrlf input

    git config --global core.whitespace trailing-space,space-before-tab

    git config --global core.editor "vi"

(for more details, please check the [git documentation](http://git-scm.com/docs/git-config)).

### Python

Python should be also available (it is part of the standard OS X distribution):

    python --version
    Python 2.7.2

### MacPorts GCC

The GNU GCC compilers can be installed on OS X from multiple sources, but the recommended source is from [MacPorts](http://www.macports.org).

Installing MacPorts is not mandatory for usual embedded developments, but running the POSIX tests it is recommended, since it provides the GCC compilers (otherwise only the clang tests will be performed).

To install GCC 4.7 and GCC 4.8, run the following commands:

    sudo port install gcc47 +universal
    sudo port install gcc48 +universal

Please note that, by default, the modern MacPorts compilers support only 64-bit targets. To support both 32 and 64-bit targets, the **+universal** option must be used when installing the toolchains, otherwise the tests will fail to run the 32-bit executables.

The toolchain binaries are available in `/opt/local/bin/` as:

-   g++-mp-4.7
-   g++-mp-4.8

To check if the compilers are available, invoke the compilers using **--version**:

    /opt/local/bin/g++-mp-4.7 --version
    g++-mp-4.7 (MacPorts gcc47 4.7.3_1+universal) 4.7.3

    /opt/local/bin/g++-mp-4.8 --version
    g++-mp-4.8 (MacPorts gcc48 4.8.1_1+universal) 4.8.1

One detail to be considered: the PATH setting. When the MacPorts framework is installed, the .profile is modified to include the MacPorts path.

    # MacPorts Installer addition on 2012-12-05_at_23:48:38: adding an appropriate PATH variable for use with MacPorts.
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    # Finished adapting your PATH environment variable for use with MacPorts.

To avoid unwanted interactions between MacPorts and the system programs, it is recommended to disable this setting, and to add an explicit alias to update the PATH only when needed:

    alias mp='export PATH=/opt/local/bin:/opt/local/sbin:$PATH'

### ARM toolchains

There are many ARM toolchains available on OS X, more or less up-to-date.

Until recently the ARM reference toolchain was **Sourcery CodeBench Lite ARM**, but more traction seems to gain now the **GNU Tools for ARM Embedded Processors**.

#### GNU Tools for ARM Embedded Processors

It is a relatively new, but very active, toolchain (first release seems to date from end of 2011), is hosted on [launchpad.net](http://launchpad.net/gcc-arm-embedded) and runs on all significant platforms. The current version is based on GCC 4.7.3.

To use this toolchain, download the latest `gcc-arm-none-eabi-*.tar.bz2` file (there are separate files for OS X and GNU/Linux), unpack it and copy the resulting folder to `/usr/local`.

To simplify path management, it is recommended to create a link to the latest release of a certain version, for example:

    cd ~/Downloads
    sudo cp gcc-arm-none-eabi-4_7-2013q1-20130313-mac.tar.bz2 /usr/local
    cd /usr/local
    sudo tar xjvf gcc-arm-none-eabi-4_7-2013q1-20130313-mac.tar.bz2
    sudo ln -s gcc-arm-none-eabi-4_7-2013q1 gcc-arm-none-eabi-4_7

(for GNU/Linux the sequence is identical, only the file name is different, instead of **-mac** they use **-linux**).

To check if the compiler is available, invoke the compiler using **--version**:

    /usr/local/gcc-arm-none-eabi-4_7/bin/arm-none-eabi-g++ --version

which should produce something like:

    arm-none-eabi-g++ (GNU Tools for ARM Embedded Processors) 4.7.3
         20130312 (release) [ARM/embedded-4_7-branch revision 196615]

### AVR8 toolchains

#### MacPorts

The latest AVR8 toolchain (based on GCC 4.7.2) is available from MacPorts.

    sudo port install avr-gcc avr-binutils avr-gdb avr-libc avrdude

To check if the compiler is available, invoke the compiler using **--version**:

    /opt/local/bin/avr-g++ --version

    avr-g++ (GCC) 4.7.2

#### CrossPack

Another AVR8 toolchain is [CrossPack for AVR Development](http://www.obdev.at/products/crosspack/index.html) published by [Objective Development](http://www.obdev.at/). The current version is based on GNU GCC 4.6.2.

To use this toolchain, download the latest CrossPack-AVR-\*.dmg version and install it as usual.

The toolchain binaries are installed in `/usr/local/CrossPack-AVR/bin/` as:

-   avr-g++
-   avr-gcc

To check if the compiler is available, invoke the compiler using **--version**:

    /usr/local/CrossPack-AVR/bin/avr-g++ --version

    avr-g++ (GCC) 4.6.2

Similarly to MacPorts, the CrossPack installer modifies the system settings to add the CrossPack path to the system path.

    cat /etc/paths.d/50-at.obdev.CrossPack-AVR

    /usr/local/CrossPack-AVR/bin

It is recommended to disable this setting, and to explicitly update the PATH only when needed:

    sudo rm /etc/paths.d/50-at.obdev.CrossPack-AVR

GNU/Linux
---------

Currently all tests are periodically checked on Ubuntu. Unfortunately the latest stable version (12.04 LTS) provides only GCC 4.6, which lacks the required C++11 features needed by µOS++ SE, so we currently use 13.04.

### Ubuntu 13.04

The current Ubuntu is 13.04, and both 64 and 32 bit tests are run on the 64 bit version of the operating system.

The prerequisites for running the POSIX tests on Ubuntu are:

    sudo apt-get install g++-multilib
    sudo apt-get install git python openssh-server

The default GCC compiler for 13.04 is 4.7:

    g++ --version
    g++ (Ubuntu/Linaro 4.7.3-1ubuntu1) 4.7.3

For additional tests, on 13.04 it is also possible to install **clang**:

    sudo apt-get install clang

    clang --version
    Ubuntu clang version 3.2-1~exp9ubuntu1 (tags/RELEASE_32/final) (based on LLVM 3.2)
    Target: x86_64-pc-linux-gnu
    Thread model: posix

Git and Python should also be available:

    git --version
    git version 1.8.1.2

    python --version
    Python 2.7.4

Eclipse installation
--------------------

For details regarding Eclipse installation, please read the separate page [Eclipse (install and config)]({{ site.baseurl }}/micro-os-plus/ii/Eclipse_(install_and_config) "wikilink").
