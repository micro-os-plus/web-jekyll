---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Naming_conventions/
title: Naming conventions
author: Liviu Ionescu

date: 2014-03-15 10:15:51 +0000

---

µOS++ uses the common C++ naming convention, based on the [CamelCase](http://en.wikipedia.org/wiki/CamelCase) convention.

Word order
==========

It is recommended to preserve the English word order, and avoid creating artificial compound words by rigidly using prefixes/suffixes.

For grouping related names together, use namespaces or classes.

Type definitions
================

For a better code readability and maintainability, where needed, it is recommended to use type definitions instead of direct C/C++ scalar types.

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

If the new type can be an alias, that does not introduce a new type definition, the C++11 syntax is:

    using threadPriority_t = uint8_t;

using vs typedef
----------------

Unless required by special cases, define aliases to types with **using** instead of **typedef**.

Enumeration definitions
-----------------------

C++11 solved the old C enumeration problem and introduced strongly typed and scoped enumerations (`enum class`), so usually there is no need to use embedded classes with constants.

    using mode_t = uint32_t;

    enum class Mode : mode_t
    {
        Input = 0, Output = 1, Alternate = 2, Analog = 3, MAX = Analog
    };

    static constexpr mode_t MODE_MASK = 0x3;
    ...
    doSomething(Mode::Input, MODE_MASK);

Structure definitions
---------------------

Since in C++ structures are public classes, usually, structure definitions should be avoided, and be replaced by class definitions.

However, in C, if struct definitions are needed, it is recommended to define both the struct name and the type, using the following syntax:

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

    using MyClassAlias = MyClass;

Full words vs. short words
==========================

Whenever possible, it is recommended to use the full words; shortening words in member or member function names does not make the program shorter or faster, but, when used properly, highly increases the readability of the program.

    int initialise(); <- instead of init();
    int configure(); <- instead of config();
    ...
    int delaySeconds; <- instead of delaySec;

Class names
===========

Class names start with upper case letters, and are singular names or nominative constructs.

    class Logger;
    class CircularBuffer;

Derived class names
-------------------

Derived class names should extend the base class name, usually by appending (sometimes by prepending) a differentiator.

    class BufferedCharacterDevice : public CharacterDevice
    {
     ...
    };

Base classes
------------

When a base class is used, the word Base can be appended to the name, and this name can be skipped in the derived class name:

    class Usart0BufferedCharacterDevice : public BufferedCharacterDeviceBase
    {
     ...
    };

Abstract base classes
---------------------

When an abstract class is used as a base class for concrete implementations, the word Abstract can be prepended to the name, and this name can be skipped in the derived class name:

    class Usart1BufferedCharacterDevice : public AbstractBufferedCharacterDevice
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

Although not required by the language, it is recommended to define parameters naming user-defined types with **typename Name_T** and primitive types with **typename name_T**.

In class templates, it is recommended to locally alias the template parameters to new names, and use these new names in code, reserving the template parameters only to define the template syntax.

    template <typename Gpio_T, typename result_T = void, int BIT_T>
    class TPin
    {
      using Gpio = Gpio_T; // class name, start with capital letter
      using result_t = result_T; // primitive type, lower-case, end with _t
      static constexpr int BIT = BIT_T; // constant, all upper-case

    public:
     ...
    }

Explicit instantiation
----------------------

For templates that need to generate code, it is recommended to explicitly instantiate them in a single place, in a .cpp file.

    // Explicit instantiation
    template class TPin<GpioC1>;

Aliases
-------

To improve readability, define shorter, more specific, names for templates:

    using GpioPortD = stm32f4::TConstantGpioPort<gpio::PortId::D>;

Parametrised aliases
--------------------

To improve readability, define shorter, more specific, names for complex templates with parameters:

     template<gpio::PortBitId Pin_T>
        using GpioPinD = stm32f4::TConstantGpioPin<GpioPortD, Pin_T>;

Member function names
=====================

All member function names start with lower case letters.

Since functions define actions to be performed upon the object, the function name should have the function of a predicate, and usually **start with an imperative verb**.

    int read();

If there are multiple functions that perform similar actions, and the difference is in the return type, not in the list of parameters, they should differentiate by appending another noun, with the function of a direct complement.

    int readByte();
    long readLong();
    ...
    void readBlock();

The rule of starting with a verb is not absolute, when multiple functions are logically grouped by a common criteria, then predicative groups can be used as function names, and the verb can be placed at the end, but generally the usual word order is preferred.

    bool eventWaitPrepare(OSEvent_t event);
    OSEventWaitReturn_t eventWaitPerform(void);

    int eventNotify(OSEvent_t event, OSEventWaitReturn_t ret = OSEventWaitReturn::OS_VOID);

However, when such names occur, it might be a sign that the design can be further refined by defining additional objects, for example instead of

    void criticalEnter();
    void criticalExit();

a separate class to manage critical sections can be defined:

    class CriticalSection
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
      int count;

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

powerUp() / powerDown()
-----------------------

In low power applications, where it is necessary to power up/down various devices separately, use these two function names, instead of initialise() or similar names.

Member variables names
======================

Similar to member functions, all member variables names start with lower case letters.

Since member variables define characteristics of the object, the member variables name should have the function of an attribute, and usually **start with a noun**. Boolean status variables naming convention should follow the boolean function naming convention, i.e. start with a verb like **is**, **has**, **does**, at present/past/future tense.

There is no need to prefix private or static member variables with **m_** or **ms_**

Explicit use of **this**
------------------------

To clearly mark the use of member variables, it is recommended to explicitly use the this pointer:

      this->count = 0;

Private member variables names
------------------------------

    private:
      int count;
      char* bufferAddress;
      int bufferSize;

      bool isRunning;
      bool wasCancelled;

Static member variables names
-----------------------------

    static OSThread* volatile pThreadRunning;

Public member names
-------------------

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

    OSTask** pWaitingTasksArray;
    unsigned short waitingTasksArraySize;

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
    void makeActive();  // assert
    void makeInactive(); // deassert
    ...
    // For synchronisation objects, like mutex
    void acquire();
    void release();

Note: do not use **assert()** since this is the name of a standard macro.

start/stop vs. begin/end
------------------------

When defining actions, prefer **start**/**stop** to **begin**/**end**, since they have a stronger verb-like meaning (end is more an adjective than a verb).

    int startAcquisition(); <- instead of beginAcquisition()
    int stopAcquisition(); <- instead of endAcquisition()

However, when the meaning is adjectival, for example adding determinants to a noun, the pair begin/end is preferred.

    int listBegin; <- instead of listStart
    int listEnd; <- instead of listStop

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

For group of constants, the recommended method is to use [class enumerations]({{ site.baseurl }}/micro-os-plus/ii/Naming_conventions/#enumeration-definitions "wikilink").

static constexpr vs. constexpr static
-------------------------------------

The recommended order is **static constexpr**.

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

By convention, they all start with `OS_INCLUDE_` and are followed by the path of the component.

Examples:

-   `OS_INCLUDE_HAL_ARCHITECTURE_SYNTHETIC_POSIX`
-   `OS_INCLUDE_HAL_PLATFORM_SYNTHETIC_OSX`
-   `OS_INCLUDE_PORTABLE_DIAGNOSTICS_TRACE`

Value definitions
-----------------

These are the definitions used to configure various values at compile time.

By convention, they all start with the value type:

-   `OS_STRING_`
-   `OS_INTEGER_`

Examples:

-   `OS_INTEGER_CORE_SCHEDULER_MAXUSERTHREADS`
-   `OS_STRING_CORE_SCHEDULER_CUSTOM_HEADER`

PATH definitions
----------------

These special definitions are used to enter strings that contain file paths, for example for custom preprocessor includes.

By convention, they all start with:

-   `OS_PATH_`

Examples:

-   `OS_PATH_HAL_PLATFORM_PLATFORMIMPLEMENTATION`
