---
layout: old-wiki-page
permalink: /micro-os-plus/i/How_to_install/
title: How to install
author: Liviu Ionescu

date: 2012-11-01 18:28:55 +0000

---

Since the usual development platform is based on Windows, most of the below programs are Windows programs. However GNU/Linux and OS X versions of the toolchains are also available, so it should pe perfectly possible to use other platforms for µOS++ development.

Overview
========

Although the first versions of µOS++ included a classic makefile build procedure, maintaining it proved difficult, and starting with version 3.1 the recommended build environment is the Eclipse CDT. We acknowledge the need for an unmanned build procedure, and plan to include one in the future major redesign, but currently there is no support for other IDE than Eclipse.

Mandatory packages
==================

Java
----

The Java Virtual Machine is required for running Eclipse. The current minimum to satisfy Eclipse is currently Java 5 JRE, but we recommend using the latest version available.

Java JRE is publicly available for download from [Oracle](http://www.java.com/en/download/index.jsp).

Eclipse
-------

Eclipse is currently one of the most used development environments. Initially intended for Java development, it was soon expanded to support other languages too. Since µOS++ is written in C++, the recommended Eclipse package is [Eclipse IDE for C/C++ Developers](http://www.eclipse.org/cdt/), but any other package that includes the CDT can be used as well.

The Eclipse IDE is publicly available for download from [Eclipse.org](http://www.eclipse.org/downloads/). The recommended version is 3.7.2, except for AVR32, since the Atmel provided plug-ins work up to version 3.6.2

The default Eclipse is configured to use limited amounts of memory. For large workspaces, it is recommended you edit the eclipse.ini file and increase it:

    -Xms256m
    -Xmx768m

Although using a single Eclipse for multiple projects in different languages is perfectly possible, it is recommended to try to keep things as modular and separate as possible, and preferably install a dedicated Eclipse instance for the µOS++ projects.

GNU Toolchain & Eclipse Plug-ins
--------------------------------

The GNU Toolchain provides all required tools for cross compiling the micro-controller code on the development machine. Install one or more toolchains, according to the target micro-controller you plan to use.

Follow individual toolchain installation procedures. To avoid surprises, it is recommended to **update the PATH to include the toolchain binary directory**.

The basic Eclipse CDT is able to manages builds only for the same platform where Eclipse is executed. In order to cross build micro-controller code on Eclipse, additional plug-ins are required, to extend the Eclipse CDT Managed Build mechanism for other GNU Toolchains.

### ARM

#### Toolchain

For ARM, the recommended toolchain is [Sourcery CodeBench Lite Edition for ARM EABI](http://www.codesourcery.com/sgpp/lite/arm) available both for Windows and GNU/Linux. Be sure you download **the EABI version**, from the [download page](https://sourcery.mentor.com/sgpp/lite/arm/portal/subscription3053), not the GNU/Linux Target OS one, since this is intended to generate GNU/Linux executables, not barebone embedded flash images.

The version available since 2011-12-19 is 2011.09-69, providing GCC 4.6.1.

For OS X, although Sourcery CodeBench Lite Edition for ARM currently does not provide a binary distribution, the available sources can be easily compiled on Mac OS X (for details please read the [Toolchain installation page](http://gnuarmeclipse.livius.net/wiki/Toolchain_installation_on_OS_X)).

#### Eclipse Plug-in

Eclipse support for GNU toolchains is provided by [Eclipse GNU ARM Plug-in](http://sourceforge.net/projects/gnuarmeclipse/), an Eclipse CDT plug-in supporting GNU ARM toolchains like Sourcery CodeBench Lite, GNUARM, WinARM, Yagarto. Additional support for installing the toolchains might be available on the [GNU ARM Plug-in documentation](http://gnuarmeclipse.sourceforge.net/wiki/Main_Page).

To install this plug-in, use the Eclipse standard install/update mechanism:


**Eclipse** menu: **Help** → **Install New Software**

-   in the *Install* window, click the **Add...** button (on future updates, just select the URL)
    -   fill in **Name:** with GNU ARM
    -   fill in **Location:** with <http://gnuarmeclipse.sourceforge.net/updates>
    -   click the **OK** button
-   in the main window, click Select All to install all plug-ins
-   click the **Next** button
-   accept the unsigned plug-in
-   restart Eclipse, as asked

On OS X, the procedure checking the environment might complain that some of the tools are not available.

### AVR8

#### Toolchain

For AVR8 there are not as many options; on Windows the recommended toolchains is [WinAVR](http://winavr.sourceforge.net/), publicly available for download from [SourceForge](http://sourceforge.net/projects/winavr/files/WinAVR/). Similar toolchains are available for GNU/Linux, although small differences might occur (due to different patches applied to the original GCC source tree).

For OS X, one toolchain is [CrossPack for AVR® Development](http://www.obdev.at/products/crosspack/download.html). It installs in /usr/local/CrossPack-AVR. Please note that the install procedure changes **/etc/profile**, adding a few lines to update the PATH. However, the recommended procedure is to disable the system wide PATH and to use the Eclipse AVR plug-in settings:


**Eclipse** menu: **Preferences** → **AVR** → **Path**

-   AVR-GCC **Custom** /usr/local/CrossPack-AVR-20100115/bin
-   AVR Header Files **Custom** /usr/local/CrossPack-AVR-20100115/avr-3/include
-   AVRDude **Custom** /usr/local/CrossPack-AVR-20100115/bin

If, for any reasons, you need to set the PATH, you can do it via an AppleScript saved in .app format:

    do shell script "export PATH=$PATH:/usr/local/CrossPack-AVR-20100115/bin;$HOME/'My Files/MacBookPro Vault/Projects/uOS/Eclipses/eclipse-3.7.2-cdt/eclipse'"

Alternately you can use a Finder .command script with the following content

    #!/bin/bash
    export PATH=$PATH:/usr/local/CrossPack-AVR-20100115/bin
    $HOME/'My Files/MacBookPro Vault/Projects/uOS/Eclipses/eclipse-3.7.2-cdt/eclipse'

#### Eclipse Plug-in

Eclipse support for GNU toolchains is provided by [AVR Plugin for Eclipse](http://sourceforge.net/projects/avr-eclipse/), an Eclipse CDT plug-in supporting the WinAVR toolchain.

Please note that the version 2.4.0 has a problem when running on OS X, so, for OS X only, it is recommended to download the previous version, the file avreclipse-p2-repository-2.3.4.20100807PRD.zip from the [SourceForge download area](http://sourceforge.net/projects/avr-eclipse/files/avr-eclipse%20stable%20release/2.3.4/) and install it as a local archive.

To install this plug-in on Windows, use the Eclipse standard install/update mechanism:


**Eclipse** menu: **Help** → **Install New Software**

-   in the *Install* window, click the **Add...** button (on future updates, just select the URL)
    -   fill in **Name:** with GNU AVR
    -   fill in **Location:** with <http://avr-eclipse.sourceforge.net/updatesite/>
    -   click the **OK** button
-   in the main window, below **CDT Optional Features** select the **AVR Eclipse Plugin**
-   click the **Next** button
-   accept the unsigned plug-in

### AVR32

#### AVR32 Studio

Originally Atmel based its AVR32 development environment on Eclipse, and provided the [AVR32 Studio](http://www.atmel.com/dyn/products/tools_card.asp?tool_id=4116&category_id=163&family_id=607&subfamily_id=2138) as an integrated tool, based on Eclipse 3.5. It includes the GCC toolchain and all required tools for flash programming and debugging.

In 2011 Atmel abandoned the development of the Eclipse based AVR32 Studio, and implicitly of the Eclipse plug-ins.

On Windows it is recommended to install it anyway, even if you later install a later Eclipse, to have the compiler and tools properly installed.

There is no AVR32 Studio for OS X, so you can skip directly to installing Eclipse.

#### Eclipse

The latest Eclipse running the Atmel plug-in is 3.6.2; although the plug-in installs in 3.7.x, it no longer allows to create new AVR32 projects.

It is recommended to install the Eclipse 3.6.2 CDT, separately from the AVR32 folder.

#### Toolchain

For Windows and Linux, the AVR32 toolchain is provided by Atmel either as a separate package, or is integrated in AVR32 Studio.

For OS X, although currently there is no available binary package, the toolchain can be easily built from the sources, using [James Snyder's Makefile](https://github.com/jsnyder/avr32-toolchain).

#### Eclipse Plug-in

We recommend to manually install the Atmel plug-ins on Eclipse 3.6.2.


**Eclipse** menu: **Help** → **Install New Software**

-   in the *Install* window, click the **Add...** button (on future updates, just select the URL)
    -   fill in **Name:** with Atmel AVR32
    -   fill in **Location:** with <http://distribute.atmel.no/tools/avr32studio/releases/latest/>
    -   click the **OK** button
-   in the main window, below **CDT Optional Features** select the **AVR Eclipse Plugin**
-   click the **Next** button
-   accept the unsigned plug-in

Eclipse Git client
------------------

In spring 2012, the µOS++ repository was moved from SVN to Git, so if you want to use the latest version, you need to access the Git repository from within Eclipse.

Starting with Eclipse 3.6.2, the Eclipse CDT package includes a Git client, so normally there is no need for any special steps.

If you are using another Eclipse package, you might need to manually install it.


**Eclipse** menu: **Help** → **Install New Software**

-   Work with: Indigo
-   Expand **Collaboration**
-   select **Eclipse EGit**
-   click the **Next** button

Eclipse SVN client
------------------

The SVN client provides Eclipse a way to use the SVN repository. For µOS++ versions later than spring 2012, SVN support is no longer mandatory, install it only if you need to acces your own repositories.

For details, see the obsoleted page [How to install Eclipse SVN]({{ site.baseurl }}/micro-os-plus/i/How_to_install_Eclipse_SVN "wikilink")

Other recommended packages
==========================

None

Eclipse workspace configuration
===============================

The default Eclipse configuration is more or less Ok, but there are some details that are either annoying or even harmful, and need to be changed.

Every time you create a new workspace, you need to update the below parameters.

Preferences reference (manual setup)
------------------------------------


**Eclipse** menu: **Window** → **Preferences** ( **Window** → **Preferences** on OS X)

-   **General** → **Workspace**
    -   disable **Build automatically**
    -   enable **Refresh using native hooks or polling**
    -   enable **Refresh on access**
    -   enable **Save automatically before rebuild**
    -   set text file encoding: **UTF-8**
    -   click the **Apply** button
-   **General** → **Editors** → **Text Editors**
    -   enable **Show Line Numbers**
    -   enable **Show Print Margin (80)**
    -   click the **Apply** button
-   **C/C++** → **Code Style** → **Formatter**
    -   select a profile: **GNU [built-in]**
    -   click the **Apply** button
-   **C/C++** → **Indexer**
    -   Indexing strategy: **Automatically update the index** and **Update index immediately after every file-save**
    -   Build configuration for the indexer: **Use active build configuration**
    -   click the **Apply** button

Import/Export preferences
-------------------------

For a more convenient use, Eclipse provides a method to export the Workspace preferences to a file, so the recommend method to save (Export) your Eclipse preferences and later reuse them (Import).

To save the preferences, use the following sequence:


**Eclipse** menu: **File** → **Export**

-   a new Export Select window is displayed
-   expand the **General** entry
-   select **Preferences**
-   click **Next**
-   a new Export Preferences window is displayed
-   enable **Export all**
-   in the To preference file: field, enter the new file name, like **myWorkspacePreferences.Win32.epf**
-   click **Finish**
-   check if the **myWorkspacePreferences.Win32.epf** file was created

To load the preferences, the sequence is:


**Eclipse** menu: **File** → **Import**

-   a new Import Select window is displayed
-   expand the **General** entry
-   select **Preferences**
-   click **Next**
-   a new Import Preferences window is displayed
-   browse for the local **WorkspacePreferences.Win32.epf** file
-   enable **Import all**
-   click **Finish**

Unfortunately not all preferences are stored in this file, and some, like the **C/C++ Indexer** configuration, are important.

We recommend to double check the Eclipse preferences following the above list and update the missing entries.

Indexer configuration
---------------------

**Important:** Please note that Eclipse provides a convenient way to change build configurations between Debug and Release, without having to edit the source code, that remains identical for all configurations. To make the difference, it is necessary to propagate some macro definitions from the Eclipse configuration to the build environment. One of them is, for example, the definition of the DEBUG macro, stored in the Debug build configuration. The Indexer is able to use the configuration definition to properly show the excluded debugging sections when selecting the Release configuration, but unfortunately the default Indexer configuration is to use a fixed configuration, and needs to be changed to follow the active configuration. Without this setting, switching from Debug to Release and back will not be reflected by showing differently the debug code.

Other setting
-------------

Other annoying settings, not saved in the preference file and requiring manual tuning, are related to cleaning all projects and automatic building after clean:


**Eclipse** menu: **Project** → **Clean**

-   select **Clean projects selected below**
-   disable **Start a build immediately**

Please note that during the initial setup, when there are no projects, the **Project** menu is not available. Remember to update this setting after you download the projects.
