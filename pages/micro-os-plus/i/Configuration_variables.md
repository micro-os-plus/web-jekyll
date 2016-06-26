---
layout: old-wiki-page
permalink: /micro-os-plus/i/Configuration_variables/
title: Configuration variables
author: Liviu Ionescu

date: 2011-08-10 11:55:46 +0000

---

As a highly configurable system, µOS++ makes extensive use of preprocessor variables and conditional compilation. In fact it is highly recommended that all decision that can be made at build time, to be done with configuration variables.

There are many types of configuration variables, some defined by the application and needed to configure various components of the system, and some computed by the system and presented to the application.

From another point of view, some variables are used to configure release code, and others are used to define debug specific configurations.

Debug variables
===============

All debug build configurations should include the DEBUG=1 definition, added by the Eclipse CDT managed builder to all compile steps:

    g++ ... -DDEBUG=1

This definition is used for conditional compiling as usual:

    #if defined(DEBUG)
    ...
    #endif /* defined(DEBUG) */

Notice: Although the actual value of the DEBUG variable is not relevant, since only the existence of the definition is checked, it is recommended to avoid empty definitions and always use the value of 1.

Enabling more specific configurations is done with more specific definitions. The specific condition may apply to a group of classes, to a certain class or to a certain method of a class. In addition to the condition, the convention to name these definitions may hierarchically include the class name and eventually the method name:

    #define OS_DEBUG_MYCONDITION                            (1)
    #define OS_DEBUG_MYCLASS                                (1)
    #define OS_DEBUG_MYCLASS_MYCONDITION                (1)
    #define OS_DEBUG_MYCLASS_MYMETHOD                   (1)
    #define OS_DEBUG_MYCLASS_MYMETHOD_MYCONDITION   (1)

The name MYCLASS is the full class name, converted to uppercase. Similarly MYMETHOD is the full name of the method where the definition applies.

Example of such definitions are

    #define OS_DEBUG_CONSTRUCTORS           (1)
    #define OS_DEBUG_OSSCHEDULER_START      (1)

When checking for the presence of such definitions, it is recommended to combine the specific definitions with the generic definition of DEBUG:

    #if defined(DEBUG) && defined(OS_DEBUG_CONSTRUCTORS)
    ...
    #endif /* defined(DEBUG) && defined(OS_DEBUG_CONSTRUCTORS) */

Variables provided by the system
================================

These are variables intended to help the programmer taylor the build according to some generally agreed criteria. For example, based on the board definition, passed to the build mechanism as a compile option like "-DOS_CONFIG_BOARD_STK525=1", the system exposes definitions of the architecture, family and variant of the processor used.

    #define OS_CONFIG_ARCH_AVR                  1
    #define OS_CONFIG_FAMILY_AT90USB                1
    #define OS_CONFIG_VARIANT_AT90USB1287       1
    #define OS_CONFIG_BOARD_STK525              1

These definitions can be used later for conditional compilation.

Conditional compilation definitions
===================================

Most of these variables have (or should have) reasonable definitions, so not defining them includes only the core code with minimal functionality.

For including additional code, use the OS_INCLUDE_xxx definitions.

Similarly, if the default functionality is not needed, parts of the source code can be excluded by using OS_EXCLUDE_xxx.

    // conditionally include code
    #define OS_INCLUDE_xxx          (1)

    #if defined(OS_INCLUDE_xxx)
    ...
    #endif /* defined(OS_INCLUDE_xxx) */

    // conditionally exclude code
    #define OS_EXCLUDE_xxx          (1)

    #if !defined(OS_EXCLUDE_xxx)
    ...
    #endif /* !defined(OS_EXCLUDE_xxx) */

The scope of the inclusion/exclusion can be an entire class, a variable, a method, or part of a method:

    #define OS_INCLUDE_MYCLASS                              (1)
    #define OS_INCLUDE_MYCLASS_MYVARIABLE                   (1)
    #define OS_INCLUDE_MYCLASS_MYMETHOD                 (1)
    #define OS_INCLUDE_MYCLASS_MYMETHOD_MYCONDITION (1)

    #define OS_EXCLUDE_MYCLASS                              (1)
    #define OS_EXCLUDE_MYCLASS_MYVARIABLE               (1)
    #define OS_EXCLUDE_MYCLASS_MYMETHOD                 (1)
    #define OS_EXCLUDE_MYCLASS_MYMETHOD_MYCONDITION (1)

Conditional inclusion/exclusion of classes
------------------------------------------

    // conditionally include class
    #define OS_INCLUDE_MYCLASS                              (1)

    #if defined(OS_INCLUDE_MYCLASS)
    class MyClass
    {
     ...
    }
    #endif /* defined(OS_INCLUDE_MYCLASS) */

    // conditionally exclude class
    #define OS_INCLUDE_MYCLASS                              (1)

    #if !defined(OS_EXCLUDE_MYCLASS)
    class MyClass
    {
     ...
    }
    #endif /* !defined(OS_EXCLUDE_MYCLASS) */

Conditional inclusion/exclusion of class member variables
---------------------------------------------------------

    // conditionally include class member variable
    #define OS_INCLUDE_MYCLASS_MYVARIABLE                   (1)

    class MyClass
    {
    ...
    #if defined(OS_INCLUDE_MYCLASS_MYVARIABLE)
    myType_t m_myVariable;
    #endif /* defined(OS_INCLUDE_MYCLASS_MYVARIABLE) */
    ...
    }

    // conditionally exclude class member variable
    #define OS_EXCLUDE_MYCLASS_MYVARIABLE                   (1)

    class MyClass
    {
    ...
    #if !defined(OS_EXCLUDE_MYCLASS_MYVARIABLE)
    myType_t m_myVariable;
    #endif /* !defined(OS_EXCLUDE_MYCLASS_MYVARIABLE) */
    ...
    }

Conditional inclusion/exclusion of class methods
------------------------------------------------

This feature is useful for virtual methods, since they are referred from a virtual method table; exclusion for regular methods is not of great concern, since the linker is configured to automatically exclude methods not referred.

    // conditionally include class method
    #define OS_INCLUDE_MYCLASS_MYMETHOD                 (1)

    #if defined(OS_INCLUDE_MYCLASS_MYMETHOD)
    MyClass::myMethod()
    {
    ...
    }
    #endif /* defined(OS_INCLUDE_MYCLASS_MYMETHOD) */

    // conditionally exclude class method
    #define OS_EXCLUDE_MYCLASS_MYMETHOD                 (1)

    #if !defined(OS_EXCLUDE_MYCLASS_MYMETHOD)
    MyClass::myMethod()
    {
    ...
    }
    #endif /* !defined(OS_EXCLUDE_MYCLASS_MYMETHOD) */

Conditional exclusion of ISR preemption
---------------------------------------

By default, interrupt service routines include preemption code. To selectively exclude the preemption code, it is recommended to use the following definitions:


    #define OS_EXCLUDE_MYCLASS_ISR_PREEMPTION                   (1)
    #define OS_EXCLUDE_MYCLASS_MYCONDITION_ISR_PREEMPTION   (1)

Other conditional exclusion variables
-------------------------------------

Another general example of variables are:


    #define OS_EXCLUDE_MYCLASS_USE_SOMETHING                    (1)
    #define OS_EXCLUDE_MYCLASS_MYMETHOD_USE_SOMETHING   (1)

Inline code generation
======================

It is possible to explicitly ask the compiler to inline some of the class methods.

    #define OS_INLINE_MYCLASS_MYMETHOD            (1)
    #define OS_INLINE_MYCLASS_MYCONDITION          (1)

Definitions used to configure the system
========================================

There are multiple usages of these variables:

-   define sizes of various arrays
-   define constant initialisation values for variables
-   define processor registers

The types of these variables are encoded in the name.

Most of these variables have (or should have) reasonable defaults.

As for INLINE/INCLUDE/EXCLUDE definitions, each variable should be as specific as necessary. If it is used to configure a specific class, the class name should be included. Similarly for methods, variables, etc, as presented above.

The usage of the configuration variables should always provide defaults for the case when the definition is missing, for example:

    #if defined(OS_CFGBOOL_STATUSLED_ISACTIVE_LOW) && (OS_CFGBOOL_STATUSLED_ISACTIVE_LOW)
    typedef LedActiveLow StatusLed_t;
    #else
    typedef LedActiveHigh StatusLed_t;
    #endif

Booleans
--------

    #define OS_CFGBOOL_xxx      (true)

The boolean true/false values.

Integers
--------

    #define OS_CFGINT_xxx       (1)
    #define OS_CFGINT8_xxx      (1)
    #define OS_CFGINT16_xxx     (1)
    #define OS_CFGLONG_xxx      (1)

All integer values. If the value is assigned to a variable/register with a known size, and it is useful to remind it to the programmer, use the INT8/INT16 variants.

Hardware registers
------------------

    #define OS_CFGREG_xxx       (hardware register)

Memory mapped hardware registers also fit here.

GPIO pins
---------

    #define OS_CFGPIN_xxx_GPIO_PIN      (pin number)
    #define OS_CFGPIN_xxx_PORT_PIN      (pin number)

An integer value, defining the GPIO pin, either uniquely or within a port.

Variables
---------

    #define OS_CFGVAR_xxx       (variable)

The name of a variable.

Pointer to variables (addresses)
--------------------------------

    #define OS_CFGPTR_xxx       (&variable)

The address of a variable or of a memory location.

Strings
-------

    #define OS_CFGSTR_xxx       "Today " __DATE__

Generic strings. According to C/C++ rules, may be a sequence of strings to be concatenated.

Generic definitions
-------------------

    #define OS_CONFIG_xxx       (1)

To be used for anything else, that does not fit the above definitions. However, if such cases occur frequently, it might be worth defining new categories of variables.

Specific definitions
--------------------

Since these variables usually refer to a specific class or variable, it is recommended to explicitly append the name of the class/variable.

    #define OS_CFGINT_OSSCHEDULER_TASKS_ARRAY_SIZE                      (3)
    #define OS_CFGLONG_OSCILLATOR_HZ                        (16000000UL)
    #define OS_CFGINT_OSTIMERTICKS_RATE_HZ                          (1000)

Arrays
------

When variables define array sizes, the name should be suffixed with _ARRAY_SIZE.

Measurement units
-----------------

Where needed, the units of the variable should be explicitly defined. Examples of such units are:

-   HZ
-   TICKS
-   SECONDS

Formatting
==========

\#if defined() instead of \#ifdef
---------------------------------

It is recommended to use the new syntax, **\#if defined()** instead of the original **\#ifdef** syntax.

The major advantage is that the new syntax allows to check multiple variables, by using logical expressions. For example:

    #if defined(DEBUG) && defined(OS_DEBUG_CONSTRUCTORS)

Parenthesis
-----------

When the definition values contain expressions, it is almost mandatory to brace them with parenthesis, to avoid possible surprises when evaluating the expressions.

For uniformity, it is also recommended to brace all values with parenthesis, even as single values.

Application configuration variables
===================================

Application definitions are variables used to configure the application classes, usually definitions entered in **App_Defines.h**.

Although their names have no impact on system files, for consistency it is still recommended to use a similar naming convention, except to prefix the definitions with **APP_** instead of **OS_**.

Example of application variables are the versioning variables:

    // Application versioning and greeting definitions
    // More definitions will be computed in uOS.h

    #define APP_CFGSTR_APPLICATION_NAME                     "minimal"
    #define APP_CFGSTR_APPLICATION_MANUFACTURER             "AVI"

    // Notice: do not use parenthesis! (the values will be stringified)
    #define APP_CFGINT_VERSION_MAJOR                        1
    #define APP_CFGINT_VERSION_MINOR                        1
    #define APP_CFGINT_VERSION_REVISION                     1630

Local configuration variables
=============================

Local definitions are variables used only in a specific source file.

Although their names have no impact on other files, it is still recommended to use a similar naming convention, except the OS_ prefix that can be dropped.
