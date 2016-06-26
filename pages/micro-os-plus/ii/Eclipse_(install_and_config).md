---
layout: old-wiki-page
permalink: /micro-os-plus/ii/Eclipse_(install_and_config)/
title: Eclipse (install and config)
author: Liviu Ionescu

date: 2013-09-09 13:46:36 +0000

---

Although the minimum development environment for µOS++ SE requires only a shell terminal and a character based editor (like vi or emacs), the recommended development environment is based on [Eclipse IDE](http://www.eclipse.org), more specifically on **Eclipse IDE for C/C++ Developers**, available from [Eclipse downloads](http://www.eclipse.org/downloads/).

Currently there are no specific plug-ins required, so any recent Eclipse version should work. The below steps are based on Eclipse 4.3 Kepler, running on OS X, but should not be much different when running on Ubuntu.

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Eclipse_Kepler.png "wikilink")

Personal preferences
--------------------

The below procedure is based on my personal preferences, and I usually like to keep things grouped in separate folders. If you have your strong opinions on how things should be organised, you can obviously adjust the procedure to suit your need. Otherwise, if you do this for the first time, it is recommended to follow the procedure in detail, as-is, to avoid surprises.

Download
--------

Although you can use an existing Eclipse that you already have installed, it is recommended to keep things distinct, and do not share development tools between project, especially since Eclipse does not install system components and has absolutely no problems with multiple instances of itself.

So, it is recommended to prepare a local folder where all current and future Eclipses used for this project will be stored, and to download a fresh Eclipse into it:

-   prepare a local location in the work folder

<!-- -->

    mkdir -p "~/work/uOS/Eclipses"

-   download **Eclipse IDE for C/C++ Developers** for your platform, preferably the 64-bit version (for example eclipse-cpp-kepler-R-macosx-cocoa-x86_64.tar.gz) into this new folder
-   unpack the archive; the result should be a folder named **eclipse**
-   to make things more explicit, and to avoid confusions with future versions, it is recommended to rename the **eclipse** folder to something like **eclipse-4.3-cdt**
-   go into this folder and make an alias of the **Eclipse.app**, with a name containing the version, like **Eclipse-4.3-CDT.app alias**, and move the alias to a convenient place, like a Launcher, a menu, the Desktop, etc. (on GNU/Linux instead of an alias you can make a symbolic link).

Create workspace
----------------

-   prepare a local location where the workspace(s) related to this project will be stored

<!-- -->

    mkdir -p "~/work/uOS/Eclipse Workspaces"

-   start the new Eclipse and define a new workspace, for example: **\~/work/uOS/Eclipse Workspaces/workspace-4.3-osx**

Install plug-ins
----------------

### PyDev

The PyDev plug-in is necessary to better view the Python XCDL files, even if Python development is not planned.

In **Help** menu → **Install New Software...**

-   press the **Add...** button
-   set Name: **PyDev**
-   set Location: **<http://pydev.org/updates>**
-   press the **OK** button
-   enable **PyDev** and optionally **PyDev Mylyn Integration**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Install_PyDev.png "wikilink")

-   press the **Next** button
-   accept the license
-   press the **Finish** button
-   wait for the plug-in to be installed
-   press the **OK** button to accept installing plug-ins with unsigned content
-   select the Brainwy Software certificate
-   press the **OK** button
-   press the **Yes** button to accept Eclipse to restart.

### GDB Hardware Debugging

If you plan to do any debugging using JTAG/SWD probes, it is recommended to install the GDB Hardware Debugging support plug-in.

In **Help** menu → **Install New Software...**

-   in the **Work with** field select **Kepler...**
-   in the below window expand **Mobile and Device Development**
-   and select **C/C++ GDB Hardware Debugging**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Install_GDB_Hardware.png "wikilink")

-   press the **Next \>** button
-   press the **Next \>** button
-   accept the license
-   press the **Finish** button
-   press the **Yes** button to accept Eclipse to restart.

Configure workspace preferences
-------------------------------

In **Eclipse** menu → **Preferences...** → **General** → **Workspace**

-   disable **Build Automatically**
-   enable **Save automatically before build**
-   set **Text file encoding: UTF-8**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:General_Workspace.png "wikilink")

In **Eclipse** menu → **Preferences...** → **General** → **Editors** → **Text Editors**

-   enable **Show print margin**
-   check **Print margin column: 80**
-   enable **Show line numbers**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:General_Editors.png "wikilink")

In **Eclipse** menu → **Preferences...** → **C/C++** → **Code Style** → **Formatter**

-   set **Active profile: GNU [built-in]**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Code_Style_Formatter.png "wikilink")

In **Eclipse** menu → **Preferences...** → **C/C++** → **Indexer**

-   check Indexing strategy: **Automatically update the index**
-   check Indexing strategy: **Update index immediately after every file-save**
-   set **Build configuration for the indexer: Use active build configuration**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Indexer.png "wikilink")

Configure PyDev preferences
---------------------------

In **Eclipse** menu → **Preferences...** → **PyDev** → **Interpreter - Python**

-   press the **Auto Config** button
    -   select the Eclipse plugin
    -   press the **OK** button
-   press the **OK** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Python_Interpreter.png "wikilink")

In **Eclipse** menu → **Preferences...** → **PyDev** → **Editor**

-   in **Appearance color options**, select Comments
-   configure **Color** to a **50% grey**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:PyDev_Comments.png "wikilink")

Clone repositories
------------------

### Local repositories

If you already performed the unit tests, the two required repositories are already locally cloned, and you just have to inform Eclipse on their location, and import the projects.

For this, in the **File** menu → **Import**

-   expand **Git**
-   select **Projects from Git**
-   press the **Next** button
-   select **Local**
-   press the **Next** button; if the Eclipse instance is fresh, there are no local repositories registered, and you need to add them
    -   press the **Add...** button
    -   browse to the **micro-os-plus-se.git** folder
    -   press the **Finish** button
-   press the **Next** button
-   select **Import existing projects**
-   press the **Next** button
-   select the **micro-os-plus-se.git** project
-   click the **Finish** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Import_uOS.png "wikilink")

Repeat this procedure for the **xcdl-python.git** repository, and import the **xcdl-python** project.

### Remote repositories

If you did not perform the unit tests, then you need to clone the repositories to a local folder. You can do this either using the command line git command and then just perform the above steps, or using Eclipse specific commands, as explained below.

In the **File** menu → **Import**

-   expand **Git**
-   select **Projects from Git**
-   press the **Next** button
-   select **URI**
-   press the **Next** button
-   fill in the **URI** field with **<http://git.code.sf.net/p/micro-os-plus/second>**
-   press the **Next** button
-   select the **master** branch
-   press the **Next** button
-   fill in the **Destination Directory** field with the absolute folder path, like **/Users/XXX/work/uOS/micro-os-plus-se.git**
-   select the **micro-os-plus-se.git** project
-   click the **Finish** button

Similarly, repeat the steps for the second repository URI **<http://git.code.sf.net/p/xcdl/python>**, clone it to an absolute folder path like **/Users/XXX/work/uOS/xcdl-python.git** and import the **xcdl-python** project.

Configure paths and locations
-----------------------------

To simplify entering of various program or folder locations in Eclipse, it is recommended to define them once, as variables, and refer them as many times as needed.

Eclipse is a bit confusing when dealing with variables, since it allows several types of them, called with different names, but, with some attention, it allows the job done.

In the **Eclipse** menu → **Preferences...** → **C/C++** → **Build** → **Build Variables**

-   press the **Add...** button
    -   fill in **Variable name** with **MICRO_OS_PLUS_SE_LOC**
    -   select **Type** as **Directory**
    -   in the **Value** field browse the filesystem to the **micro-os-plus-se.git** folder
    -   press the **OK** button
-   press the **Add...** button
    -   fill in **Variable name** with **XCDLBUILD**
    -   select **Type** as **File**
    -   in the **Value** field browse the filesystem and from the **xcdl-python.git** folder select **scripts/xcdlBuild.sh**
    -   press the **OK** button
-   press the **Add...** button
    -   fill in **Variable name** with **GCC_ARM_EP_LOC**
    -   select **Type** as **Directory**
    -   in the **Value** field browse the filesystem and select the bin folder where the ARM toolchain is installed
    -   press the **OK** button
-   press the **OK** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Build_Variables.png "wikilink")

In addition to the C/C++ Build Variables, we also need the µOS++ SE location for a linked folder, so an additional definition General Workspace group is required.

In the **Eclipse** menu → **Preferences...** → **General** → **Workspace** → **Linked Resources**

-   press the **New...** button
    -   fill in the **Name** field with **MICRO_OS_PLUS_SE_LOC**
    -   in the **Location** field browse the filesystem to the absolute **micro-os-plus-se.git** folder
    -   press the **OK** button
-   press the **OK** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Linked_Resources.png "wikilink")

Note: The yellow exclamation mark is there because the sample path is not valid.

Create a new µOS++ project
--------------------------

Once the µOS++ SE folder is available, it can be linked to as many projects as necessary, without having to keep multiple copies of it, significantly simplifying space management.

The Eclipse projects used for µOS++ applications should be created as Makefile projects, without a toolchain (this detail is very important!).

In order for the indexer to function properly, some additional details need to be manually defined:

-   the path to the toolchain
-   the compiler command (it is used to generate the list of system Includes and preprocessor defines)
-   two more include paths, one to the central µOS++ folder and one to the build folder

µOS++ has a large number of build configurations defined in the XCDL metadata, to support not only multiple applications, but also building the same application for multiple platforms (different boards, different synthetic platforms), with different compilers, in different bit sizes (32/64-bit), for Debug/Release. There are no metadata limitations on how these build configurations should be grouped, so it is completely up to you, you can group them by applications, by platform, or by any other criterion.

For example, to create a project to group all QEMU build configurations, follow the steps:

In the **File** menu: **New** → **C++ Project**

-   fill the **Project name** field with a valid name, for example QEMU
-   in the **Project type** list, expand the **Makefile Project** entry and select **Empty Project**
-   in the **Toolchains** list, select **-- Other Toolchain --** (note: this detail is very important)
-   press the **Finish** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:New_Project.png "wikilink")

The new project is now visible in the Project Explorer, but is completely empty, and, to be functional, it needs to be configured.

### Configure toolchain path

-   select the project
-   in the **Project** menu: **Properties** → **C/C++ Build** → **Environment**
-   the configuration selection should read Default (the only one in the beginning)
-   press the **Add...** button
    -   fill in the **Name** field with **PATH**
    -   fill in the **Value** field with **\${GCC_ARM_EP_LOC}**
    -   press the **OK** button
-   a new environment definition should be added, with the variable at the end
-   press the **OK** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Toochain_Path.png "wikilink")

### Configure preprocessor discovery command

-   select the project
-   in the **Project** menu: **Properties** → **C/C++ General** → **Preprocessor Include Paths**
-   the configuration selection should read Default (the only one in the beginning)
-   select the **Providers** tab
-   enable the first 4 entries:
    -   **CDT User Setting Entries**
    -   **CDT Managed Build Setting Entries**
    -   **CDT GCC Build Output Parser**
    -   **CDT GCC Built-in Compiler Settings**
-   select **CDT GCC Built-in Compiler Settings**
-   disable **Use global provider shared between projects**
-   edit the command line and replace the **\${COMMAND}** with the actual g++ command name, for example **arm-none-eabi-g++**
-   press the **OK** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Discovery_Providers.png "wikilink")

Once the toolchain path and the discovery command are properly configured, the **Includes** list in the **Project Explorer** should be populated with the a list specific to the toolchain.

[center]({{ site.baseurl }}/micro-os-plus/ii/File:QEMU_Includes.png "wikilink")

### Add the µOS++ specific include folders

-   select the project
-   in the **Project** menu: **Properties** → **C/C++ General** → **Paths and Symbols**
-   select the **Includes** tab
-   press the **Add...** button
    -   fill in the **Directory** field with **\${ProjDirPath}/build/\${config_name:\${ProjName}}/include**
    -   enable **Add to all languages**
    -   press the **OK** button
-   press the **Add...** button
    -   fill in the **Directory** field with **\${MICRO_OS_PLUS_SE_LOC}/packages**
    -   enable **Add to all languages**
    -   press the **OK** button
-   press the OK button

### Add a linked folder to the µOS++ sources

-   select the project
-   in the **File** menu: **New** → **Folder**
-   fill in the **Folder name** with **micro-os-plus-se**
-   press the **Advanced \>\>** button
-   select the **Link to alternate location** option
-   fill in the location field with **MICRO_OS_PLUS_SE_LOC/packages** (alternatively this can be done by pushing the **Variables...** button, selecting the **MICRO_OS_PLUS_SE_LOC** variable, pushing the **Extend...** button and selecting the **packages** folder)
-   press the **Finish** button

To check if the definition is valid, expand the **micro-os-plus-se** folder and check if the µOS++ SE sources are available.

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Linked_Folder.png "wikilink")

### Configure the custom build command

-   select the project
-   in the **Project** menu: **Properties** → **C/C++ Build**
-   select the **Builder Settings** tab
-   disable **Use default build command**
-   fill in the **Build command** field with **/bin/bash "\${XCDLBUILD}" --repository='\${MICRO_OS_PLUS_SE_LOC}/packages' --build_config=\${config_name:\${ProjName}}**
-   press the **OK** button

### Create actual build configurations

All above settings were performed on the Default build configuration. This configuration in itself is not functional, since there is no µOS++ configuration called Default, but is useful, since it can be used as template to create actual build configurations.

This can be done using the Manage Configurations dialog.

-   select the project
-   in the **Project** menu: **Build Configurations** → **Manage** (alternatively you can right click on the project and select the command)
-   in the new window, press the **New...** button
    -   fill in the **Name** field with an existing µOS++ configuration name, for example **qemu_osx_aep_gcc_minimal_Debug**
    -   select the **Existing configuration** option, the **Default** entry
    -   press the **OK** button
-   press the **OK** button

Eventually repeat this step, and add a new build configuration named **qemu_osx_aep_gcc_minimal_Release**.

### Build the new configurations

To build only one configuration, click on the down pointing triangle on the right of the hammer icon and select one of the existing configuration. This selects the active configuration and also starts the build process.

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Build_configurations.png "wikilink")

Avoid to build all defined configurations (using the Project menu: Build All) since this will also try to build the python projects, and it takes some time.

The result of each build is a folder below the **build** folder, with the same name as the build configuration.

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Minimal_build.png "wikilink")

### Check indexer

The indexer is configured to automatically reindex the active build configuration.

To check if this functions properly, switch between Release/Debug and verify if the two lines turn grey on Release and remain white on Debug.

If, for any reason, during development, you think the index was not updated, you can force it to run using the **Project** menu → **C/C++ Index** → **Rebuild**.

Configure the run console
-------------------------

With such a complex project, the build output is sometimes quite large, and it is recommended to remove any limitations imposed on the console output, in order to avoid missing its beginning.

The **Eclipse** menu: **Preferences...** → **Run/Debug** → **Console**

-   disable **Limit console output**

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Run_Console.png "wikilink")

Configure the project Clean options
-----------------------------------

As a detail that sometimes is annoying, it is recommended to configure Clean to clean only the selected project, and to not start build automatically.

This is achieved via the **Project** menu → **Clean...**

-   select **Clean projects selected below**
-   select the **QEMU** project
-   disable **Start a build immediately**
-   press the **OK** button

[center]({{ site.baseurl }}/micro-os-plus/ii/File:Clean.png "wikilink")
