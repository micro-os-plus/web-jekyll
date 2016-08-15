---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Doxygen_style_guide_(SE)/
title: Doxygen style guide (SE)
author: Liviu Ionescu

date: 2014-02-22 16:04:18 +0000

---

Doxygen has many, many features, and accepts various syntaxes for its commands.

The recommended syntax is the one specific to to C++, with // for comments, and \\ for escape characters and commands.

/// Comments
------------

Use sequences of lines prefixed with /// instead of C style blocks of /\*\* \*/

Warning: be sure the sequence of /// lines is uninterrupted, otherwise the documentation will not refer to the same object.

\\ Commands
-----------

Use \\ to prefix commands, instead of @.

Explicit \\brief
----------------

Explicitly use the \\brief command before the brief description. End the text with a dot. For visibility reasons, add an empty line inside the same comment block.

    /// \brief Base for all architecture implementation classes.
    ///

Explicit \\details
------------------

Explicitly use the \\details command, on a separate line, before the main documentation text.

For class member functions, the details should be placed before the implementation; although allowed by Doxygen, avoid placing details both at the declaration and definitions, since it is difficult to keep them consistent (see below).

    ///
    /// \details
    /// The TraceOstreamBase class implements an ostream class
    /// to be used by the Trace class.

Use \\brief with declarations and \\details with definitions
------------------------------------------------------------

Contrary to Java, the C++ sources are usually split between a .h file with declarations and a .cpp file with the method/functions definitions.

Always add the \\brief, \\param and \\return commands in the header file before the member declaration, and the detailed part of the documentation before the member definition (be it in .h for inline definitions or in .cpp for regular definitions).

Back apostrophes for references to code
---------------------------------------

Always use \`something\` instead of \\c something, or \\p something, or `<code>something`</code>.

Asterisks for italics
---------------------

Use asterisks to mark \*italics\* texts.

HTML \<b\> for bold
-------------------

Unfortunately Doxygen does not provide a bold metadata command, so the HTML \<b\>xyz\</b\> should be used.

Use \\code for sequences of source lines
----------------------------------------

When including lines of code, surround them by \\code, \\endcode and add the language. For visibility reasons, add empty lines inside the comment block.

    ///
    /// \code{.cpp}
    /// setClassName("os::infra::TestSuite");
    /// \endcode
    ///

Use \\verbatim for other pre-formatted lines
--------------------------------------------

When including other lines, like shell commands, surround them by \\verbatim, \\endverbatim:

    ///
    /// \verbatim
    /// /bin/bash micro-os-plus-se.git/scripts/runTests.sh
    /// \endverbatim
    ///

Lists
-----

Use - to enter bulleted lists, and -\# to enter numbered lists.

For multiple levels use additional indentations.

    - first level 1
      - first level 2
      - second level 2
    - second level 1

Tables
------

Use the below syntax to enter tables. Columns can be left/right aligned.

    | Right | Center | Left  |
    | ----: | :----: | :---- |
    | 10    | 10     | 10    |
    | 1000  | 1000   | 1000  |

External links
--------------

Links to other pages can be expressed with the following markup:

    [The link text](http://example.net/)

Use \\tparam for template parameters
------------------------------------

Use \\tparam for template parameters. Start the explanation with upper case and end it with dot.

    /// \tparam Implementation_T  Type of the implementation class.

Use \\param for function parameters
-----------------------------------

Use **\\param [in]** for usual input parameters, and occasionally **[out]** for output parameters. Start the explanation with upper case and end the line with a dot.

To make the explanation more readable, use tabs to right align the content.

    /// \param [in]  c  An additional character to consume.

If the function has no parameters, use a custom paragraph containing **None**, indented with a tab and terminated with a dot.

    /// \par Parameters
    ///    None.

Use \\return or \\retval for the returned result
------------------------------------------------

If the function returns discrete values, enumerate them with **\\retval** and terminate the list with an empty line.

    /// \retval -1 Error
    /// \retval 0 OK
    ///

If the function returns a scalar value, use a **\\return** and explain what the value represents.

    /// \return The number of bytes actually written.

If the function has no return value, use a custom paragraph containing **Nothing**, indented with a tab and terminated with a dot.

    /// \par Returns
    ///    Nothing.

Use \\headerfile to define the header full path
-----------------------------------------------

For each class, structure, enum or other object definition, use \\headerfile to specify the full header path.

    /// \headerfile CoreInterruptNumbers.h "hal/architecture/arm/cortexm/include/CoreInterruptNumbers.h"
    /// \nosubgrouping
    ///
    /// \brief ARM Cortex-M architecture interrupt numbers base
    /// \details
    /// Interrupt numbers defined by the Cortex-M0 light architecture.
    class CortexM0InterruptNumber ...

The first name should be present in the filesystem, so it might need some prefixing. The second name is passed to the output.

The comment block should be continuous to the object comments, otherwise the header file definition is not attached to the object.

Use \\nosubgrouping and \\name to define custom member grouping
---------------------------------------------------------------

For a better look, it is recommended to group class definitions based on their logic, instead of the default class visibility grouping.

Groups have names and descriptions (be sure the comments are continuous up to the **@{** opening brace).

It is recommended to repeat the name in the closing **@}** brace, as seen below.

For readability, use an empty line after opening braces and before closing braces.

Note: Groups do not nest.

    /// \name Standard template types
    ///
    /// These types permit a standardised way of
    /// referring to names of (or names dependent on) the template
    /// parameters, which are specific to the implementation. Except
    /// when referring to the template, (in which case the templates
    /// parameters are required), use these types everywhere
    /// else instead of usual types.
    /// @{

    typedef Implementation_T Implementation;

    /// @}  end of name Standard template types

    /// \name Constructors/destructor
    /// @{

    /// \brief  Base constructor.
    ///
    /// \param [in] implementation Reference to the implementation class.
    TTraceStreambufBase(Implementation& implementation);

    /// \brief  Base destructor.
    virtual
    ~TTraceStreambufBase();

    /// @} end of name Constructors/destructor

Template sample
---------------

    /// \headerfile Trace.h "portable/diagnostics/include/Trace.h"
    /// \ingroup diag
    /// \nosubgrouping
    ///
    /// \brief Trace light base class.
    ///
    /// \tparam Implementation_T  Type of the implementation class.
    ///
    /// \details
    /// This class provides no functionality, it is used only as a
    /// light alternative to TraceOstreamBase.
    template<class Implementation_T>
      class TTraceLightBase
      {
        ...
      };

Grouping
--------

### \\ingroup

To include a definition in one or more modules, use \\ingroup.

    /// \brief Stack size type.
    /// \ingroup core_thread
    ///

If multiple definition are from the same group, they can be grouped with **@{** ... **@}**:

    /// \ingroup core_thread
    /// @{
            <- mandatory empty line
    /// \brief Stack element type.
    typedef hal::arch::stackElement_t element_t;

    /// \brief Stack size type.
    typedef hal::arch::stackSize_t size_t;
            <- mandatory empty line
    /// @} end of ingroup core_thread

Please note the mandatory empty lines after **@{** and before **@}**.

Also please note that when using together with \\name, \\ingroup with must be inside \\name.

### \\name

This command allows to define the name of the section within a page. Usually it is used with **@{** ... **@}**:

    /// \name Constructors/destructor
    /// @{
            <- mandatory empty line
    /// \brief Constructor.
    MainThread(void);

    /// \brief Destructor.
    ~MainThread();
            <- mandatory empty line
    /// @} end of name Constructors/destructor

Recommended sections name are:

    /// \name Types and constants

    /// \name Constructors/destructor

    /// \name Operators

    /// \name Public member functions

    /// \name Private friends

    /// \name Private member variables
