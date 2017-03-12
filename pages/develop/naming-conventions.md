---
layout: page
lang: en
permalink: /develop/naming-conventions/
title: C/C++ naming conventions
author: Liviu Ionescu

date: 2014-02-22 16:02:04 +0000

---

## Underscore separated lower case names

In previous versions, µOS++ used the [CamelCase](http://en.wikipedia.org/wiki/CamelCase) naming convention, but, after a long consideration, the naming was brought back to what the ISO standard libraries use, and to what existing coding styles (like MISRA, JSF) recommend, which is **underscore separated lower case names**.

## Full words vs. short words

Whenever possible, it is recommended to use the full words; shortening words in member or member function names does not make the program shorter or faster, but, when used properly, highly increases the readability of the program.

    int initialise(); <- instead of init();
    int configure(); <- instead of config();
    ...
    int delay_seconds; <- instead of delay_sec;

## Pairs of opposed actions or names

### Antonyms

When defining pairs of opposed actions, use the proper antonyms:

    int start_acquisition();
    int stop_acquisition();
    ...
    int enable_interrupts();
    int disable_interrupts();

### Technical terms

Sometimes, even if the words are not listed in dictionaries as antonyms, the pairs of opposed names are defined by practice:

    // For hardware signals, like chip select
    int assert();
    int deassert();
    ...
    // For synchronisation objects, like mutex
    int acquire();
    int release();

### start/stop vs. begin/end

When defining actions, prefer **start**/**stop** to **begin**/**end**, since they have a stronger verb-like meaning (end is more an adjective than a verb).

    int start_acquisition(); <- instead of begin_acquisition()
    int stop_acquisition(); <- instead of end_acquisition()

However, when the meaning is adjectival, for example adding determinants to a noun, the pair begin/end is preferred.

    int list_begin; <- instead of list_start
    int list_end; <- instead of list_stop

## Class names

Class names are singular names or nominative constructs; they do not need to start with upper case letters.

    class logger;
    class circular_buffer;

### Derived class names

Derived class names should extend the base class name, by adding a differentiator at the end.

    class device_character_buffered : public device_character
    {
     ...
    };

### Abstract base classes

When an abstract class is used as a base class for concrete implementations, the suffix `_base` can be added to the name, and this name can be skipped in the derived class name:

    class device_character_buffered_usart0 : public device_character_buffered_base
    {
     ...
    };

## Templates

Templates are a great C++ feature, that can be used for many purposes, with the common one being to implement compile time polymorphism.

### Class template vs template class?

As far as C++ is concerned, there is no such thing as a "template class," there is only a "class template."

### Class template names

Class template names follow the same convention as the class names. No need to prefix them with anything.

### Template parameter types

There are several template parameter types, parameters naming user-defined types (like classes), parameters naming primitive types and constant parameters (usually integer).

Although not required by the language, it is recommended to define parameters naming types with `typename T`.

In class templates, it is recommended to alias the template parameters to new names, and use these new names in code, reserving the template parameters only to define the template syntax.

    template <typename T, typename U = void, int N>
    class pin
    {
    public:
      using gpio = T;
      using result_t = U ;
      static constexpr int bit = N;
     ...
    }

    // Explicit instantiation
    template class pin<GPIOC1>;

    // Define a type alias. 
    using my_pin = class pin<GPIOC1>;

## Member function names

Function names are formed from lower case letters.

Since functions define actions to be performed upon the object, the function name should have the function of a predicate, and usually **start with an imperative verb**.

    int read();

If there are multiple functions that perform similar actions, they should differentiate by the following noun, with the function of a direct complement.

    int read_byte();
    long read_long();
    ...
    void read_block();

The rule of starting with a verb is not absolute, when multiple functions are logically grouped by a common criteria, then predicative groups can be used as function names, and the verb is placed at the end. However, when such names occur, it might be a sign that the design can be further refined by defining additional objects, for example instead of:

    void critical_enter();
    void critical_exit();

a separate object to manage critical sections might be useful, like:

    class critical
    {
      void enter(void);
      void exit(void);
    };

In this case the naming convention is again simplified, according to the initial recommendation to use a verb.

### Accessors/mutators

As in most object oriented designs, member variables are usually private to the class and external direct access to them is discouraged. Instead, special accessors and mutators should be defined.

The name should generally contain the variable name, without parameters for the accessors and with at least one parameter for the mutators.

    private:
      int prio_;

    public:
      int prio(void);
      void prio(int);

### get/set vs. read/write

When dealing with hardware, even if the memory mapped registers are seen as class members, it is recommended to prefix member functions with read/write, not get/set, which are usually the sign of accessors/mutators in other languages.

    hal::cortexm::reg32_t
    read_mode(void);

    void
    write_mode(const hal::cortexm::reg32_t value);

### Boolean functions

Functions that return boolean values should start with boolean verbs, like **is**, **has**, **does**. Depending on the context, past or future tense versions, like **was** or **will** may be more appropriate.

    bool is_available();
    bool was_interrupted();
    bool will_block();
    bool has_members();
    bool does_return();  <-- instead of 'bool returns();'

### initialise() vs. configure()

In classes implementing device drivers, there are member functions that can be called only before the device is enabled and functions that can be called at any moment.

To mark this distinction, the recommended names should start with **initialise** for functions that are used before the device is enabled and with **configure** for functions that can be used at any moment.

    bool initialise_something(void);
    ...
    bool configure_baud_rate(baud_rate_t baud_rate);
    bool configure_high_speed(void);

It is recommended to use the full words, shortening `initialise()` to `init()` or `configure()` to `config()` does not make the program shorter or faster.

### set() vs. configure()

When dealing with device drivers, changing the state of the device is in fact a configuration change, so it is more appropriate to name functions like `configure_something()`.

## Member variables names

Similar to member functions, all member variables names start with lower case letters.

Since member variables define characteristics of the object, the member variables name should have the function of an attribute, and usually **start with a noun**. Boolean status variables naming convention should follow the boolean function naming convention, i.e. start with a verb like **is**, **has**, **does**, at present/past/future tense.

### Private member variables names

As the most common type of member variable names, the private member variables should be suffixed with `_`.

    private:
      int count_;
      char* buffer_address_;
      int buffer_size_;

      bool is_running_;
      bool was_cancelled_;

### Static member variables names

Static member variables need not be prefixed or suffixed.

    static constexpr uint32_t frequency_hz = 1;

### Public member names

As an exception to the above rules, some globally available member variables, can be named without the `_` suffix.

### Array members

For a better code readability, it is recommended to name array members or pointers to arrays explicitly, like this:

    thread** waiting_array;
    unsigned short waiting_array_size;

## const & volatile

The rules for using these keywords are sometimes tricky, and the easiest to remember is **_const makes a constant whatever is on its left_**:

     int* const p1; // constant pointer to int
     const int* p2; // pointer to an int constant
     const int* const p3; // constant pointer to an int constant

Systematic use of the above rule would put the type of scalars at the left of const, which is not that usual:

     int const n; // constant integer

So, for scalars and for constants, it is also acceptable to use the more common order:

     const int n;
     static const int my_const = 7;

## Constants

Constant names are regular names, all lower case.

Although in C/C++ it is possible to define constants using the preprocessor, it is recommended to use them only for project configuration variables, otherwise use only typed definitions, and the compiler might catch some errors.

For individual definitions, the recommended way is to use `constexpr`.

    constexpr thread_id_t no_id = 0xFF;

For definitions inside a class, use `static constexpr` members.

    static constexpr return_t os_ok = 0;

Depending on the specific scope, if the constants are to be used only inside the given class, they can be made private.

Constants can be grouped in separated classes, that groups together various return values, although enums would be probably more appropriate.

For group of constants, the recommended method is to use enumerations.

### static constexpr vs. constexpr static

The recommended order is `static constexpr`.

## Type definitions

For a better code maintainability, where needed, it is recommended to use type definitions instead of direct C/C++ scalar types.

Scalar type definitions should start with lower case letters and end with `_t`; class aliases should follow the usual naming convention of class names.

### Language type definition

#### Explicit size definitions

These are mainly the definitions from `<stdint.h>`

-   `uint8_t`, `int8_t`
-   `uint16_t`, `int16_t`
-   `uint32_t`, `int32_t`

#### Explicit size versus platform size

Once we introduce the above definitions, the usual question is when to use `int` versus `int8_t`/`int16_t`/`int32_t` or `unsigned int` versus `uint8_t`/`uint16_t`/`uint32_t`?

Probably there is no single rule, but several usage cases. For applications that depend on a specific size, regardless of the platform, it is recommended to use the explicit size type definitions. Otherwise, using the platform native size may be more efficient in some cases. For example loop counts are usually better compiled when the the platform register size is used, so even if you know that the counter is small, using `uint8_t` instead of unsigned int may not produce a shorter/faster code (on the contrary).

As a general rule, when defining types that should match a memory mapped structure, or a packet header, or some other fixed size structure, you obviously need to use the explicit size definitions. For the rest, platform size definitions might be preferred.

#### Signed versus unsigned

Another usual question is when to use `int` (signed) versus `unsigned int`. The answer is obvious, if the variable you want to represent can take negative values, then use signed variables. Otherwise, use unsigned variables.

One single note: sometimes, although the variable itself can take only positive values, it might be needed to also multiplex error codes on the same variable, and, in order to differentiate them, error cases are defined as impossible/illegal negative values.

Although an universal solution is not enforced, it is preferable NOT to return error codes multiplexed with valid content; instead, return the error code and use a separate pointer parameter to return values, and leave the value unaffected by error processing.

### User type definitions

These are custom definitions, made to increase code readability and maintainability. Preferably they should rely on the previous type definitions.

    typedef uint8_t thread_priority_t;

If the new type can be an alias, that does not introduce a new type definition, the C++11 syntax is:

    using thread_priority_t = uint8_t;

### Enumeration definitions

C++11 solved the old C enumeration problem and introduced strongly typed and scoped enumerations (`enum class`), so usually there is no need to use embedded classes with constants.

    typedef uint32_t mode_t;

    enum class mode : mode_t
    {
        input = 0, output = 1, alternate = 2, analog = 3
    };

    static const mode_t mode_mask = 0x3;
    ...
    some_function(mode::input);

### Structure definitions

Usually, structure definitions should be avoided, and be replaced by class definitions.

However, if for any reasons, struct definitions are needed, it is recommended to define both the struct name and the type, using the following syntax:

    typedef struct region_s
    {
      region_address_t address;
      region_size_t size;
    } region_t;

### Aliases to classes

For a more uniform look, type names used as aliases to class names need not end with `_t`.

    class my_class
    {
    public:
      region_address_t address;
      region_size_t size;
    };

    using my_class_alias = my_class;

## Measuring units

Whenever not absolutely obvious, append the measuring units to the member variable or function name.

    int bus_frequency_hz;
    int delay_seconds;
    int delay_milliseconds;
    int delay_microseconds;
    int length_metres;
    int length_centimetres;
    int length_millimetres;

If possible, use the full unit names.
