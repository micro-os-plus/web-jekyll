---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/C++_source_code_style_guide/
title: C++ source code style guide
author: Liviu Ionescu

date: 2011-05-21 08:49:59 +0000

---

Overview
========

This document describes the recommended approaches for the format and structure of C++ source code files.

Scope
=====

The guide is aimed to developers creating and editing C++ source code files.

Environment
===========

This guide assumes the use of Eclipse CDT environment.

Recommended usage
=================

For consistency, it is strongly recommended to always use the Eclipse CDT formatter

-   **Eclipse** menu: **Source** → **Format**

C++ source code files
=====================

Formatting style
----------------

The general formatting style of µOS++ source code is the default Eclipse CDT GNU style.

Line length
-----------

Source code lines should never exceed 79 columns.

Spaces
------

### No space operators

The following binary operators are written with no space around them:

-   **-\>** - structure pointer operator - **me-\>foo**
-   **.** structure member operator - **s.foo**
-   **[]** - array subscription - **a[i]**
-   **()** - function call - **foo(x, y, z)**

The unary operators are written with no spaces between them and their operands:

-   **!p**
-   **\~b**
-   **++i**
-   **j--**
-   **(void\*)ptr**
-   **\*p**
-   **&x**
-   **-k**

### One space operators

The binary operators are preceded and followed by one (1) space, as is the ternary operator:

-   **c1 == c2**
-   **x + y**
-   **i += 2**
-   **(n \> 0) ? (n) : (-n)**

### One space keywords

The following keywords are followed by one (1) space:

-   **if**
-   **while**
-   **for**
-   **switch**
-   **return**

Explicit parenthesis
--------------------

In case of compound expressions, parenthesising should be used whenever the precedence is not "obvious". In general, over parenthesising is recommended to remove any doubt and guessing.

-   (a \< b) && (b \< c)
-   x = (a \* b) + c;

Indentation
-----------

All indentations must be exactly two (2) spaces to indicate scope.

Paired open and close parenthesis must have the same position:

    class Parser
    {
    public:
      Parser();
      ...
    protected:
      unsigned char* m_pLine;
      ...
    };

The statement following any of the keywords (if, else, while, for, switch, case, do) must be compound, that is, use of braces is obligatory, even if the actual statement is singular.

      if (condition)
        {
          i = 1;
        }
      else
        {
          i = 100;
        }

Separator lines
---------------

Use C++ comments, one space separator and continue up to column 79. If text is used, it comes after 5 dashes, and is delimited by spaces.


    // ----------------------------------------------------------------------------

    // ----- Static data ----------------------------------------------------------

    // ----- Constructors ---------------------------------------------------------
