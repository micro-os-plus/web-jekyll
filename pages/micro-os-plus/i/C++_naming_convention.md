---
layout: old-wiki-page
permalink: /micro-os-plus/i/C++_naming_convention/
title: C++ naming convention
author: Liviu Ionescu

date: 2011-07-30 11:14:45 +0000

---

µOS++ uses the common C++ naming convention, based on the [CamelCase](http://en.wikipedia.org/wiki/CamelCase) convention.

Full words vs. short words
==========================

Whenever possible, it is recommended to use the full words; shortening words in member or method names does not make the program shorter or faster, but, when used properly, highly increases the readability of the program.

      int initialise(); <- instead of init();
      int configure(); <- instead of config();
      ..
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

Class names start with upper case letters.

    class Logger;
    class CircularBuffer;

Derived class names
-------------------

Derived class names should extend the base class name, by adding a differentiator at the end.

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

Method names
============

All method names start with lower case letters.

Since methods define actions to be performed upon the object, the method name should have the function of a predicate, and usually **start with an imperative verb**.

      int read();

If there are multiple methods that perform similar functions, they should differentiate by the following noun, with the function of a direct complement.

      int readByte();
      long readLong();
      ...
      void readBlock();

The rule of starting with a verb is not absolute, when multiple methods are logically grouped by a common criteria, then predicative groups can be used as method names, and the verb is placed at the end.

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

Boolean methods
---------------

Methods that return boolean values should start with boolean verbs, like **is**, **has**, **does**. Depending on the context, past or future tense versions, like **was** or **will** may be more appropriate.

      bool isAvailable();
      bool wasInterrupted();
      bool willBlock();
      bool hasMembers();
      bool doesReturn();  <-- instead of 'bool returns();'

initialise() vs. configure()
----------------------------

In classes implementing device drivers, there are methods that can be called only before the device is enabled and methods that can be called at any moment.

To mark this distinction, the recommended names should start with **initialise** for methods that are used before the device is enabled and with **configure** for methods that can be used at any moment.

      bool initialiseSomething(void);
      ...
      bool configureBaudRate(BaudRate_t baudRate);
      bool configureHighSpeed(void);

It is recommended to use the full words, shortening initialise() to init() or configure() to config() does not make the program shorter or faster.

set() vs. configure()
---------------------

As mentioned before, setMember() generally should be used as a setter for a class member variable. When dealing with device drivers, changing the state of the device is in fact a configuration change, so it is more appropriate to name methods like configureSomething().

Member variables names
======================

Similar to methods, all member variables names start with lower case letters.

Since member variables define characteristics of the object, the member variables name should have the function of an attribute, and usually **start with a noun**. Boolean status variables naming convention should follow the boolean method naming convention, i.e. start with a verb like **is**, **has**, **does**, at present/past/future tense.

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

Constant members
================

Constant names are all upper case, with words separated by underscores, as in most C programs.

Although in C/C++ it is possible to define constants using the preprocessor, it is recommended to use them only for project configuration variables.

Another possibility would be the use of the C **enum** statement, but the C++ recommended way is to use static **const members**. The main advantage is that these constants are typed, and the compiler can catch some errors.

      static const OSReturn_t OS_OK = 0;

Depending on the specific scope, if the constants are to be used only inside the given class, they can be made private. where needed,

Constants can be grouped in separated classes, like the system OSReturn class, that groups together various return values.

Type definitions
================

For a better code maintainability, where needed, it is recommended to use type definitions instead of direct C/C++ scalar types.

Type definitions must end with **_t**.

As a general rule, it is recommended that all user type definitions should start with an upper case letter, while language type definitions start with lower case letters.

Language type definition
------------------------

### Explicit size definitions

These are mainly the definitions from <stdint.h>

-   **uint8_t**, **int8_t**
-   **uint16_t**, **int16_t**
-   **uint32_t**, **int32_t**

### Platform size definitions

In addition, we also recommend the following definitions:

-   **uchar_t**
-   **uint_t**
-   **ulong_t**

Although they are physically represented by identical implementations, **uchar_t** should not be messed with **uint8_t**. The first definition (uchar_t) should be used when dealing with text (characters or strings) and the second when dealing with numerical values.

### Explicit size versus platform size

Once we introduce the above definitions, the usual question is when to use **int** versus **int8_t**/**int16_t**/**int32_t** or **uint_t** versus **uint8_t**/**uint16_t**/**uint32_t**?

Probably there is no single rule, but several usage cases. For applications that depend on a specific size, regardless of the platform, it is recommended to use the explicit size type definitions. Otherwise, using the platform native size may be more efficient in some cases. For example loop counts are usually better compiled when the the platform register size is used, so even if you know that the counter is small, using uint8_t instead of uint_t may not produce a shorter/faster code (on the contrary).

As a general rule, when defining types that should match a memory mapped structure, or a packet header, or some other fixed size structure, you obviously need to use the explicit size definitions. For the rest, platform size definitions might be preferred.

### Signed versus unsigned

Another usual question is when to use int (signed) versus uint_t (unsigned). The answer is obvious, if the variable you want to represent can take negative values, then use signed variables. Otherwise, use unsigned variables.

One single note: sometimes, although the variable itself can take only positive values, it might be needed to also multiplex error codes on the same variable, and, in order to differentiate them, error cases are defined as impossible/illegal negative values.

Although an universal solution is not enforced, it is preferable NOT to return error codes multiplexed with valid content; instead, use a separate **OSReturn_t** for errors, and leave the value unaffected by error processing.

User type definitions
---------------------

These are custom definitions, made to increase code readability and maintainability. Preferably they should rely on the previous type definitions.

    typedef uint8_t OSThreadPriority_t;

Enumeration definitions
-----------------------

When defining enumerations, it is recommended to define both the key and the type, using the following syntax:

    typedef enum Channel_e
      {
        channelA = 0,
        channelB = 1
      } Channel_t;
    ...
    someMethod(channelA);

However, since in the current language definition, enumerations are not typed, it is recommended to use separate a classes with constant members.

    typedef uint8_t Channel_t;

    class Channel
    {
      const static Channel_t A = 0;
      const static Channel_t B = 1;
    };
    ...
    someMethod(Channel::A);

Structure definitions
---------------------

Usually, structure definitions should be avoided, and be replaced by class definitions.

However, if for any reasons, struct definitions are needed, it is recommended to define both the struct name and the type, using the following syntax:

    typedef struct Region_s
      {
        RegionAddress_t address;
        RegionSize_t size;
      } Region_t;

Measuring units
===============

Whenever not absolutely obvious, append the measuring units to the member or method name.

    int busFrequencyHz;
    int delaySeconds;
    int delayMilliseconds;
    int delayMicroseconds;
    int lengthMetres;
    int lengthCentimetres;
    int lengthMillimetres;

If possible, use the full unit names;

Use of underscore
=================

Normally under camelCase rules, the underscore is no longer necessary. However, in special cases the underscore can be used as a class specifier.

      inline static void ledActiveOn(void) __attribute__((always_inline));

      inline static void ISR_ledActiveOn(void) __attribute__((always_inline));