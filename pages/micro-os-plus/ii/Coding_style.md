---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Coding_style/
title: Coding style
author: Liviu Ionescu

date: 2016-01-10 21:52:38 +0000

---

The following rules are mainly based on *MISRA C++:2008 Guidelines for the use of the C++ language in critical systems*, by Motor Industry Software Reliability Association with additions from *Joint Strike Fighter Air Vehicle C++ Coding Standards*, Lockheed Martin Corporation Doc. No. 2RDU00001 Rev D, dated June 2007, with some changes and clarifications.

General Design
--------------

This coding standards document is intended to help programmers develop code that conforms to safety-critical software principles, i.e., code that does not contain defects that could lead to catastrophic failures resulting in significant harm to individuals and/or equipment. In general, the code produced should exhibit the following important qualities:

-   **Reliability**: Executable code should consistently fulfill all requirements in a predictable manner.
-   **Portability**: Source code should be portable (i.e. not compiler or linker dependent).
-   **Maintainability**: Source code should be written in a manner that is consistent, readable, simple in design, and easy to debug.
-   **Testability**: Source code should be written to facilitate testability. Minimizing the following characteristics for each software module will facilitate a more testable and maintainable module:
    1.  code size
    2.  complexity
    3.  static path count (number of paths through a piece of code)
-   **Reusability**: The design of reusable components is encouraged. Component reuse can eliminate redundant development and test activities (i.e. reduce costs).
-   **Extensibility**: Requirements are expected to evolve over the life of a product. Thus, a system should be developed in an extensible manner (i.e. perturbations in requirements may be managed through local extensions rather than wholesale modifications).
-   **Readability**: Source code should be written in a manner that is easy to read, understand and comprehend.

### Coupling & Cohesion

Source code should be developed as a set of modules as loosely coupled as is reasonably feasible. Note that **generic programming** (which requires the use of templates) allows source code to be written with loose coupling and without runtime overhead.

### Rules

#### Should, Will, and Shall Rules

There are three types of rules: should, will, and shall rules. Each rule contains either a “should”, “will” or a “shall” in bold letters indicating its type.

-   **Should** rules are advisory rules. They strongly suggest the recommended way of doing things.
-   **Will** rules are intended to be mandatory requirements. It is expected that they will be followed, but they do not require verification. They are limited to non-safety-critical requirements that cannot be easily verified (e.g., naming conventions). Specific to JSF AV, MISRA C++ does not use them.
-   **Shall** rules are mandatory requirements. They must be followed and they require verification (either automatic or manual).

#### Breaking Rules

-   [JSF AV Rule 4] - To break a **"should"** rule, the following approval must be received by the developer:
    -   approval from the software engineering lead (obtained by the unit approval in the developmental CM tool)
-   [JSF AV Rule 5] - To break a **"will"** or a **"shall"** rule, the following approvals must be received by the developer:
    -   approval from the software engineering lead (obtained by the unit approval in the developmental CM tool)
    -   approval from the software product manager (obtained by the unit approval in the developmental CM tool)
-   [JSF AV Rule 6] - Each deviation from a **"shall"** rule shall be documented in the file that contains the deviation). Deviations from this rule shall not be allowed, AV Rule 5 notwithstanding.

#### Exceptions to Rules

-   [JSF AV Rule 7] - Approval **will not** be required for a deviation from a **"shall"** or **“will”** rule that complies with an exception specified by that rule.

JSF AV Referenced Documents
---------------------------

1.  ANSI/IEEE Std 754, IEEE Standard for Binary Floating-Point Arithmetic, 1985.
2.  Bjarne Stroustrup. *The C++ Programming Language, 3rd Edition*. Addison-Wesley, 2000.
3.  Bjarne Stroustrup. *Bjarne Stroustrup's C++ Glossary.*
4.  Bjarne Stroustrup. *Bjarne Stroustrup's C++ Style and Technique FAQ.*
5.  Barbara Liskov. *Data Abstraction and Hierarchy, SIGPLAN Notices*, 23, 5 (May, 1988).
6.  Scott Meyers. *Effective C++: 50 Specific Ways to Improve Your Programs and Design, 2nd Edition.* Addison-Wesley, 1998.
7.  Scott Meyers. *More Effective C++: 35 New Ways to Improve Your Programs and Designs*. Addison-Wesley, 1996.
8.  Motor Industry Software Reliability Association. *Guidelines for the Use of the C Language in Vehicle Based Software*, April 1998.
9.  ISO/IEC 10646-1, Information technology - Universal Multiple-Octet Coded Character Set (UCS) - Part 1: Architecture and Basic Multilingual Plane, 1993.
10. ISO/IEC 14882:2003(E), *Programming Languages – C++*. American National Standards Institute, New York, New York 10036, 2003.
11. ISO/IEC 9899: 1990, *Programming languages - C*, ISO, 1990.
12. JSF Mission Systems Software Development Plan.
13. JSF System Safety Program Plan. DOC. No. 2YZA00045-0002.
14. *Programming in C++ Rules and Recommendations.* Copyright © by Ellemtel Telecommunication Systems Laboratories, Box 1505, 125 25 Alvsjo, Sweden, Document: M 90 0118 Uen, Rev. C, 27 April 1992.
15. RTCA/DO-178B, *Software Considerations in Airborne Systems and Equipment Certification*, December 1992.

Language independent issues
---------------------------

### Code Size and Complexity

-   [JSF AV Rule 1] - Any one function (or method) **will** contain no more than 200 logical source lines of code (L- SLOCs).
-   [JSF AV Rule 2] - There **shall not** be any self-modifying code.
-   [JSF AV Rule 3] - All functions **shall** have a cyclomatic complexity number of 20 or less.

    **Exception**: A function containing a switch statement with many case labels may exceed this limit.

    Node: Cyclomatic complexity is a structural metric based entirely on control flow through a piece of code; it is the number of non-repeating paths through the code.

### Unnecessary constructs

-   [MISRA C++ Rule 0–1–1, Required] A *project* **shall not** contain *unreachable code*.
-   [JSV AV Rule 186 (MISRA C Rule 52)] - There **shall** be no unreachable code.

    Note: For *reusable template components*, unused members will not be included in the object code.

-   [MISRA C++ Rule 0–1–2, Required] A *project* **shall not** contain *infeasible paths*.
-   [MISRA C++ Rule 0–1–3, Required] A *project* **shall not** contain *unused* variables.
-   [MISRA C++ Rule 0–1–4, Required] A *project* **shall not** contain non-volatile *POD* variables having only one use.
-   [MISRA C++ Rule 0–1–5, Required] A *project* **shall not** contain unused type declarations.
-   [MISRA C++ Rule 0–1–6, Required] A *project* **shall not** contain instances of non-volatile variables being given values that are never subsequently used.
-   [MISRA C++ Rule 0–1–7, Required] The value returned by a function having a non-*void* return type that is not an overloaded operator **shall** always be *used*.
-   [MISRA C++ Rule 0–1–8, Required] All functions with *void* return type **shall** have external side effect(s).
-   [JSV AV Rule 187 (MISRA C Rule 53, Revised)] - All non-null statements **shall** potentially have a side-effect.
-   [MISRA C++ Rule 0–1–9, Required] There **shall** be no *dead code* (redundant, code whose removal would not affect the program output).
-   [MISRA C++ Rule 0–1–10, Required] Every defined function **shall** be called at least once.
-   [MISRA C++ Rule 0–1–11, Required] There **shall** be no *unused* parameters (named or unnamed) in non-virtual functions.
-   [MISRA C++ Rule 0–1–12, Required] There **shall** be no *unused* parameters (named or unnamed) in the set of parameters for a virtual function and all the functions that override it.

### Storage

-   [MISRA C++ Rule 0–2–1, Required] An object **shall not** be assigned to an overlapping object (object storage shall not overlap).

### Runtime features

-   [MISRA C++ Rule 0–3–1, Document] Minimization of run-time failures **shall** be ensured by the use of at least one of:
    -   static analysis tools/techniques;
    -   dynamic analysis tools/techniques;
    -   explicit coding of checks to handle run-time faults.
-   [MISRA C++ Rule 0–3–2, Required] If a function generates error information, then that error information **shall** be tested.
-   [JSF AV Rule 15 (MISRA C Rule 4, Revised)] - Provision **shall** be made for run-time checking (defensive programming).
-   [JSF AV Rule 125] - Unnecessary temporary objects **should** be avoided. See Meyers [7], item 19, 20, 21.
-   [JSV AV Rule 217] - Compile-time and link-time errors **should** be preferred over run-time errors. See Meyers [6], item 46.

### Arithmetic

-   [MISRA C++ Rule 0–4–1, Document] - Use of scaled-integer or fixed-point arithmetic **shall** be documented.
-   [MISRA C++ Rule 0–4–2, Document] - Use of floating-point arithmetic **shall** be documented.
-   [MISRA C++ Rule 0–4–3, Document] - Floating-point implementations **shall** comply with a defined floating- point standard.

General
-------

### Language

-   ~~[MISRA C++ Rule 1–0–1, Required] - All code **shall** conform to ISO/IEC 14882:2003 “The C++ Standard Incorporating Technical Corrigendum 1”.~~ (updated to 14882:2011)
-   ~~[JSF AV Rule 8] - All code **shall** conform to ISO/IEC 14882:2002(E) standard C++. [10]~~ (updated to 14882:2011)
-   [ILG Rule 1–0–1 update, Required] - All code **shall** conform to ISO/IEC 14882:2011 The *C++ Programming languages — C++*
-   [MISRA C++ Rule 1–0–2, Document] - Multiple compilers **shall** only be used if they have a common, defined interface.
-   [ILG Rule 1-0-2, Advisory] - Both GNU GCC and LLVM Clang compilers **should** be considered.
-   [MISRA C++ Rule 1–0–3, Document] - The implementation of integer division in the chosen compiler **shall** be determined and documented.

Lexical conventions
-------------------

### Character sets

-   [MISRA C++ Rule 2–2–1, Document] - The character set and the corresponding encoding **shall** be documented.
-   [JSF AV Rule 9 (MISRA C Rule 5, Revised)] - Only those characters specified in the C++ basic source character set **will** be used. This set includes 96 characters: the space character, the control characters representing horizontal tab, vertical tab, form feed, and newline, and the following 91 graphical characters:

<!-- -->

     a b c d e f g h i j k l m n o p q r s t u v w x y z
     A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
     0 1 2 3 4 5 6 7 8 9
     _ { } [ ] - # ( ) < > % : ; . ? * + -
     / ^ & | ~ ! = , \ " ’

-   [JSF AV Rule 10 (MISRA C Rule 6)] - Values of character types **will** be restricted to a defined and documented subset of ISO 10646-1. [9]
-   ~~[JSF AV Rule 13 (MISRA C Rule 8)] - Multi-byte characters and wide string literals **will not** be used.~~
-   [ILG AV Rule 13 (MISRA C Rule 8)] - Multi-byte characters and wide string literals **will not** be used in variable names, but UTF-8 characters are legal in comments (and Doxygen documentation).

### Trigraph sequences

-   ~~[MISRA C++ Rule 2–3–1, Required] - *Trigraphs* **shall** not be used.~~
-   [JSF AV Rule 11 (MISRA C Rule 7)] - Trigraphs **will not** be used.

### Alternative tokens

-   [MISRA C++ Rule 2–5–1, Advisory] - *Digraphs* **should** not be used.
-   [JSF AV Rule 12, (Extension of MISRA C Rule 7)] - The following digraphs **will not** be used:

<!-- -->

     <% %> <: :> %: %:%:

### Comments

Comments in header files are meant for the users of classes and functions, while comments in implementation files are meant for those who maintain the classes.

Comments are often said to be either strategic or tactical. A strategic comment describes what a function or section of code is intended to do, and is placed before the code. A tactical comment describes what a single line of code is intended to do. Unfortunately, too many tactical comments can make code unreadable. For this reason, comments should be primarily strategic, unless trying to explain very complicated code (i.e. one should avoid stating in a comment what is clearly stated in code).

-   [MISRA C++ Rule 2–7–1, Required] - The character sequence `/*` **shall not** be used within a C-style comment.
-   [JSF AV Rule 126] - Only valid C++ style comments (//) **shall** be used. See AV Rule 126 in Appendix A for additional details concerning valid C++ style comments.

    **Exception**: Automatic code generators that cannot be configured to use the “//” form.

-   [MISRA C++ Rule 2–7–2, Required] - Sections of code **shall not** be “commented out” using C-style comments.
-   [MISRA C++ Rule 2–7–3, Advisory] - Sections of code **should not** be “commented out” using C++ comments.
-   [JSF AV Rule 127] - Code that is not used (commented out) shall be deleted.

    **Exception**: Code that is simply part of an explanation may appear in comments.

-   [JSF AV Rule 128] - Comments that document actions or sources (e.g. tables, figures, paragraphs, etc.) outside of the file being documented **will not** be allowed.
-   [JSF AV Rule 129] - Comments in header files **should** describe the externally visible behavior of the functions or classes being documented.
-   [JSF AV Rule 130] - The purpose of every line of executable code **should** be explained by a comment, although one comment may describe more than one line of code.
-   [JSF AV Rule 131] - One **should** avoid stating in comments what is better stated in code (i.e. do not simply repeat what is in the code).
-   [JSF AV Rule 132] - Each variable declaration, typedef, enumeration value, and structure member **will** be commented.

    **Exception**: Cases where commenting would be unnecessarily redundant.

-   [JSF AV Rule 133] - Every source file **will** be documented with an introductory comment that provides information on the file name, its contents, and any program-required information (e.g. legal statements, copyright information, etc).
-   [JSF AV Rule 134] - Assumptions (limitations) made by functions **should** be documented in the function’s preamble.

### Identifiers

The choice of identifier names should:

1.  Suggest the usage of the identifier.
2.  Consist of a descriptive name that is short yet meaningful.
3.  Be long enough to avoid name conflicts, but not excessive in length.
4.  Include abbreviations that are generally accepted.

-   [MISRA C++ Rule 2–10–1, Required] - Different identifiers **shall** be typographically unambiguous.
-   [MISRA C++ Rule 2–10–2, Required] - Identifiers declared in an inner scope **shall not** hide an identifier declared in an outer scope.
-   [MISRA C++ Rule 2–10–3, Required] - A *typedef* name (including qualification, if any) **shall** be a *unique* identifier.
-   [MISRA C++ Rule 2–10–4, Required] - A *class*, *union* or *enum* name (including qualification, if any) **shall** be a *unique* identifier.
-   [MISRA C++ Rule 2–10–5, Advisory] - The identifier name of a non-member object or function with static storage duration **should not** be reused.
-   [MISRA C++ Rule 2–10–6, Required] - If an identifier refers to a type, it **shall not** also refer to an object or a function in the same scope.
-   ~~[JSF AV Rule 45] - All words in an identifier **will** be separated by the ‘_’ character.~~
-   [ILG AV Rule 45 update] - The identifiers **should** use the CamelCase convention.
-   [JSF AV Rule 46 (MISRA C Rule 11, Revised)] - User-specified identifiers (internal and external) **will not** rely on significance of more than 64 characters.
-   [JSF AV Rule 47] - Identifiers **will not** begin with the underscore character ‘_’.
-   [JSF AV Rule 48] - Identifiers **will not** differ by:
    -   Only a mixture of case
    -   The presence/absence of the underscore character
    -   The interchange of the letter ‘O’, with the number ‘0’ or the letter ‘D’
    -   The interchange of the letter ‘I’, with the number ‘1’ or the letter ‘l’
    -   The interchange of the letter ‘S’ with the number ‘5’
    -   The interchange of the letter ‘Z’ with the number 2
    -   The interchange of the letter ‘n’ with the letter ‘h’.
-   ~~[JSF AV Rule 49] - All acronyms in an identifier **will** be composed of uppercase letters.~~
-   [ILG AV Rule 49 update] - As all CamelCase words, acronyms **will** be transformed to have only the first letter in uppercase.
-   ~~[JSF AV Rule 50] - The first word of the name of a class, structure, namespace, enumeration, or type created with typedef **will** begin with an uppercase letter. All others letters will be lowercase.~~

    ~~**Exception**: The first letter of a *typedef* name may be in lowercase in order to conform to a standard library interface or when used as a replacement for fundamental types (see AV Rule 209).~~

-   ~~[JSF AV Rule 51] - All letters contained in function and variable names **will** be composed entirely of lowercase letters.~~
-   ~~[JSF AV Rule 52] - Identifiers for constant and enumerator values **shall** be lowercase.~~
-   [ILG AV Rule 50 update] - The first word of the name of a class, typedef class alias, constant definition **will** begin with an uppercase letter. Namespace, or scalar type definitions **will** begin with an lowercase letter. (structures? enumerations?)

### Literals

-   ~~[MISRA C++ Rule 2–13–1, Required] - Only those escape sequences that are defined in ISO/IEC 14882:2003 **shall** be used.~~
-   [ILG Rule 2–13–1, Required] - Only those escape sequences that are defined in ISO/IEC 14882:2011 **shall** be used.
-   [MISRA C++ Rule 2–13–2, Required] - Octal constants (other than zero) and octal escape sequences (other than “\\0”) **shall not** be used.
-   [MISRA C++ Rule 2–13–3, Required] - A *“U”* suffix **shall** be applied to all octal or hexadecimal integer literals of unsigned type.

    ILG: for example 0U.

-   [MISRA C++ Rule 2–13–4, Required] - Literal suffixes **shall** be upper case.

    ILG: to avoid ambiguities with digit 1; for example 0L, 0UL, 0x0U, 1.2F.

-   [JSF AV Rule 14] - Literal suffixes **shall** use uppercase rather than lowercase letters.
-   [MISRA C++ Rule 2–13–5, Required] - Narrow and wide string literals **shall not** be concatenated.

Basic concepts
--------------

### Declarations and definitions

-   [MISRA C++ Rule 3–1–1, Required] - It **shall** be possible to include any *header file* in multiple translation units without violating the *One Definition Rule*.
-   [MISRA C++ Rule 3–1–2, Required] - Functions **shall** not be declared at block scope.

    ILG: but at namespace level.

-   [MISRA C++ Rule 3–1–3, Required] - When an array is declared, its size **shall** either be stated explicitly or defined implicitly by initialisation.

    ILG: no extern arrays without explicit size.

### One Definition Rule

-   [MISRA C++ Rule 3–2–1, Required] - All declarations of an object or function **shall** have *compatible types*.
-   [MISRA C++ Rule 3–2–2, Required] - The *One Definition Rule* **shall not** be violated.
-   [MISRA C++ Rule 3–2–3, Required] - A type, object or function that is used in multiple translation units **shall** be declared in one and only one file.
-   [MISRA C++ Rule 3–2–4, Required] - An identifier with external linkage **shall** have exactly one definition.

### Declarative regions and scope

-   [MISRA C++ Rule 3–3–1, Required] - Objects or functions with external linkage **shall** be declared in a *header file*.

    ILG: to document that they are intended to be accessible from other translation units, otherwise isolate them as static.

-   [MISRA C++ Rule 3–3–2, Required] - If a function has internal linkage then all re-declarations **shall** include the *static* storage class specifier.

### Name lookup

-   [MISRA C++ Rule 3–4–1, Required] - An identifier declared to be an object or type **shall** be defined in a block that minimizes its visibility.

### Types

-   [MISRA C++ Rule 3–9–1, Required] - The types used for an object, a function return type, or a function parameter **shall** be token-for-token identical in all declarations and re-declarations.
-   [MISRA C++ Rule 3–9–2, Advisory] - *typedefs* that indicate size and signedness **should** be used in place of the basic numerical types.
-   [ILG Note] - The ISO (POSIX) typedefs as shown below are recommended and are used for all basic numerical and character types in this document. For a 32-bit integer machine, these are as follows:

<!-- -->

    typedef          char   char_t;
    typedef signed   char   int8_t;
    typedef signed   short  int16_t;
    typedef signed   int    int32_t;
    typedef signed   long   int64_t;
    typedef unsigned char   uint8_t;
    typedef unsigned short  uint16_t;
    typedef unsigned int    uint32_t;
    typedef unsigned long   uint64_t;
    ￼typedef float           float32_t;
    typedef double          float64_t;
    typedef long     double float128_t;

-   [JSV AV Rule 209 (MISRA C Rule 13, Revised)] - The basic types of *int*, *short*, *long*, *float* and *double* **shall not** be used, but specific-length equivalents should be *typedef*’d accordingly for each compiler, and these type names used in the code.

    **Exception**: Basic types are permitted in low-level routines to assist in the management of word alignment issues (e.g. memory allocators).

    MISRA C Rule was changed from should to shall.

-   [MISRA C++ Rule 3–9–3, Required] - The underlying bit representations of floating-point values **shall not** be used.
-   [JSF AV Rule 146 (MISRA C Rule 15)] - Floating point implementations **shall** comply with a defined floating point standard. The standard that will be used is the ANSI/IEEE Std 754 [1].
-   [JSF AV Rule 147 (MISRA C Rule 16)] - The underlying bit representations of floating point numbers **shall not** be used in any way by the programmer.
-   [JSF AV Rule 148] - Enumeration types **shall** be used instead of integer types (and constants) to select from a limited series of choices.

    Note: This rule is not intended to exclude character constants (e.g.‘A’,‘B’,‘C’,etc.) from use as case labels.

Standard conversions
--------------------

### Integral promotions

-   [MISRA C++ Rule 4–5–1, Required] - Expressions with type *bool* **shall not** be used as operands to built-in operators other than the assignment operator `=`, the logical operators `&&`, `||`, `!`, the equality operators `==` and `!=`, the unary `&` operator, and the conditional operator.
-   [MISRA C++ Rule 4–5–2, Required] - Expressions with type *enum* **shall not** be used as operands to built- in operators other than the subscript operator `[ ]`, the assignment operator `=`, the equality operators `==` and `!=`, the unary `&` operator, and the relational operators `<`, `<=`, `>`, `>=`.
-   [MISRA C++ Rule 4–5–3, Required] - Expressions with type (plain) *char* and *wchar_t* **shall not** be used as operands to built-in operators other than the assignment operator `=`, the equality operators `==` and `!=`, and the unary `&` operator.

    **Exceptions**: Exceptionally, the following operators may be used if the associated restriction is observed:

    -   The binary + operator may be used to add an integral value in the range 0 to 9 to ‘0’;
    -   The binary – operator may be used to subtract character ‘0’;
    -   The relational operators \<, \<=, \>, \>= may be used to determine if a character (or wide character) represents a digit.

### Pointer conversions

-   [MISRA C++ Rule 4–10–1, Required] - *NULL* **shall not** be used as an integer value.
-   [MISRA C++ Rule 4–10–2, Required] - Literal zero (0) **shall not** be used as the *null-pointer-constant*.

    ILG: use **nullptr**.

Expressions
-----------

### General

-   [MISRA C++ Rule 5–0–1, Required] - The value of an expression **shall** be the same under any order of evaluation that the standard permits.

    ILG: beware of increment/decrement in expressions, in function arguments, in nested statements.

-   [JSV AV Rule 204.1 (MISRA C Rule 46)] - The value of an expression **shall be** the same under any order of evaluation that the standard permits.
-   [JSF AV Rule 162] - Signed and unsigned values **shall not** be mixed in arithmetic or comparison operations.
-   [JSF AV Rule 163] - Unsigned arithmetic **shall not** be used.
-   [MISRA C++ Rule 5–0–2, Advisory] - Limited dependence **should** be placed on C++ operator precedence rules in expressions.

    ILG: parentheses should be used to emphasise precedence rules.

-   [JSV AV Rule 213 (MISRA C Rule 47, Revised)] - No dependence **shall** be placed on C++’s operator precedence rules, below arithmetic operators, in expressions.

    MISRA C Rule 47 changed by replacing should with shall.

-   [MISRA C++ Rule 5–0–3, Required] - A cvalue expression **shall not** be implicitly converted to a different *underlying type*.

    ILG: avoid expressions like `s32 = s8+s8;`.

-   [MISRA C++ Rule 5–0–4, Required] - An implicit integral conversion **shall not** change the signedness of the *underlying type*.
-   [MISRA C++ Rule 5–0–5, Required] - There **shall** be no implicit *floating-integral* conversions.
-   [JSV AV Rule 184] - Floating point numbers **shall not** be converted to integers unless such a conversion is a specified algorithmic requirement or is necessary for a hardware interface.
-   [MISRA C++ Rule 5–0–6, Required] - An implicit integral or floating-point conversion **shall not** reduce the size of the *underlying type*.
-   [MISRA C++ Rule 5–0–7, Required] - There **shall** be no explicit *floating-integral* conversions of a cvalue expression.
-   [MISRA C++ Rule 5–0–8, Required] - An explicit integral or floating-point conversion **shall not** increase the size of the *underlying type* of a *cvalue* expression.

    ILG: avoid `s32 = static_cast< int32_t > ( s16 + s16 );`.

-   [MISRA C++ Rule 5–0–9, Required] - An explicit integral conversion **shall not** change the signedness of the *underlying type* of a *cvalue* expression.

    ILG: avoid `s8 = static_cast< int8_t >( u8 + u8 );`.

-   [JSV AV Rule 180 (MISRA C Rule 43)] - Implicit conversions that may result in a loss of information **shall not** be used.

    Note: Templates can be used to resolve many type conversion issues. Also, any compiler flags that result in warnings for value-destroying conversions should be activated.

-   [MISRA C++ Rule 5–0–10, Required] - If the bitwise operators `~` and `<<` are applied to an operand with an *underlying type* of *unsigned char* or *unsigned short*, the result **shall** be immediately cast to the *underlying type* of the operand.

    ILG: prefer explicit intermediate steps, avoid `result_16 = ((port_8 << 4) & mode_16) >> 6;`.

-   [MISRA C++ Rule 5–0–11, Required] - The plain *char* type **shall** only be used for the storage and use of character values.
-   [MISRA C++ Rule 5–0–12, Required] - *signed char* and *unsigned char* type **shall** only be used for the storage and use of numeric values.
-   [MISRA C++ Rule 5–0–13, Required] - The *condition* of an *if-statement* and the *condition* of an *iteration-statement* **shall** have type bool.

    ILG: avoid `if (u8)`)

    **Exception**: A condition of the form type-specifier-seq declarator is not required to have type bool. This exception is introduced because alternative mechanisms for achieving the same effect are cumbersome and error-prone.

-   [MISRA C++ Rule 5–0–14, Required] - The first operand of a *conditional-operator* **shall** have type *bool*.

    ILG: avoid `int32_a = int16_b ? int32_c : int32_d;`.

-   [MISRA C++ Rule 5–0–15, Required] - Array indexing **shall** be the only form of pointer arithmetic.

    ILG: avoid pointer arithmetic.

    **Exception**: The increment/decrement operators may be used on iterators implemented by pointers to an array.

-   [JSV AV Rule 215 (MISRA C Rule 101)] - Pointer arithmetic **will not** be used.
-   [MISRA C++ Rule 5–0–16, Required] - A pointer operand and any pointer resulting from pointer arithmetic using that operand **shall** both address elements of the same array.

    **Exception**: Objects such as containers, iterators, and allocators that manage pointer arithmetic through well-defined interfaces are acceptable.

    ILG: to avoid undefined behaviour.

-   [MISRA C++ Rule 5–0–17, Required] - Subtraction between pointers **shall** only be applied to pointers that address elements of the same array.
-   [MISRA C++ Rule 5–0–18, Required] - `>`, `>=`, `<`, `<=` **shall not** be applied to objects of pointer type, except where they point to the same array.
-   [JSV AV Rule 171 (MISRA C Rule 103)] - Relational operators **shall not** be applied to pointer types except where both operands are of the same type and point to:
    -   the same object,
    -   the same function,
    -   members of the same object, or
    -   elements of the same array (including one past the end of the same array).


    Note that if either operand is null, then both shall be null. Also, “members of the same object” should not be construed to include base class subobjects (See also AV Rule 210).

-   [MISRA C++ Rule 5–0–19, Required] - The declaration of objects **shall** contain no more than two levels of pointer indirection.

    ILG: do not use `int8_t *** s3;`.

-   [JSV AV Rule 169] - Pointers to pointers **should** be avoided when possible.
-   [JSV AV Rule 170 (MISRA C Rule 102, Revised)] - More than 2 levels of pointer indirection **shall not** be used.

    Note: This rule leaves no room for using more than 2 levels of pointer indirection. The word “shall” replaces the word “should” in MISRA C Rule 102.

-   [MISRA C++ Rule 5–0–20, Required] - Non-constant operands to a binary bitwise operator **shall** have the same *underlying type*.

    ILG: avoid `value_16 ^= mask_8;`.

-   [MISRA C++ Rule 5–0–21, Required] - Bitwise operators **shall** only be applied to operands of unsigned *underlying type*.

    ILG: Bitwise are not normally meaningful on signed integers.

-   [JSF AV Rule 160 (MISRA C Rule 35, Modified)] - An assignment expression **shall** be used only as the expression in an expression statement.

    ILG: avoid `if (x=y)`.

-   [JSF AV Rule 167 (MISRA C Rule 41)] - The implementation of integer division in the chosen compiler **shall** be determined, documented and taken into account.
-   [JSV AV Rule 174 (MISRA C Rule 107)] - The null pointer **shall not** be de-referenced.
-   ~~[JSV AV Rule 175] - A pointer **shall not** be compared to NULL or be assigned NULL; use plain 0 instead.~~
-   [ILG AV Rule 175] - A pointer **shall not** be compared to NULL or be assigned NULL; use **nullptr** instead.
-   [JSV AV Rule 176] - A typedef **will** be used to simplify program syntax when declaring function pointers.
-   [JSV AV Rule 177] - User-defined conversion functions **should** be avoided. See Meyers [7], item 5.
-   [JSV AV Rule 203 (MISRA C Rule 51, Revised)] - Evaluation of expressions **shall not** lead to overflow/underflow (unless required algorithmically and then should be heavily documented).
-   [JSV AV Rule 212] - Underflow or overflow functioning **shall not** be depended on in any special way.
-   [JSV AV Rule 204] - A single operation with side-effects **shall** only be used in the following contexts:
    1.  by itself
    2.  the right-hand side of an assignment
    3.  a condition
    4.  the only argument expression with a side-effect in a function call
    5.  condition of a loop
    6.  switch condition
    7.  single part of a chained operation.
-   ~~[JSV AV Rule 205] - The *volatile* keyword **shall not** be used unless directly interfacing with hardware.~~
-   [ILG AV Rule 205] - The *volatile* keyword **shall not** be used unless directly interfacing with hardware or with multithreaded, or foreground/interrupt applications.
-   [JSV AV Rule 214] - Assuming that non-local static objects, in separate translation units, are initialized in a special order **shall not** be done.

### Type conversions

-   [MISRA C++ Rule 5–2–2, Required] - A pointer to a virtual base class **shall** only be cast to a pointer to a derived class by means of *dynamic_cast*.

    ILG: Casting from a virtual base to a derived class, using any means other than dynamic_cast has undefined behaviour.

-   [JSV AV Rule 179] - A pointer to a virtual base class **shall not** be converted to a pointer to a derived class.
-   [MISRA C++ Rule 5–2–3, Advisory] - Casts from a base class to a derived class **should not** be performed on polymorphic types.

    ILG: Explicit casts bypass this layer of abstraction resulting in higher levels of coupling and dependency.

-   [JSV AV Rule 178] - Down casting (casting from base to derived class) **shall** only be allowed through one of the following mechanism:
    -   Virtual functions that act like dynamic casts (most likely useful in relatively simple cases)
    -   Use of the visitor (or similar) pattern (most likely useful in complicated cases)


    Note: Type fields **shall not** be used as they are too error prone.

    Note: Dynamic casts are not allowed at this point due to lack of tool support, but could be considered at some point in the future after appropriate investigation has been performed for SEAL1/2 software. Dynamic casts are fine for general purpose software.

-   [MISRA C++ Rule 5–2–4, Required] - C-style casts (other than *void* casts) and functional notation casts (other than explicit constructor calls) **shall not** be used.

    **Exception** A C-style cast to void may be used to signify that the return value for a non-void function call is being ignored (see Rule 0–1–7).

-   [JSV AV Rule 185] - C++ style casts (*const_cast*, *reinterpret_cast*, and *static_cast*) shall be used instead of the traditional C-style casts. See Stroustrup [2], 15.4 and Meyers [7], item 2.
-   [MISRA C++ Rule 5–2–5, Required] - A cast **shall not** remove any const or *volatile* qualification from the type of a pointer or reference.
-   [MISRA C++ Rule 5–2–6, Required] - A cast **shall not** convert a pointer to a function to any other pointer type, including a pointer to function type.
-   [MISRA C++ Rule 5–2–7, Required] - An object with pointer type **shall not** be converted to an unrelated pointer type, either directly or indirectly.
-   [MISRA C++ Rule 5–2–8, Required] - An object with integer type or pointer to *void* type **shall not** be converted to an object with pointer type.
-   [MISRA C++ Rule 5–2–9, Advisory] - A cast **should not** convert a pointer type to an integral type.

    **Rationale**: The size of integer that is required when a pointer is converted to an integer is implementation- defined. Casting between a pointer and an integer type should be avoided where possible, but may be unavoidable when addressing memory mapped registers or other hardware specific features.

-   [JSV AV Rule 182 (MISRA C Rule 45)] - Type casting from any type to or from pointers **shall not** be used.

    **Exception 1**: Casting from *void\** to *T\** is permissible. In this case, *static_cast* should be used, but only if it is known that the object really is a *T*. Furthermore, such code should only occur in low level memory management routines.

    **Exception 2**: Conversion of literals (i.e. hardware addresses) to pointers.

-   [JSV AV Rule 181 (MISRA C Rule 44)] - Redundant explicit casts **will not** be used.
-   [JSV AV Rule 183] - Every possible measure **should** be taken to avoid type casting.

### Postfix expressions

-   [MISRA C++ Rule 5–2–1, Required] - Each operand of a logical `&&` or `||` **shall** be a *postfix-expression*.

    ILG: The effect of this rule is to require that operands are appropriately parenthesized.

    **Exception** Where an expression consists of either a sequence of only logical && or a sequence of only logical ||, extra parentheses are not required.

-   [MISRA C++ Rule 5–2–10, Advisory] - The increment (`++`) and decrement (`--`) operators **should not** be mixed with other operators in an expression.
-   [MISRA C++ Rule 5–2–11, Required] - The comma operator, `&&` operator and the `||` operator **shall not** be overloaded.
-   [JSF AV Rule 159] - Operators ||, &&, and unary & **shall not** be overloaded. See Meyers [7], item 7.
-   [MISRA C++ Rule 5–2–12, Required] - An identifier with array type passed as a function argument **shall not** decay to a pointer.

### Unary expressions

-   [MISRA C++ Rule 5–3–1, Required] - Each operand of the `!` operator, the logical `&&` or the logical `||` operators **shall** have type *bool*.
-   [MISRA C++ Rule 5–3–2, Required] - The unary minus operator **shall not** be applied to an expression whose *underlying type* is unsigned.
-   [JSF AV Rule 165 (MISRA C Rule 39)] - The unary minus operator **shall not** be applied to an unsigned expression.
-   [MISRA C++ Rule 5–3–3, Required] - The unary `&` operator **shall not** be overloaded.
-   [MISRA C++ Rule 5–3–4, Required] - Evaluation of the operand to the *sizeof* operator **shall not** contain side effects.
-   [JSF AV Rule 166 (MISRA C Rule 40)] - The sizeof operator **will not** be used on expressions that contain side effects.

### Shift operators

-   [MISRA C++ Rule 5–8–1, Required] - The right hand operand of a shift operator **shall** lie between zero and one less than the width in bits of the *underlying type* of the left hand operand.
-   [JSF AV Rule 164 (MISRA C Rule 38)] - The right hand operand of a shift operator **shall** lie between zero and one less than the width in bits of the left-hand operand (inclusive).
-   [JSF AV Rule 164.1] - The left-hand operand of a right-shift operator **shall not** have a negative value.

### Logical AND operator

-   [MISRA C++ Rule 5–14–1, Required] - The right hand operand of a logical `&&` or `||` operator **shall not** contain side effects.
-   [JSF AV Rule 157 (MISRA C Rule 33)] - The right hand operand of a && or || operator **shall not** contain side effects.

    ILG: avoid `if ( logical_expression && ++x)`.

-   [JSF AV Rule 158 (MISRA C Rule 34)] - The operands of a logical && or || **shall** be parenthesized if the operands contain binary operators.

    ILG: always use parenthesis.

### Assignment operators

-   [MISRA C++ Rule 5–17–1, Required] - The semantic equivalence between a binary operator and its assignment operator form **shall** be preserved.
-   [JSF AV Rule 81] - The assignment operator **shall** handle self-assignment correctly (see Stroustrup [2])
-   [JSF AV Rule 82] - An assignment operator **shall** return a reference to *\*this*.
-   [JSF AV Rule 83] - An assignment operator **shall** assign all data members and bases that affect the class invariant (a data element representing a cache, for example, would not need to be copied).

### Comma operator

-   [MISRA C++ Rule 5–18–1, Required] - The comma operator **shall not** be used.
-   [JSF AV Rule 168 (MISRA C Rule 42, Revised)] - The comma operator **shall not** be used.

### Constant expressions

-   [MISRA C++ Rule 5–19–1, Advisory] - Evaluation of constant unsigned integer expressions **should not** lead to wrap-around.
-   [JSF AV Rule 149 (MISRA C Rule 19)] - Octal constants (other than zero) **shall not** be used.

    Note: Hexadecimal numbers and zero (which is also an octal constant) are allowed.

-   [JSF AV Rule 150] - Hexadecimal constants **will** be represented using all uppercase letters.
-   [JSF AV Rule 151] - Numeric values in code **will not** be used; symbolic values **will** be used instead.

    **Exception**: A class/structure constructor may initialize an array member with numeric values.

    Note: In many cases ‘0’ and ‘1’ are not magic numbers but are part of the fundamental logic of the code (e.g. ‘0’ often represents a NULL pointer). In such cases, ‘0’ and ‘1’ may be used.

-   [JSF AV Rule 151.1] - A string literal **shall not** be modified.

    Note that strictly conforming compilers should catch violations, but many do not.

Statements
----------

### Expression statement

-   [MISRA C++ Rule 6–2–1, Required] - Assignment operators **shall not** be used in sub-expressions.
-   [MISRA C++ Rule 6–2–2, Required] - Floating-point expressions **shall not** be directly or indirectly tested for equality or inequality.
-   [JSV AV Rule 202 (MISRA C Rule 50)] - Floating point variables **shall not** be tested for exact equality or inequality.
-   [MISRA C++ Rule 6–2–3, Required] - Before preprocessing, a null statement **shall** only occur on a line by itself; it may be followed by a comment, provided that the first character following the null statement is a white-space character.

### Compound statement

-   [MISRA C++ Rule 6–3–1, Required] - The statement forming the body of a *switch*, *while*, *do ... while* or *for* statement **shall** be a compound statement.

### Selection statements

-   [MISRA C++ Rule 6–4–1, Required] - An *if ( condition )* construct **shall** be followed by a compound statement. The *else* keyword shall be followed by either a compound statement, or another *if* statement.
-   [MISRA C++ Rule 6–4–2, Required] - All *if ... else if* constructs **shall** be terminated with an *else* clause.
-   [MISRA C++ Rule 6–4–3, Required] - A *switch* statement **shall** be a *well-formed switch statement*.
-   [MISRA C++ Rule 6–4–4, Required] - A *switch-label* **shall** only be used when the most closely-enclosing compound statement is the body of a *switch* statement.
-   [MISRA C++ Rule 6–4–5, Required] - An unconditional *throw* or *break* statement **shall** terminate every non-empty *switch-clause*.
-   [MISRA C++ Rule 6–4–6, Required] - The final clause of a *switch* statement **shall** be the *default-clause*.
-   [MISRA C++ Rule 6–4–7, Required] - The *condition* of a *switch* statement **shall not** have *bool* type.
-   [MISRA C++ Rule 6–4–8, Required] - Every *switch* statement **shall** have at least one *case-clause*.
-   [JSV AV Rule 188 (MISRA C Rule 55, Revised)] - Labels **will not** be used, except in switch statements.
-   [JSV AV Rule 189 (MISRA C Rule 56)] - The *goto* statement **shall not** be used.

    **Exception**: A goto may be used to break out of multiple nested loops provided the alternative would obscure or otherwise significantly complicate the control logic.

-   [JSV AV Rule 190 (MISRA C Rule 57)] - The *continue* statement **shall not** be used.
-   [JSV AV Rule 191 (MISRA C Rule 58)] - The *break* statement **shall not** be used (except to terminate the cases of a *switch* statement).

    **Exception**: The *break* statement may be used to “break” out of a single loop provided the alternative would obscure or otherwise significantly complicate the control logic.

-   [JSV AV Rule 192 (MISRA C Rule 60, Revised)] - All *if*, *else if* constructs **will** contain either a final *else* clause or a comment indicating why a final *else* clause is not necessary.

    Note: This rule only applies when an *if* statement is followed by one or more *else if*’s.

-   [JSV AV Rule 193 (MISRA C Rule 61)] - Every non-empty *case* clause in a switch statement **shall** be terminated with a *break* statement.
-   [JSV AV Rule 194 (MISRA C Rule 62, Revised)] - All *switch* statements that do not intend to test for every enumeration value **shall** contain a final *default* clause.

    MISRA revised with shall replacing should.

-   [JSV AV Rule 195 (MISRA C Rule 63)] - A *switch* expression **will not** represent a Boolean value.
-   [JSV AV Rule 196 (MISRA C Rule 64, Revised)] - Every *switch* statement **will** have at least two *cases* and a potential *default*.

### Iteration statements

-   [MISRA C++ Rule 6–5–1, Required] - A *for* loop shall contain a single *loop-counter* which **shall not** have floating type.
-   [MISRA C++ Rule 6–5–2, Required] - If *loop-counter* is not modified by `--` or `++`, then, within *condition*, the *loop-counter* **shall** only be used as an operand to `<=`, `<`, `>` or `>=`.
-   [MISRA C++ Rule 6–5–3, Required] - The *loop-counter* **shall not** be modified within *condition* or *statement*.
-   [MISRA C++ Rule 6–5–4, Required] - The *loop-counter* **shall** be modified by one of: `--`, `++`, `-=n`, or `+=n`; where `n` remains constant for the duration of the loop.
-   [MISRA C++ Rule 6–5–5, Required] - A *loop-control-variable* other than the *loop-counter* **shall not** be modified within *condition* or *expression*.
-   [MISRA C++ Rule 6–5–6, Required] - A *loop-control-variable* other than the *loop-counter* which is modified in *statement* **shall** have type *bool*.
-   [JSV AV Rule 197 (MISRA C Rule 65)] - Floating point variables **shall not** be used as loop counters.
-   [JSV AV Rule 198] - The initialization expression in a *for* loop **will** perform no actions other than to initialize the value of a single *for* loop parameter.

    Note that the initialization expression may invoke an accessor that returns an initial element in a sequence:

-   [JSV AV Rule 199] - The increment expression in a *for* loop **will** perform no action other than to change a single loop parameter to the next value for the loop.
-   [JSV AV Rule 200] - Null initialize or increment expressions in *for* loops **will not** be used; a *while* loop will be used instead.
-   [JSV AV Rule 201 (MISRA C Rule 67, Revised)] - Numeric variables being used within a *for* loop for iteration counting **shall not** be modified in the body of the loop.

    MISRA C Rule 67 was revised by changing should to shall.

### Jump statements

-   [MISRA C++ Rule 6–6–1, Required] - Any label referenced by a *goto* statement **shall** be declared in the same block, or in a block enclosing the *goto* statement.
-   [MISRA C++ Rule 6–6–2, Required] - The *goto* statement **shall** jump to a label declared later in the same function body.
-   [MISRA C++ Rule 6–6–3, Required] - The *continue* statement **shall** only be used within a *well-formed for loop*.
-   [MISRA C++ Rule 6–6–4, Required] - For any iteration statement there **shall** be no more than one *break* or *goto* statement used for loop termination.
-   [MISRA C++ Rule 6–6–5, Required] - A function **shall** have a single point of exit at the end of the function.

Declarations
------------

### General

-   [MISRA C++ Rule 8–0–1, Required] - An *init-declarator-list* or a *member-declarator-list* **shall** consist of a single *init-declarator* or *member-declarator* respectively.
-   [JSF AV Rule 135 (MISRA C Rule 21, Revised)] - Identifiers in an inner scope **shall not** use the same name as an identifier in an outer scope, and therefore hide that identifier.
-   [JSF AV Rule 136 (MISRA C Rule 22, Revised)] - Declarations **should** be at the smallest feasible scope. (See also AV Rule 143).
-   [JSF AV Rule 137 (MISRA C Rule 23)] - All declarations at file scope **should** be static where possible.
-   [JSF AV Rule 138 (MISRA C Rule 24)] - Identifiers **shall not** simultaneously have both internal and external linkage in the same translation unit.
-   [JSF AV Rule 139 (MISRA C Rule 27)] - External objects **will not** be declared in more than one file. (See also AV Rule 39.)
-   [JSF AV Rule 140 (MISRA C Rule 28, Revised)] - The *register* storage class specifier **shall not** be used.
-   [JSF AV Rule 141] - A class, structure, or enumeration **will not** be declared in the definition of its type.

### Meaning of declarators

-   [MISRA C++ Rule 8–3–1, Required] - Parameters in an overriding virtual function **shall** either use the same default arguments as the function they override, or else shall not specify any default arguments.

### Specifiers

-   [MISRA C++ Rule 7–1–1, Required] - A variable which is not modified **shall** be *const* qualified.
-   [MISRA C++ Rule 7–1–2, Required] - A pointer or reference parameter in a function **shall** be declared as pointer to const or reference to const if the corresponding object is not modified.

### Enumeration declarations

-   [MISRA C++ Rule 7–2–1, Required] - An expression with *enum underlying type* **shall** only have values corresponding to the enumerators of the enumeration.

### Namespaces

-   [MISRA C++ Rule 7–3–1, Required] - The global namespace **shall** only contain main, namespace declarations and *extern "C"* declarations.
-   [JSF AV Rule 98] - Every nonlocal name, except main(), **should** be placed in some namespace. See Stroustrup [2], 8.2.
-   [MISRA C++ Rule 7–3–2, Required] - The identifier *main* **shall not** be used for a function other than the global function *main*.
-   [MISRA C++ Rule 7–3–3, Required] - There **shall** be no unnamed namespaces in *header files*.
-   [MISRA C++ Rule 7–3–4, Required] - *using-directives* **shall not** be used.
-   [MISRA C++ Rule 7–3–5, Required] - Multiple declarations for an identifier in the same namespace **shall not** straddle a *using-declaration* for that identifier.
-   [MISRA C++ Rule 7–3–6, Required] - *using-directives* and *using-declarations* (excluding class scope or function scope *using-declarations*) **shall not** be used in *header files*.
-   [JSF AV Rule 99] - Namespaces **will not** be nested more than two levels deep.
-   [JSF AV Rule 100] - Elements from a namespace **should** be selected as follows:
    -   using declaration or explicit qualification for few (approximately five) names,
    -   using directive for many names.

### The *asm* declaration

-   [MISRA C++ Rule 7–4–1, Document] - All usage of assembler **shall** be documented.
-   [MISRA C++ Rule 7–4–2, Required] - Assembler instructions **shall** only be introduced using the *asm* declaration.
-   [MISRA C++ Rule 7–4–3, Required] - Assembly language **shall** be encapsulated and isolated.

### Linkage specifications

-   [MISRA C++ Rule 7–5–1, Required] - A function **shall not** return a reference or a pointer to an automatic variable (including parameters), defined within the function.
-   [MISRA C++ Rule 7–5–2, Required] - The address of an object with automatic storage **shall not** be assigned to another object that may persist after the first object has ceased to exist.
-   [JSV AV Rule 173 (MISRA C Rule 106, Revised)] - The address of an object with automatic storage **shall not** be assigned to an object which persists after the object has ceased to exist.
-   [MISRA C++ Rule 7–5–3, Required] - A function **shall not** return a reference or a pointer to a parameter that is passed by reference or const reference.
-   [MISRA C++ Rule 7–5–4, Advisory] - Functions **should not** call themselves, either directly or indirectly.

Definitions
-----------

### Function definitions

-   [MISRA C++ Rule 8–4–1, Required] - Functions **shall not** be defined using the ellipsis notation.
-   [MISRA C++ Rule 8–4–2, Required] - The identifiers used for the parameters in a re-declaration of a function **shall** be identical to those in the declaration.
-   [MISRA C++ Rule 8–4–3, Required] - All exit paths from a function with non-*void* return type **shall** have an explicit *return* statement with an expression.
-   [MISRA C++ Rule 8–4–4, Required] - A function identifier **shall** either be used to call the function or it **shall** be preceded by &.
-   ~~[JSF AV Rule 58] - When declaring and defining functions with more than two parameters, the leading parenthesis and the first argument **will** be written on the same line as the function name. Each additional argument **will** be written on a separate line (with the closing parenthesis directly after the last argument).~~
-   [JSF AV Rule 107 (MISRA C Rule 68)] - Functions **shall** always be declared at file scope.
-   [JSF AV Rule 108 (MISRA C Rule 69)] - Functions with variable numbers of arguments **shall not** be used.
-   [JSF AV Rule 109] - A function definition **should not** be placed in a class specification unless the function is intended to be inlined.
-   [JSF AV Rule 110] - Functions with more than 7 arguments **will not** be used.
-   [JSF AV Rule 111] - A function **shall not** return a pointer or reference to a non-static local object.
-   [JSF AV Rule 112] - Function return values **should not** obscure resource ownership.
-   [JSF AV Rule 113 (MISRA C Rule 82, Revised)] - Functions **will** have a single exit point.

    **Exception**: A single exit is not required if such a structure would obscure or otherwise significantly complicate (such as the introduction of additional variables) a function’s control logic. Note that the usual resource clean-up must be managed at all exit points.

-   [JSF AV Rule 114 (MISRA C Rule 83, Revised)] - All exit points of value-returning functions **shall be** through return statements.
-   [JSF AV Rule 115 (MISRA C Rule 86)] - If a function returns error information, then that error information **will** be tested.
-   [JSF AV Rule 116] - Small, concrete-type arguments (two or three words in size) **should** be passed by value if changes made to formal parameters should not be reflected in the calling function.
-   [JSF AV Rule 117] - Arguments **should** be passed by reference if NULL values are not possible:
    -   [JSF AV Rule 117.1] - An object **should** be passed as *const T&* if the function should not change the value of the object.
    -   [JSF AV Rule 117.2] - An object **should** be passed as *T&* if the function may change the value of the object.
-   [JSF AV Rule 118] - Arguments **should** be passed via pointers if NULL values are possible:
    -   [JSF AV Rule 118.1] - An object **should** be passed as *const T\** if its value should not be modified.
    -   [JSF AV Rule 118.2] - An object **should** be passed as *T\** if its value may be modified.
-   [JSF AV Rule 119 (MISRA C Rule 70)] - Functions **shall not** call themselves, either directly or indirectly (i.e. recursion **shall not** be allowed).

    **Exception**: Recursion will be permitted under the following circumstances:

    1.  development of SEAL 3 or general purpose software, or
    2.  it can be proven that adequate resources exist to support the maximum level of recursion possible.
-   [JSF AV Rule 120] - Overloaded operations or methods **should** form families that use the same semantics, share the same name, have the same purpose, and that are differentiated by formal parameters.

### Inline Functions

-   [JSF AV Rule 121] - Only functions with 1 or 2 statements **should** be considered candidates for inline functions.
-   [JSF AV Rule 122] - Trivial accessor and mutator functions **should** be inlined.
-   [JSF AV Rule 123] - The number of accessor and mutator functions **should** be minimised.

    **Rationale**: Numerous accessors and mutators may indicate that a class simply serves to aggregate a collection of data rather than to embody an abstraction with a well-defined state or invariant. In this case, a struct with public data may be a better alternative (see section 4.10.2, AV Rule 65, and AV Rule 66).

-   [JSF AV Rule 124] - Trivial forwarding functions **should** be inlined.

### Initialisation

-   [MISRA C++ Rule 8–5–1, Required] - All variables **shall** have a defined value before they are used.
-   [MISRA C++ Rule 8–5–2, Required] - Braces **shall** be used to indicate and match the structure in the non- zero initialization of arrays and structures.
-   [MISRA C++ Rule 8–5–3, Required] - In an enumerator list, the = construct **shall not** be used to explicitly initialize members other than the first, unless all items are explicitly initialized.
-   [JSF AV Rule 142 (MISRA C Rule 30, Revised)] - All variables **shall** be initialized before use. (See also AV Rule 136, AV Rule 71, and AV Rule 73, and AV Rule 143 concerning declaration scope, object construction, default constructors, and the point of variable introduction respectively.)

    **Exception**: Exceptions are allowed where a name must be introduced before it can be initialized (e.g. value received via an input stream).

-   [JSF AV Rule 143] - Variables **will not** be introduced until they can be initialized with meaningful values. (See also AV Rule 136, AV Rule 142, and AV Rule 73 concerning declaration scope, initialization before use, and default constructors respectively.)
-   [JSF AV Rule 144 (MISRA C Rule 31)] - Braces **shall** be used to indicate and match the structure in the non-zero initialization of arrays and structures.
-   [JSF AV Rule 145 (MISRA C Rule 32)] - In an enumerator list, the ‘=‘ construct **shall not** be used to explicitly initialize members other than the first, unless all items are explicitly initialised.

Classes
-------

-   [JSF AV Rule 64] - A class interface **should** be complete and minimal. See Meyers [6], item 18.
-   [JSF AV Rule 70] - A class **will** have friends only when a function or object requires access to the private elements of the class, but is unable to be a member of the class for logical or efficiency reasons.
-   [JSF AV Rule 84] - Operator overloading **will** be used sparingly and in a conventional manner.
-   [JSF AV Rule 85] - When two operators are opposites (such as == and !=), both **will** be defined and one **will** be defined in terms of the other.

### Member functions

-   [JSF AV Rule 69] - A member function that does not affect the state of an object (its instance variables) **will** be declared *const*.

    **Rationale**: Member functions should be *const* by default. Only when there is a clear, explicit reason should the *const* modifier on member functions be omitted.

-   [MISRA C++ Rule 9–3–1, Required] - const member functions **shall not** return non-const pointers or references to *class-data*.
-   [MISRA C++ Rule 9–3–2, Required] - Member functions **shall not** return non-*const* *handles* to *class-data*.
-   [MISRA C++ Rule 9–3–3, Required] - If a member function can be made *static* then it **shall** be made *static*, otherwise if it can be made *const* then it **shall** be made *const*.
-   [JSF AV Rule 68] - Unneeded implicitly generated member functions **shall** be explicitly disallowed. See Meyers [6], item 27.

    Note: If the copy constructor is explicitly disallowed, the assignment operator should be as well.

### Unions

-   [MISRA C++ Rule 9–5–1, Required] - Unions **shall not** be used.
-   [JSF AV Rule 153 (MISRA C Rule 110, Revised)] - Unions **shall not** be used.

### Bit-fields

-   [MISRA C++ Rule 9–6–1, Document] - When the absolute positioning of bits representing a bit-field is required, then the behaviour and packing of bit-fields **shall** be documented.
-   [MISRA C++ Rule 9–6–2, Required] - Bit-fields **shall** be either bool type or an explicitly *unsigned* or *signed* integral type.
-   [MISRA C++ Rule 9–6–3, Required] - Bit-fields **shall not** have enum type.
-   [MISRA C++ Rule 9–6–4, Required] - Named bit-fields with *signed* integer type **shall** have a length of more than one bit.
-   [JSF AV Rule 154 (MISRA Rules 111 and 112, Revised)] - Bit-fields **shall** have explicitly unsigned integral or enumeration types only.

    Note: MISRA C Rule 112 no longer applies since it discusses a two-bit minimum-length requirement for bit-fields of signed types.

-   [JSF AV Rule 155] - Bit-fields **will not** be used to pack data into a word for the sole purpose of saving space.

    Note: Bit-packing should be reserved for use in interfacing to hardware or conformance to communication protocols.

    **Warning**: Certain aspects of bit-field manipulation are implementation-defined.

-   [JSF AV Rule 156 (MISRA C Rule 113)] - All the members of a structure (or class) **shall** be named and shall only be accessed via their names.

    **Exception**: An unnamed bit-field of width zero may be used to specify alignment of the next bit-field at an allocation boundary. [10], 9.6(2)

Derived classes
---------------

### Inheritance

Class hierarchies are appropriate when run-time selection of implementation is required. If run-time resolution is not required, template parameterization should be considered (templates are better-behaved and faster than virtual functions). Finally, simple independent concepts should be expressed as concrete types. The method selected to express the solution should be commensurate with the complexity of the problem.

The following rules provide additional detail and guidance when considering the structure of inheritance hierarchies.

-   [JSF AV Rule 86] - Concrete types **should** be used to represent simple independent concepts. See Stroustrup [2], 25.2.

    [ILG] - Concrete types behave ‘‘just like built-in types.’’

-   [JSF AV Rule 87] - Hierarchies **should** be based on abstract classes. See Stroustrup [2], 12.5.
-   [JSF AV Rule 90] - Heavily used interfaces **should** be minimal, general and abstract. See Stroustrup [2] 23.4.
-   [JSF AV Rule 91] - Public inheritance **will** be used to implement “is-a” relationships. See Meyers [6], item 35.

    **Rationale**: In contrast to public inheritance, private and protected inheritance means “is-implemented- in-terms-of”. It is purely an implementation technique—the interface is ignored.

-   [JSF AV Rule 92] - A subtype (publicly derived classes) **will** conform to the following guidelines with respect to all classes involved in the polymorphic assignment of different subclass instances to the same variable or parameter during the execution of the system:
    -   Preconditions of derived methods must be at least as weak as the preconditions of the methods they override.
    -   Postconditions of derived methods must be at least as strong as the postconditions of the methods they override.


    In other words, subclass methods must expect less and deliver more than the base class methods they override. This rule implies that subtypes will conform to the [Liskov Substitution Principle](https://en.wikipedia.org/wiki/Liskov_substitution_principle).

-   [JSF AV Rule 93] - “has-a” or “is-implemented-in-terms-of” relationships **will** be modeled through membership or non-public inheritance. See Meyers [6], item 40.
-   [JSF AV Rule 94] - An inherited nonvirtual function **shall not** be redefined in a derived class. See Meyers [6], item 37.
-   [JSF AV Rule 95] - An inherited default parameter **shall** never be redefined. See Meyers [6], item 38.
-   [JSF AV Rule 96] - Arrays **shall not** be treated polymorphically. See Meyers [7], item 3.
-   [JSF AV Rule 97] - Arrays **shall not** be used in interfaces. Instead, the *Array* class should be used.

### Multiple base classes

-   [JSF AV Rule 88] - Multiple inheritance **shall** only be allowed in the following restricted form: *n* interfaces plus *m* private implementations, plus at most one protected implementation.

    [ILG] - this is a complex rule; for more details please consider JSF Appendix A page 98.

-   [JSF AV Rule 88.1] - A stateful virtual base **shall** be explicitly declared in each derived class that accesses it.

    Example:


    struct A {};

    struct B : virtual A {};

    struct C : virtual A {};

    struct D : B, virtual A {};

    struct E : C, virtual A {};

    struct F : D, E, virtual A {};

-   [MISRA C++ Rule 10–1–1, Advisory] - Classes **should not** be derived from virtual bases.

    [ILG] - JSF is more permissive, see above conditions.

-   [MISRA C++ Rule 10–1–2, Required] - A base class **shall** only be declared virtual if it is used in a diamond hierarchy.
-   [MISRA C++ Rule 10–1–3, Required] - An accessible base class **shall not** be both virtual and non-virtual in the same hierarchy.
-   [JSF AV Rule 89] - A base class **shall not** be both virtual and non-virtual in the same hierarchy.

### Member name lookup

-   [MISRA C++ Rule 10–2–1, Advisory] - All accessible entity names within a multiple inheritance hierarchy **should** be *unique*.

### Virtual functions

-   [MISRA C++ Rule 10–3–1, Required] - There **shall** be no more than one definition of each virtual function on each path through the inheritance hierarchy.
-   [MISRA C++ Rule 10–3–2, Required] - Each overriding virtual function **shall** be declared with the *virtual* keyword.
-   [MISRA C++ Rule 10–3–3, Required] - A virtual function **shall** only be overridden by a *pure virtual function* if it is itself declared as *pure virtual*.
-   [JSF AV Rule 97.1] - Neither operand of an equality operator (== or !=) **shall** be a pointer to a virtual member function.

### Testing

-   [JSV AV Rule 219] - All tests applied to a base class interface **shall** be applied to all derived class interfaces as well. If the derived class poses stronger postconditions/invariants, then the new postconditions /invariants shall be substituted in the derived class tests.

    Note: This rule will often imply that every test case appearing in the set of test cases associated with a class will also appear in the set of test cases associated with each of its derived classes.

-   [JSV AV Rule 220] - Structural coverage algorithms **shall** be applied against *flattened* classes.

    Note: When a class is viewed with respect to all of its components (both defined at the derived level as well as inherited from all of its base levels) it is said to be *flattened*.

-   [JSV AV Rule 221] - Structural coverage of a class within an inheritance hierarchy containing virtual functions **shall** include testing every possible resolution for each set of identical polymorphic references.

Member access control
---------------------

### General

-   [MISRA C++ Rule 11–0–1, Required] - Member data in non-*POD* class types **shall** be private.
-   [JSF AV Rule 57] - The public, protected, and private sections of a class **will** be declared in that order (the public section is declared before the protected section which is declared before the private section).
-   [JSF AV Rule 65] - A structure **should** be used to model an entity that does not require an invariant.

    [ILG] - in other words, an entity that essentially aggregates data.

-   [JSF AV Rule 66] - A class **should** be used to model an entity that maintains an invariant.

    [ILG] - in other words, an entity that provides an abstraction while maintaining a well-defined state.

-   [JSF AV Rule 67] - Public and protected data **should** only be used in structs - not classes.

    **Exception**: Protected members may be used in a class as long as that class does not participate in a client interface. See AV Rule 88.

Special member functions
------------------------

### Constructors

-   [MISRA C++ Rule 12–1–1, Required] - An object’s dynamic type **shall not** be used from the body of its constructor or destructor.
-   [MISRA C++ Rule 12–1–2, Advisory] - All constructors of a class **should** explicitly call a constructor for all of its immediate base classes and all virtual base classes.
-   [MISRA C++ Rule 12–1–3, Required] - All constructors that are callable with a single argument of fundamental type **shall** be declared *explicit*.
-   [JSF AV Rule 70.1] - An object **shall not** be improperly used before its lifetime begins or after its lifetime ends.
-   [JSF AV Rule 71] - Calls to an externally visible operation of an object, other than its constructors, **shall not** be allowed until the object has been fully initialised.
-   [JSF AV Rule 71.1] - A class’s virtual functions **shall not** be invoked from its destructor or any of its constructors.
-   [JSF AV Rule 72] - The invariant for a class **should** be:
    -   a part of the postcondition of every class constructor,
    -   a part of the precondition of the class destructor (if any),
    -   a part of the precondition and postcondition of every other publicly accessible operation.
-   [JSF AV Rule 73] - Unnecessary default constructors shall not be defined. See Meyers [7], item 4. (See also AV Rule 143).
-   [JSF AV Rule 74] - Initialization of nonstatic class members **will** be performed through the member initialisation list rather than through assignment in the body of a constructor. See Meyers [6], item 12.

    **Exception**: Assignment should be used when an initial value cannot be represented by a simple expression (e.g. initialization of array values), or when a name must be introduced before it can be initialized (e.g. value received via an input stream).

-   [JSF AV Rule 75] - Members of the initialization list **shall** be listed in the order in which they are declared in the class. See Stroustrup [2], 10.4.5 and Meyers [6], item 13.

    Note: Since base class members are initialised before derived class members, base class initializers should appear at the beginning of the member initialization list.

-   [JSF AV Rule 76] - A copy constructor and an assignment operator **shall** be declared for classes that contain pointers to data items or nontrivial destructors. See Meyers [6], item 11.

    Note: See also AV Rule 80 which indicates that default copy and assignment operators are preferable when those operators offer reasonable semantics.

-   [JSF AV Rule 77] - A copy constructor **shall** copy all data members and bases that affect the class invariant (a data element representing a cache, for example, would not need to be copied).

    Note: If a reference counting mechanism is employed by a class, a literal copy need not be performed in every case. See also AV Rule 83.

-   [JSF AV Rule 77.1] - The definition of a member function **shall not** contain default arguments that produce a signature identical to that of the implicitly-declared copy constructor for the corresponding class/structure.
-   [JSF AV Rule 78] - All base classes with a virtual function **shall** define a virtual destructor.

    Note: This rule does not imply the use of dynamic memory (allocation/deallocation from the free store) will be used. See AV Rule 206.

-   [JSF AV Rule 79] - All resources acquired by a class **shall** be released by the class’s destructor. See Stroustrup [2], 14.4 and Meyers [7], item 9.
-   [JSF AV Rule 80] - The default copy and assignment operators **will** be used for classes when those operators offer reasonable semantics.

### Copying class objects

-   [MISRA C++ Rule 12–8–1, Required] - A copy constructor **shall** only initialize its base classes and the non- static members of the class of which it is a member.
-   [MISRA C++ Rule 12–8–2, Required] - The copy assignment operator **shall** be declared *protected* or *private* in an abstract class.

Templates
---------

The following guidelines provided by Stroustrup[2], 13.8, offer advice when to prefer the use of templates over the use of inheritance:

1.  Prefer a template over derived classes when run-time efficiency is at a premium.
2.  Prefer derived classes over a template if adding new variants without recompilation is important.
3.  Prefer a template over derived classes when no common base can be defined.
4.  Prefer a template over derived classes when built-in types and structures with compatibility constraints are important.

### Template declarations

-   [MISRA C++ Rule 14–5–1, Required] - A non-member *generic function* **shall** only be declared in a namespace that is not an *associated namespace*.
-   [MISRA C++ Rule 14–5–2, Required] - A *copy constructor* **shall** be declared when there is a template constructor with a single parameter that is a *generic parameter*.
-   [MISRA C++ Rule 14–5–3, Required] - A *copy assignment operator* **shall** be declared when there is a template assignment operator with a parameter that is a *generic parameter*.
-   [JSF AV Rule 101] - Templates **shall** be reviewed as follows:
    1.  with respect to the template in isolation considering assumptions or requirements placed on its arguments.
    2.  with respect to all functions instantiated by actual arguments.


    Note: The compiler should be configured to generate the list of actual template instantiations.

-   [JSF AV Rule 102] - Template tests **shall** be created to cover all actual template instantiations.

    Note: The compiler should be configured to generate the list of actual template instantiations.

-   [JSF AV Rule 103] - Constraint checks **should** be applied to template arguments.

### Name resolution

-   [MISRA C++ Rule 14–6–1, Required] - In a class template with a dependent base, any name that may be found in that dependent base **shall** be referred to using a *qualified-id* or `this->`.
-   [MISRA C++ Rule 14–6–2, Required] - The function chosen by overload resolution **shall** resolve to a function declared previously in the translation unit.

### Template instantiation and specialisation

-   [MISRA C++ Rule 14–7–1, Required] - All class templates, function templates, class template member functions and class template static members **shall** be instantiated at least once.
-   [MISRA C++ Rule 14–7–2, Required] - For any given template specialization, an explicit instantiation of the template with the *template-arguments* used in the specialization **shall not** render the program ill-formed.
-   [MISRA C++ Rule 14–7–3, Required] - All partial and explicit specializations for a template **shall** be declared in the same file as the declaration of their *primary template*.
-   [JSF AV Rule 104] - A template specialization **shall** be declared before its use. See Stroustrup [2], 13.5.
-   [JSF AV Rule 105] - A template definition’s dependence on its instantiation contexts **should** be minimized. See Stroustrup [2], 13.2.5 and C.13.8.
-   [JSF AV Rule 106] - Specializations for pointer types **should** be made where appropriate. See Stroustrup [2], 13.5.

### Function template specialisation

-   [MISRA C++ Rule 14–8–1, Required] - Overloaded function templates **shall not** be explicitly specialized.
-   [MISRA C++ Rule 14–8–2, Advisory] - The viable *function set* for a function call **should** either contain no function specializations, or only contain function specialisations.

Exception handling
------------------

### General

-   ~~[JSV AV Rule 208] - C++ exceptions **shall not** be used (i.e. throw, catch and try shall not be used.)~~

    [ILG] - until a thorough analyse of the implementation is completed, C++ exceptions **shall not** be used (to be further considered).

-   [MISRA C++ Rule 15–0–1, Document] - Exceptions **shall** only be used for error handling.

    [ILG] - Exceptions shall be used only for 'exceptional' error handling, i.e. events that during normal usage do not occur.

    [ILG] - Exceptions should not be used in time critical contexts (the time required between throw and catch cannot be computed, not even estimated).

-   [MISRA C++ Rule 15–0–2, Advisory] - An exception object **should not** have pointer type.
-   [MISRA C++ Rule 15–0–3, Required] - Control **shall not** be transferred into a *try* or *catch* block using a *goto* or a *switch* statement.

### Throwing an exception

-   [MISRA C++ Rule 15–1–1, Required] - The *assignment-expression* of a *throw* statement **shall not** itself cause an exception to be thrown.
-   [MISRA C++ Rule 15–1–2, Required] - *NULL* **shall not** be thrown explicitly.
-   [MISRA C++ Rule 15–1–3, Required] - An empty *throw* (`throw;`) **shall** only be used in the *compound-statement* of a *catch* handler.

### Handling an exception

-   [MISRA C++ Rule 15–3–1, Required] - Exceptions **shall** be raised only after start-up and before termination of the program.
-   [MISRA C++ Rule 15–3–2, Advisory] - There **should** be at least one exception handler to catch all otherwise unhandled exceptions.

    [ILG] - probably this advice applies per thread.

-   [MISRA C++ Rule 15–3–3, Required] - Handlers of a *function-try-block* implementation of a class constructor or destructor **shall not** reference non-static members from this class or its bases.
-   [MISRA C++ Rule 15–3–4, Required] - Each exception explicitly thrown in the code **shall** have a handler of a compatible type in all call paths that could lead to that point.
-   [MISRA C++ Rule 15–3–5, Required] - A class type exception **shall** always be caught by reference.
-   [MISRA C++ Rule 15–3–6, Required] - Where multiple handlers are provided in a single *try-catch* statement or *function-try-block* for a derived class and some or all of its bases, the handlers **shall** be ordered most-derived to base class.
-   [MISRA C++ Rule 15–3–7, Required] - Where multiple handlers are provided in a single *try-catch* statement or *function-try-block*, any ellipsis (catch-all) handler **shall** occur last.

### Exception specifications

-   [MISRA C++ Rule 15–4–1, Required] - If a function is declared with an exception-specification, then all declarations of the same function (in other translation units) **shall** be declared with the same set of type-ids.

### Special functions

-   [MISRA C++ Rule 15–5–1, Required] - A class destructor **shall not** exit with an exception.
-   [MISRA C++ Rule 15–5–2, Required] - Where a function’s declaration includes an exception-specification, the function **shall** only be capable of throwing exceptions of the indicated type(s).
-   [MISRA C++ Rule 15–5–3, Required] - The terminate() function **shall not** be called implicitly.

Preprocessing directives
------------------------

### General

-   [MISRA C++ Rule 16–0–1, Required] - *\#include* directives in a file **shall** only be preceded by other preprocessor directives or comments.
-   [MISRA C++ Rule 16–0–2, Required] - Macros **shall** only be *\#define*’d or *\#undef*’d in the global namespace.
-   [MISRA C++ Rule 16–0–3, Required] - *\#undef* **shall not** be used.
-   [MISRA C++ Rule 16–0–4, Required] - Function-like macros **shall not** be defined.
-   [MISRA C++ Rule 16–0–5, Required] - Arguments to a function-like macro **shall not** contain tokens that look like preprocessing directives.
-   [MISRA C++ Rule 16–0–6, Required] - In the definition of a function-like macro, each instance of a parameter **shall** be enclosed in parentheses, unless it is used as the operand of \# or \#\#.
-   [JSF AV Rule 29] - The *\#define* pre-processor directive **shall not** be used to create inline macros. Inline functions **shall** be used instead.
-   [JSF AV Rule 30] - The *\#define* pre-processor directive **shall not** be used to define constant values. Instead, the *const* qualifier **shall** be applied to variable declarations to specify constant values.

    The only exception to this rule is for constants that are commonly defined by third-party modules. For example, *\#define* is typically used to define *NULL* in standard header files. Consequently, *NULL* may be treated as a macro for compatibility with third-party tools.

-   [MISRA C++ Rule 16–0–7, Required] - Undefined macro identifiers **shall not** be used in *\#if* or *\#elif* preprocessor directives, except as operands to the defined operator.
-   [MISRA C++ Rule 16–0–8, Required] - If the \# token appears as the first token on a line, then it **shall** be immediately followed by a preprocessing token.
-   [JSF AV Rule 26] - Only the following pre-processor directives shall be used:
    1.  *\#ifndef*
    2.  *\#define*
    3.  *\#endif*
    4.  *\#include*
-   [JSF AV Rule 27] - *\#ifndef*, *\#define* and *\#endif* **will** be used to prevent multiple inclusions of the same header file. Other techniques to prevent the multiple inclusions of header files **will not** be used.
-   [JSF AV Rule 28] - The *\#ifndef* and *\#endif* pre-processor directives will only be used as defined in AV Rule 27 to prevent multiple inclusions of the same header file.
-   [JSF AV Rule 31] - The *\#define* pre-processor directive **will** only be used as part of the technique to prevent multiple inclusions of the same header file.

### Conditional inclusion

-   [MISRA C++ Rule 16–1–1, Required] - The *defined* preprocessor operator **shall** only be used in one of the two standard forms.

<!-- -->

     defined ( identifier )
     defined identifier

-   [MISRA C++ Rule 16–1–2, Required] - All *\#else*, *\#elif* and *\#endif* preprocessor directives **shall** reside in the same file as the *\#if* or *\#ifdef* directive to which they are related.

### Source file inclusion

-   [MISRA C++ Rule 16–2–1, Required] - The pre-processor **shall** only be used for file inclusion and include guards.
-   [MISRA C++ Rule 16–2–2, Required] - C++ macros **shall** only be used for: include guards, type qualifiers, or storage class specifiers.
-   [MISRA C++ Rule 16–2–3, Required] - Include guards **shall** be provided.
-   [MISRA C++ Rule 16–2–4, Required] - The ', ", /\* or // characters **shall not** occur in a header file name.
-   [MISRA C++ Rule 16–2–5, Advisory] - The \\ character **should not** occur in a header file name.
-   [MISRA C++ Rule 16–2–6, Required] - The *\#include* directive **shall** be followed by either a *<filename>* or *"filename"* sequence.
-   [JSF AV Rule 32] - The *\#include* pre-processor directive **will** only be used to include header (\*.h) files.

    **Exception**: In the case of template class or function definitions, the code may be partitioned into separate header and implementation files. In this case, the implementation file may be included as a part of the header file. The implementation file is logically a part of the header and is not separately compilable.

-   [JSF AV Rule 33] - The *\#include* directive **shall** use the <filename.h> notation to include header files.
-   [JSF AV Rule 34] - Header files **should** contain logically related declarations only.
-   [JSF AV Rule 35] - A header file **will** contain a mechanism that prevents multiple inclusions of itself.
-   [JSF AV Rule 36] - Compilation dependencies **should** be minimized when possible. (Stroustrup [2], Meyers [6], item 34)
-   [JSF AV Rule 37] - Header (include) files **should** include only those header files that are required for them to successfully compile. Files that are only used by the associated .cpp file should be placed in the .cpp file - not the .h file.
-   [JSF AV Rule 38] - Declarations of classes that are only accessed via pointers (\*) or references (&) **should** be supplied by forward headers that contain only forward declarations.
-   [JSF AV Rule 39] - Header files (\*.h) **will not** contain non-const variable definitions or function definitions.

    **Exception**: Inline functions and template definitions may be included in header files.

-   [JSF AV Rule 40] - Every implementation file **shall** include the header files that uniquely define the inline functions, types, and templates used.

### Macro replacement

-   [MISRA C++ Rule 16–3–1, Required] - There **shall** be at most one occurrence of the \# or \#\# operators in a single macro definition.
-   [MISRA C++ Rule 16–3–2, Advisory] - The \# and \#\# operators **should not** be used.

### Pragma directive

-   [MISRA C++ Rule 16–6–1, Document] - All uses of the *\#pragma* directive **shall** be documented.

### Library introduction - General

-   [MISRA C++ Rule 17–0–1, Required] - Reserved identifiers, macros and functions in the standard library **shall not** be defined, redefined or undefined.
-   [MISRA C++ Rule 17–0–2, Required] - The names of standard library macros and objects **shall not** be reused.
-   [MISRA C++ Rule 17–0–3, Required] - The names of standard library functions **shall not** be overridden.
-   [MISRA C++ Rule 17–0–4, Document] - All library code **shall** conform to MISRA C++.
-   [MISRA C++ Rule 17–0–5, Required] - The *setjmp* macro and the *longjmp* function **shall not** be used.
-   ~~[JSF AV Rule 20 (MISRA C Rule 122)] - The *setjmp* macro and the *longjmp* function **shall not** be used.~~ (duplicate)

Language support library
------------------------

### General

-   [MISRA C++ Rule 18–0–1, Required] - The C library **shall not** be used.
-   [MISRA C++ Rule 18–0–2, Required] - The library functions *atof*, *atoi* and *atol* from library *<cstdlib>* **shall not** be used.
-   [JSF AV Rule 23 (MISRA C Rule 125] - The library functions *atof*, *atoi* and *atol* from library <stdlib.h> **shall not** be used.
-   [MISRA C++ Rule 18–0–3, Required] - The library functions *abort*, *exit*, *getenv* and *system* from library *<cstdlib>* **shall not** be used.
-   [JSF AV Rule 24 (MISRA C Rule 126] - The library functions *abort*, *exit*, *getenv* and *system* from library <stdlib.h> **shall not** be used.
-   [MISRA C++ Rule 18–0–4, Required] - The time handling functions of library *<ctime>* **shall not** be used.
-   [JSF AV Rule 25 (MISRA C Rule 127] - The time handling functions of library <time.h> **shall not** be used.
-   [MISRA C++ Rule 18–0–5, Required] - The unbounded functions of library *<cstring>* **shall not** be used.
-   [JSF AV Rule 19 (MISRA C Rule 121)] - <locale.h> and the *setlocale* function **shall not** be used.
-   [JSF AV Rule 16] - Only DO-178B level A [15] - certifiable or SEAL 1 C/C++ libraries shall be used with safety-critical (i.e. SEAL 1) code [13].

### Implementation properties

-   [MISRA C++ Rule 18–2–1, Required] - The macro *offsetof* **shall not** be used.
-   [JSF AV Rule 18 (MISRA C Rule 120)] - The macro *offsetof*, in library <stddef.h>, **shall not** be used.

### Dynamic memory management

-   [MISRA C++ Rule 18–4–1, Required] - Dynamic heap memory allocation **shall not** be used.
-   [JSV AV Rule 206 (MISRA C Rule 118, Revised)] - Allocation/deallocation from/to the free store (heap) **shall not** occur after initialization.

    Note that the “placement” *operator new()*, although not technically dynamic memory, may only be used in low-level memory management routines. See AV Rule 70.1 for object lifetime issues associated with placement *operator new()*.

-   [JSV AV Rule 207] - Unencapsulated global data **will** be avoided.

    Note: If multiple clients require access to a single resource, that resource should be wrapped in a class that manages access to that resource. For example, semantic controls that prohibit unrestricted access may be provided (e.g. singletons and input streams). See AV_Rule_207_Appendix_A for examples.

### Other runtime support

-   [MISRA C++ Rule 18–7–1, Required] - The signal handling facilities of *<csignal>* **shall not** be used.
-   [JSF AV Rule 21 (MISRA C Rule 123)] - The signal handling facilities of <signal.h> **shall not** be used.

Diagnostics library
-------------------

### Error numbers

-   [MISRA C++ Rule 19–3–1, Required] - The error indicator *errno* **shall not** be used.
-   ~~[JSF AV Rule 17 (MISRA C Rule 119)] - The error indicator *errno* **shall not** be used.~~ (duplicate)

    **Exception**: If there is no other reasonable way to communicate an error condition to an application, then *errno* may be used. For example, third party math libraries will often make use of *errno* to inform an application of underflow/overflow or out-of-range/domain conditions. Even in this case, *errno* should only be used if its design and implementation are well-defined and documented.

Input/output library
--------------------

### General

-   [MISRA C++ Rule 27–0–1, Required] - The stream input/output library *<cstdio>* **shall not** be used.
-   [JSF AV Rule 22 (MISRA C Rule 124, Revised)] - The input/output library <stdio.h> **shall not** be used.

Miscellaneous
-------------

### Style

Imposing constraints on the format of syntactic elements makes source code easier to read due to consistency in form and appearance.

-   [JSF AV Rule 41] - Source lines **will** be kept to a length of 120 characters or less.
-   [ILG Rule, Advisory] - Source lines **should** be kept to a length of 80 characters or less.
-   [JSF AV Rule 42] - Each expression-statement **will** be on a separate line.
-   [JSF AV Rule 43] - Tabs **should** be avoided.
-   [JSF AV Rule 44] - All indentations **will** be at least two spaces and be consistent within the same source file.
-   [JSF AV Rule 59 (MISRA C Rule 59, Revised)] - The statements forming the body of an *if*, *else if*, *else*, *while*, *do...while* or for statement shall always be enclosed in braces, even if the braces form an empty block.
-   ~~[JSF AV Rule 60] - Braces ("{}") which enclose a block will be placed in the same column, on separate lines directly before and after the block.~~
-   ~~[JSF AV Rule 61] - Braces ("{}") which enclose a block will have nothing else on the line except comments (if necessary).~~
-   [ILG Rule] - Indentation shall be consistent for all source files of a project.
-   [ILG Rule, Advisory] - The indentation style **should** be the GNU Style, preferably as implemented by default, without changes, by the IDE used for development (for example Eclipse CDT)
-   [JSF AV Rule 62] - The dereference operator ‘\*’ and the address-of operator ‘&’ **will** be directly connected with the type-specifier.
-   [JSF AV Rule 63] - Spaces **will not** be used around ‘.’ or ‘-\>’, nor between unary operators and operands.
-   [JSF AV Rule 152] - Multiple variable declarations shall not be allowed on the same line.
-   [JSV AV Rule 216] - Programmers **should not** attempt to prematurely optimize code. See Meyers [7], item 16.

    Note: This rule does not preclude early consideration of fundamental algorithmic and data structure efficiencies.

    See also AV Rule 125 and AV Rule 177 for performance recommendations.

-   [JSV AV Rule 218] - Compiler warning levels **will** be set in compliance with project policies.
-   [ILG Rule, Advisory] - Compiler warning levels **should** be set to maximum.

### Naming Files

-   [JSF AV Rule 53] - Header files **will** always have a file name extension of ".h".
-   [JSF AV Rule 53.1] - The following character sequences **shall not** appear in header file names: ‘, \\, /\*, //, or ".
-   [JSF AV Rule 54] - Implementation files **will** always have a file name extension of ".cpp".
-   [JSF AV Rule 55] - The name of a header file **should** reflect the logical entity for which it provides declarations.
-   [JSF AV Rule 56] - The name of an implementation file **should** reflect the logical entity for which it provides definitions and have a “.cpp” extension (this name will normally be identical to the header file that provides the corresponding declarations.)

    At times, more than one .cpp file for a given logical entity will be required. In these cases, a suffix should be appended to reflect a logical differentiation.

### Data Representation

-   [JSV AV Rule 210] - Algorithms **shall not** make assumptions concerning how data is represented in memory (e.g. big endian vs. little endian, base class subobject ordering in derived classes, nonstatic data member ordering across access specifiers, etc.)

    **Exception**: Low level routines that are expressly written for the purpose of data formatting (e.g. marshalling data, endian conversions, etc.) are permitted.

-   [JSV AV Rule 210.1] - Algorithms **shall not** make assumptions concerning the order of allocation of nonstatic data members separated by an access specifier. See also AV Rule 210 on data representation.
-   [JSV AV Rule 211] - Algorithms shall not assume that *shorts*, *ints*, *longs*, *floats*, *doubles* or *long doubles* begin at particular addresses.

    **Exception**: Low level routines that are expressly written for the purpose of data formatting (e.g. marshalling data, endian conversions, etc.) are permitted.
