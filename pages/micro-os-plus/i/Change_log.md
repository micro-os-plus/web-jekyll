---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Change_log/
title: Change log
author: Liviu Ionescu

date: 2011-02-19 17:25:35 +0000

---

2010
====

2010-12-31
----------

-   reorganise µOS++ repository
    -   create Eclipse
    -   move system and samples to Eclipse
    -   rename the system/arch/avr folder to avr8
    -   create backup
    -   move www and wiki to backup
    -   create backup/MediaWiki
-   update build settings for project minimal, to be used as a template for all
    -   updated for Eclipse 3.6 with latest plug-ins
    -   toolchain settings harmonised between AVR8 and ARM
-   wiki Prerequisites page updated
    -   detailed instructions on how to install the development environment
    -   detailed ARM projects configuration

2011
====

2011-01-01
----------

-   update code to refer to avr8 instead of avr
    -   update references to folder name avr8
    -   update macro definitions to use \*_AVR8 instead of \*_AVR
-   wiki Prerequisites page split into How to install/How to use/How to port

2011-01-02 - 2011-01-15
-----------------------

-   TBD

2011-01-16
----------

-   team project set WorkspaceTeamProjectSystemAndSampleSets.psf updated

2011-01-18
----------

-   TEMPLATE code added; purpose is to have a code that compiles, as basis for future ports
    -   ../arch/TEMPLATE_ARCH/
    -   ../arch/TEMPLATE_ARCH/TEMPLATE_FAMILY/
    -   ../boards/TEMPLATE_MANUFACTURER/
-   AVR32 code added, based on TEMPLATE
    -   ../arch/avr32/
    -   ../arch/avr32/uc3/
    -   ../boards/Atmel/evk1104/

2011-01-19
----------

-   os_processor_init() with data & bss init ok
-   constructors run for avr32

2011-01-24
----------

-   com.atmel.avr32.core.nature added to make it build for avr32
-   OS_GPIO_PORT_CONFIG_OUTPUT/INPUT added
-   putString_P(PSTR(...)) fixed as alias to putString(), based on OS_INCLUDE_SEPARATE_PROGMEM
-   yield() always added to idle task, this makes cooperative mode automatic
-   critical sections shortened in OSDeviceDebug.cpp
-   program starts at os_reset_handler
-   avr32 contextSave/Restore code included (based on FreeRTOS port)
-   project Eclipse/samples/blinkX3Coop added
-   APP_CONFIG_LED_ISACTIVE_LOW added

2011-01-25
----------

-   OS_GPIO_PORT renamed as OS_GPIO_PIN

2011-01-26
----------

-   in naming conventions, OS_CFGVAR_xxx nad OS_CFGPTR_xxx added
-   avr32 functional system timer, mark second on debugger output
-   project Eclipse/samples/blinkX3BusyWait added
-   avr32 criticalEnter/Exit implemented with SR mask and stack

2011-01-27
----------

-   SysTick_contextHandler distinct from ISR, due to naked nature we cannot have local variables
-   project Eclipse/samples/blinkX3Preemptive added
-   build changed from CDT Internal to GNU Mak
-   scheduler implementation code moved to OSSchedulerImpl

2011-01-28
----------

-   initialisation code moved from avr32 to portable folders
-   CPUstackInit added, to make initialisation possible in C
-   OS_INCLUDE_OSSCHEDULER_TIMER_MARK_SECONDS added
-   project Eclipse/samples/compileAllSources added; the purpose is to test compile as many sources as possible

2011-01-30
----------

-   reset bits as OSResetBits_t
-   conditional OSTimer, conditional preemption
-   all ticks interrupt code collected in OSTimerTicks.cpp
-   implInit() and implAcknowledgeInterrupt() added as private in OSTimerTicks.h
-   common bitbanging code moved to portable/devices/debug/include/DeviceDebugI2C_Inlines.h
-   ledActive code moved to portable folders
-   OSImpl::CPUfetchResetBits() added

2011-02-01
----------

-   project Eclipse/samples/nestedInterrupts added
-   OSScheduler:: schedulerTicks() renamed as \*OSScheduler:: schedulerTick()

2011-02-02
----------

-   OS::busyWaitMicros() added
-   OSScheduler::applicationInterruptTick() added
-   in OSTimerTicks::interruptServiceRoutine(), critical section reduced only to interruptTick() and incrementTicks(); OSScheduler::interruptTick() moved outside
-   OS_INCLUDE_OSTIMER_TICKS_ISR_TEST_LED added
-   OS::busyWaitMillis(unsigned int) prototype changed
-   OSTask::schedulerTick() no longer executed in critical section

2011-02-05
----------

-   be sure interrupts remain disabled before restoring first context
-   isContextSwitchAllowed() written in C; the assembly code uses generic registers
-   os_exception_handler() does soft reset on release
-   OSApplicationImpl added
-   applicationInterruptTick() moved to OSApplicationImpl::interruptTick()
-   requireContextSwitch() renamed isContextSwitchRequired()
-   contextSwitch() renamed performContextSwitch()
-   ISR_ledActiveOn() moved earier in interruptEnter()

2011-02-07
----------

-   buildDateTime[] added to debug greeting
-   avr32 os_exception_handler() extended with description string
-   OS_EXCLUDE_OSTIMERTICKS_PREEMPTION added
-   implAcknowledgeInterrupt() added to the end of the timer ISR

2011-02-08
----------

-   inclusion order changed for OS_Defines.h: first family and then architecture
-   test with critical section in eventWait()
-   implAcknowledgeInterrupt() called at the beginning of the ISR, to give a chance to next interrupt
-   interruptEnter/Exit always save/restore registers, even when preemption is disabled
-   SCALL critical section no longer implemented with stack

2011-02-10
----------

-   typedef OSProgramPtr_t added in arch/avr32/kernel/include/OS_Arch_Defines.h
-   __dso_handle() added for avr32 when the first tests with streams were performed
-   pointers as unsigned int instead of unsigned short in ostream_OSTask.cpp
-   nested interrupt work on Avr32
-   idle task stack size increased for Avr32 tests

2011-02-18
----------

-   OSEventFlags::wait() return type changed to OSReturn_t
