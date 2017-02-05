---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Naming_conventions_(SE)/
title: Naming conventions (SE)
author: Liviu Ionescu

date: 2014-02-22 16:02:04 +0000

---

µOS++ uses the common C++ naming convention, based on the [CamelCase](http://en.wikipedia.org/wiki/CamelCase) convention.

Full words vs. short words
==========================

Whenever possible, it is recommended to use the full words; shortening words in member or member function names does not make the program shorter or faster, but, when used properly, highly increases the readability of the program.

    int initialise(); <- instead of init();
    int configure(); <- instead of config();
    ...
    int delaySeconds; <- instead of delaySec;

Pairs of opposed actions or names
=================================

Antonyms
--------

When defining pairs of opposed actions, use the proper antonyms:

    int startAcquisition();
    int stopAcquisition();
    ...
    int enableInterrupts();
    int disableInterrupts();

Technical terms
---------------

Sometimes, even if the words are not listed in dictionaries as antonyms, the pairs of opposed names are defined by practice:

    // For hardware signals, like chip select
    int assert();
    int deassert();
    ...
    // For synchronisation objects, like mutex
    int acquire();
    int release();

start/stop vs. begin/end
------------------------

When defining actions, prefer **start**/**stop** to **begin**/**end**, since they have a stronger verb-like meaning (end is more an adjective than a verb).

    int startAcquisition(); <- instead of beginAcquisition()
    int stopAcquisition(); <- instead of endAcquisition()

However, when the meaning is adjectival, for example adding determinants to a noun, the pair begin/end is preferred.

    int listBegin; <- instead of listStart
    int listEnd; <- instead of listStop

Class names
===========

Class names start with upper case letters, and are singular names or nominative constructs.

    class Logger;
    class CircularBuffer;

Derived class names
-------------------

Derived class names should extend the base class name, by adding a differentiator at one end.

    class OSDeviceCharacterBuffered : public OSDeviceCharacter
    {
     ...
    };

Abstract base classes
---------------------

When an abstract class is used as a base class for concrete implementations, the word Base can be used in the name, and this name can be skipped in the derived class name:

    class DeviceCharacterBufferedUsart0 : public DeviceCharacterBufferedBase
    {
     ...
    };

Templates
=========

Templates are a great C++ feature, that can be used for many purposes, with the common one being to implement compile time polymorphism.

Template class names
--------------------

Template class names follow the same convention as the class names, but are prefixed with an upper case 'T'.

When instantiated, obviously the instance names drop the initial 'T'.

Template parameter types
------------------------

There are several template parameter types, parameters naming user-defined types (like classes), parameters naming primitive types and constant parameters (usually integer).

Although not required by the language, it is recommended to define parameters naming user-defined types with **class Name_T** and parameters naming primitive types **typename Name_T**.

In class templates, it is recommended to alias the template parameters to new names, and use these new names in code, reserving the template parameters only to define the template syntax.

    template <class GPIO_T, typename Result_T = void, int Bit_T>
    class TPin
    {
    public:
      typedef GPIO_T GPIO;
      typedef Result_T result_t;
      static const int bit = Bit_T;
     ...
    }

    // Explicit instantiation
    template class TPin<GPIOC1>;
    typename class TPin<GPIOC1> Pin;

Member function names
=====================

All member function names start with lower case letters.

Since functions define actions to be performed upon the object, the function name should have the function of a predicate, and usually **start with an imperative verb**.

    int read();

If there are multiple functions that perform similar actions, they should differentiate by the following noun, with the function of a direct complement.

    int readByte();
    long readLong();
    ...
    void readBlock();

The rule of starting with a verb is not absolute, when multiple functions are logically grouped by a common criteria, then predicative groups can be used as function names, and the verb is placed at the end.

    bool eventWaitPrepare(OSEvent_t event);
    OSEventWaitReturn_t eventWaitPerform(void);

    int eventNotify(OSEvent_t event, OSEventWaitReturn_t ret = OSEventWaitReturn::OS_VOID);

However, when such names occur, it might be a sign that the design can be further refined by defining additional objects, for example instead of

    void criticalEnter();
    void criticalExit();

in the new version of µOS++ we use a separate object to manage critical sections, like

    class OSCriticalSection
    {
      void enter(void);
      void exit(void);
    };

In this case the naming convention is again simplified, according to the initial recommendation to use a verb.

Getters/Setters
---------------

As in most object oriented designs, member variables are usually private to the class and external direct access to them is discouraged. Instead, special getters and setters should be defined.

The name should contain exactly the variable name, prefixed with **get** or **set**.

    private:
      int m_count;

    public:
      int getCount(void);
      void setCount(int);

get/set vs. read/write
----------------------

When dealing with hardware, even if the memory mapped registers are seen as class members, it is recommended to prefix member functions with read/write, not get/set, which should be used only for accessing private data members of usual objects.

    hal::cortexm::reg32_t
    readMode(void);

    void
    writeMode(const hal::cortexm::reg32_t value);

Boolean functions
-----------------

Functions that return boolean values should start with boolean verbs, like **is**, **has**, **does**. Depending on the context, past or future tense versions, like **was** or **will** may be more appropriate.

    bool isAvailable();
    bool wasInterrupted();
    bool willBlock();
    bool hasMembers();
    bool doesReturn();  <-- instead of 'bool returns();'

initialise() vs. configure()
----------------------------

In classes implementing device drivers, there are member functions that can be called only before the device is enabled and functions that can be called at any moment.

To mark this distinction, the recommended names should start with **initialise** for functions that are used before the device is enabled and with **configure** for functions that can be used at any moment.

    bool initialiseSomething(void);
    ...
    bool configureBaudRate(BaudRate_t baudRate);
    bool configureHighSpeed(void);

It is recommended to use the full words, shortening initialise() to init() or configure() to config() does not make the program shorter or faster.

set() vs. configure()
---------------------

As mentioned before, setMember() generally should be used as a setter for a class member variable. When dealing with device drivers, changing the state of the device is in fact a configuration change, so it is more appropriate to name functions like configureSomething().

Member variables names
======================

Similar to member functions, all member variables names start with lower case letters.

Since member variables define characteristics of the object, the member variables name should have the function of an attribute, and usually **start with a noun**. Boolean status variables naming convention should follow the boolean function naming convention, i.e. start with a verb like **is**, **has**, **does**, at present/past/future tense.

Private member variables names
------------------------------

As the most common type of member variable names, the private member variables should be prefixed with **m_**.

    private:
      int m_count;
      char* m_bufferAddress;
      int m_bufferSize;

      bool m_isRunning;
      bool m_wasCancelled;

Static member variables names
-----------------------------

Static member variables should be prefixed with **ms_**.

    static OSThread* volatile ms_pThreadRunning;

Public member names
-------------------

As an exception to the above rules, some globally available member variables, like those in the global **os** or **app** objects, can be named without the **m_** prefix.

    class OS : public OSImpl
    {
    public:
      ...
      OSScheduler sched;
      ...
    };

Array members
-------------

For a better code readability, it is recommended to name array members or pointers to arrays explicitly, like this:

    OSTask** m_pWaitingTasksArray;
    unsigned short m_waitingTasksArraySize;

const & volatile
================

The rules for using these keywords are sometimes tricky, and the easiest to remember is *const makes a constant whatever is on its left*:

     int* const p1; // constant pointer to int
     const int* p2; // pointer to an int constant
     const int* const p3; // constant pointer to an int constant

Systematic use of the above rule would put the type of scalars at the left of const, which is not that usual:

     int const n; // constant integer

So, for scalars and for constants, it is also acceptable to use the more common order:

     const int n;
     static const int CONST = 7;

Constants
=========

Constant names are all upper case, with words separated by underscores, as in most C programs.

Although in C/C++ it is possible to define constants using the preprocessor, it is recommended to use them only for project configuration variables, otherwise use only typed definitions, and the compiler might catch some errors.

For individual definitions, the recommended way is to use **constexpr**.

    constexpr threadId_t NO_ID = 0xFF;

For definitions inside a class, use **static constexpr** members.

    static constexpr OSReturn_t OS_OK = 0;

Depending on the specific scope, if the constants are to be used only inside the given class, they can be made private.

Constants can be grouped in separated classes, like the system OSReturn class, that groups together various return values, although enums would be probably more appropriate.

For group of constants, the recommended method is to use [class enumerations]({{ site.baseurl }}/micro-os-plus/ii/Naming_conventions_(SE)/#enumeration-definitions).

static constexpr vs. constexpr static
-------------------------------------

The recommended order is **static constexpr**.

Type definitions
================

For a better code maintainability, where needed, it is recommended to use type definitions instead of direct C/C++ scalar types.

Scalar type definitions should start with lower case letters and end with **_t**; class aliases should follow the usual naming convention of class names.

Language type definition
------------------------

### Explicit size definitions

These are mainly the definitions from <stdint.h>

-   **uint8_t**, **int8_t**
-   **uint16_t**, **int16_t**
-   **uint32_t**, **int32_t**

### Explicit size versus platform size

Once we introduce the above definitions, the usual question is when to use **int** versus **int8_t**/**int16_t**/**int32_t** or **uint_t** versus **uint8_t**/**uint16_t**/**uint32_t**?

Probably there is no single rule, but several usage cases. For applications that depend on a specific size, regardless of the platform, it is recommended to use the explicit size type definitions. Otherwise, using the platform native size may be more efficient in some cases. For example loop counts are usually better compiled when the the platform register size is used, so even if you know that the counter is small, using uint8_t instead of unsigned int may not produce a shorter/faster code (on the contrary).

As a general rule, when defining types that should match a memory mapped structure, or a packet header, or some other fixed size structure, you obviously need to use the explicit size definitions. For the rest, platform size definitions might be preferred.

### Signed versus unsigned

Another usual question is when to use int (signed) versus unsigned int. The answer is obvious, if the variable you want to represent can take negative values, then use signed variables. Otherwise, use unsigned variables.

One single note: sometimes, although the variable itself can take only positive values, it might be needed to also multiplex error codes on the same variable, and, in order to differentiate them, error cases are defined as impossible/illegal negative values.

Although an universal solution is not enforced, it is preferable NOT to return error codes multiplexed with valid content; instead, use a separate **OSReturn_t** for errors, and leave the value unaffected by error processing.

User type definitions
---------------------

These are custom definitions, made to increase code readability and maintainability. Preferably they should rely on the previous type definitions.

    typedef uint8_t threadPriority_t;

If the new type can be an alias, that does not introduce a new type definition, the C++11 syntax is:

    using threadPriority_t = uint8_t threadPriority_t;

Enumeration definitions
-----------------------

C++11 solved the old C enumeration problem and introduced strongly typed and scoped enumerations (**enum class**), so usually there is no need to use embedded classes with constants.

    typedef uint32_t mode_t;

    enum class Mode : mode_t
    {
        Input = 0, Output = 1, Alternate = 2, Analog = 3
    };

    static const mode_t MODE_MASK = 0x3;
    ...
    someFunction(Mode::Input);

Structure definitions
---------------------

Usually, structure definitions should be avoided, and be replaced by class definitions.

However, if for any reasons, struct definitions are needed, it is recommended to define both the struct name and the type, using the following syntax:

    typedef struct Region_s
    {
      regionAddress_t address;
      regionSize_t size;
    } Region;

Aliases to classes
------------------

For a more uniform look, type names used as aliases to class names should not end with **_t**.

    class MyClass
    {
    public:
      regionAddress_t address;
      regionSize_t size;
    };

    typedef MyClass MyClassAlias;

or even better, if the alias does not need to introduce a new type:

    using MyClassAlias = MyClass;

Measuring units
===============

Whenever not absolutely obvious, append the measuring units to the member variable or function name.

    int busFrequencyHz;
    int delaySeconds;
    int delayMilliseconds;
    int delayMicroseconds;
    int lengthMetres;
    int lengthCentimetres;
    int lengthMillimetres;

If possible, use the full unit names.

Use of underscore
=================

Normally under camelCase rules, the underscore is no longer necessary. However, in special cases the underscore can be used as a class specifier separator.

    inline static void
    ledActiveOn(void);

    inline static void
    ISR_ledActiveOn(void);

XCDL configuration definitions
==============================

There are several types of configuration definitions:

-   conditional compilation definitions
-   value definitions

Conditional compilation definitions
-----------------------------------

These are the definitions used to select various components to compile.

By convention, they all start with **OS_INCLUDE_** and are followed by the path of the component.

Examples:

-   OS_INCLUDE_HAL_ARCHITECTURE_SYNTHETIC_POSIX
-   OS_INCLUDE_HAL_PLATFORM_SYNTHETIC_OSX
-   OS_INCLUDE_PORTABLE_DIAGNOSTICS_TRACE

Value definitions
-----------------

These are the definitions used to configure various values at compile time.

By convention, they all start with the value type:

-   **OS_STRING_**
-   **OS_INTEGER_**

Examples:

-   OS_INTEGER_CORE_SCHEDULER_MAXUSERTHREADS
-   OS_STRING_CORE_SCHEDULER_CUSTOM_HEADER

PATH definitions
----------------

These special definitions are used to enter strings that contain file paths, for example for custom preprocessor includes.

By convention, they all start with:

-   **OS_PATH_**

Examples:

-   OS_PATH_HAL_PLATFORM_PLATFORMIMPLEMENTATION

Platform dependencies
=====================

If some parts of the code are platform dependent, test the following preprocessor definitions:

    #if defined(__APPLE__)
    #if defined(__linux__)
    #if defined(__x86_64__)

To check the compiler:

    #if defined (__GNUC__)
    #if __GNUC__ == 4 && __GNUC_MINOR__ == 7
    #if defined(__clang__)

To check the size of the pointer:

    #if __SIZEOF_POINTER__ == __SIZEOF_INT__
    #elif __SIZEOF_POINTER__ == __SIZEOF_LONG__
    #elif __SIZEOF_POINTER__ == __SIZEOF_LONG_LONG__

To check if there are no **long long** variables:

    #if !defined(__SIZEOF_LONG_LONG)

To check if the compiling unit is C++:

    #if defined (__cplusplus)

To check if the compiling unit is an assembly file:

    #if defined(__ASSEMBLER__)

To check if optimisation is enabled (more than -O0):

    #if defined(__OPTIMIZE__)

To check if optimisation for size is enabled (-Os):

    #if defined(__OPTIMIZE_SIZE__)

To check if no inlines are enabled:

    #if defined(__NO_INLINE__)

To see the GCC defines use:

    g++ -dM -E - < /dev/null
    clang++ -dM -E - < /dev/null

ARM Cortex-M
------------

When compiling Cortex-M applications, GCC 4.8 provides the following built-in definitions.

### ARM Cortex-M0/M0+

    $ ./arm-none-eabi-gcc -mcpu=cortex-m0 -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex' | sort
    #define __ARMEL__ 1
    #define __ARM_ARCH 6
    #define __ARM_ARCH_6M__ 1
    #define __ARM_ARCH_ISA_THUMB 1
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 32
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.8.3 20131129 (release) [ARM/embedded-4_8-branch revision 205641]"
    #define __arm__ 1
    #define __thumb__ 1

### ARM Cortex-M3

    $ ./arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex' | sort
    #define __ARMEL__ 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7M__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 32
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.8.3 20131129 (release) [ARM/embedded-4_8-branch revision 205641]"
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1

### ARM Cortex-M4

    $ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex' | sort
    #define __ARMEL__ 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7EM__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_DSP 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_SIMD32 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 12
    #define __ARM_NEON_FP 4
    #define __ARM_PCS 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 32
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.8.3 20131129 (release) [ARM/embedded-4_8-branch revision 205641]"
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1

    $ ./arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -E -dM - < /dev/null | egrep -i 'thumb|arm|cortex' | sort
    #define __ARMEL__ 1
    #define __ARM_ARCH 7
    #define __ARM_ARCH_7EM__ 1
    #define __ARM_ARCH_EXT_IDIV__ 1
    #define __ARM_ARCH_ISA_THUMB 2
    #define __ARM_ARCH_PROFILE 77
    #define __ARM_EABI__ 1
    #define __ARM_FEATURE_CLZ 1
    #define __ARM_FEATURE_DSP 1
    #define __ARM_FEATURE_FMA 1
    #define __ARM_FEATURE_LDREX 7
    #define __ARM_FEATURE_QBIT 1
    #define __ARM_FEATURE_SAT 1
    #define __ARM_FEATURE_SIMD32 1
    #define __ARM_FEATURE_UNALIGNED 1
    #define __ARM_FP 4
    #define __ARM_NEON_FP 4
    #define __ARM_PCS_VFP 1
    #define __ARM_SIZEOF_MINIMAL_ENUM 1
    #define __ARM_SIZEOF_WCHAR_T 32
    #define __THUMBEL__ 1
    #define __THUMB_INTERWORK__ 1
    #define __VERSION__ "4.8.3 20131129 (release) [ARM/embedded-4_8-branch revision 205641]"
    #define __arm__ 1
    #define __thumb2__ 1
    #define __thumb__ 1
