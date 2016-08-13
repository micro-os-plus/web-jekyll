## Install tools

```
sudo port install pandoc
curl -sS https://getcomposer.org/installer | php
php composer.phar install
```

## Export MediaWiki

[The µOS++ (micro os plus plus)](http://micro-os-plus.sourceforge.net/wiki/The_µOS%2B%2B_IIIe_Wiki)

In **Special:Allpages**, copy/paste names:

```
Coding style
Coding style (SE)
Criticism of previous versions
Critics of previous versions
Development environment
Deviations from standards
Deviations from standards (SE)
Doxygen style guide
Doxygen style guide (SE)
Early history
Eclipse (install and config)
How to test
Main Page
Naming conventions
Naming conventions (SE)
Predefined macros
Prerequisites
Project history
References
References notes
SRS Guide
Support
The µOS++ IIIe Wiki
The µOS++ SE Wiki
The µOS++ SE Wiki:Copyrights
The µOS++ Second Edition Wiki
Wiki pages style guide
Wiki pages style guide (SE)
```

In **Special:Export**

Copy/paste the above list, include only the current revision, save as file, rename uOS-ii-mw.xml.

## Convert µOS++ IIIe Wiki

```
php convert.php --filename=uOS-ii-mw.xml --output=uOS-ii-output --urlprefix=micro-os-plus/ii/ --layout=old-wiki-page
```

## Export old MediaWiki

[The µOS++ (micro os plus plus)](http://micro-os-plus.sourceforge.net/old-wiki/The_µOS%2B%2B_(micro_os_plus_plus))

In **Special:Allpages**, copy/paste names:

```
Advanced (Custom) Timers
Application configuration
C++ naming convention
C++ source code style guide
CLass OSEventFlags
Change log
Class LargeCircularStorage
Class OS
Class OSCPUImpl
Class OSDeviceCharacter
Class OSDeviceCharacterBuffered
Class OSDeviceDebug
Class OSEventFlags
Class OSImpl
Class OSLogger
Class OSMutex
Class OSScheduler
Class OSSchedulerImpl
Class OSTask
Class OSTaskIdle
Class OSTimer
Class OSTimerSeconds
Class OSTimerTicks
Class Timer
Class page template
Classes overview
Configuration definitions index
Configuration variables
Debug support
Device drivers
Events
FAQ
Features
Footprint
History
How to install
How to install Eclipse SVN
How to port
How to use
Interrupt service routines
Main Page
Memory management
MyTest
MyTestPage
Portability
Prerequisites
Project backup
Project history
Recommended preferences
SE Ideas
SE SRS guide
SE Test
SRS Guide
Sample Mutex Stress
Samples
Scheduler
Synchronisation events
System Timers
Tasks
Technicalities
The build mechanism
The xCDL Configuration Mechanism
The xCDL software requirements specifications
The µOS++ (micro os plus plus)
The µOS++ SE
Timers
Typedef OSTimerStruct t
Typedef OSTimerTicks t
Using LEDs
Using the AVR32 bootloader
Wiki pages style guide
Wiki style guide
```

In **Special:Export**

Copy/paste the above list, include only the current revision, save as file, rename uOS-i-mw.xml.

## Convert µOS++ Wiki

```
php convert.php --filename=uOS-i-mw.xml --output=uOS-i-output --urlprefix=micro-os-plus/i/ --layout=old-wiki-page
```
