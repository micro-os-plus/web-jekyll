---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSDeviceDebug/
title: Class OSDeviceDebug
author: Liviu Ionescu

date: 2011-02-25 13:09:25 +0000

---

OSDeviceDebug

-   The class OSDeviceDebug requires the definition of **DEBUG**.
-   If the **OS_INCLUDE_OSDEVICEDEBUG_STREAMBUF** is defined, this class is derived from **streambuf**.

Constructors
============

OSDeviceDebug()
---------------

**Description**


Initialize the internal members.

**Parameters**

:\* none

Methods
=======

static void putChar(unsigned char c)
------------------------------------

**Description**


Output, on debug interface, one character.

**Parameters**

:\* c - input, character to be output

**Return value**

:\* none

static void putNewLine(void)
----------------------------

**Description**


Output, on debug interface, CR+LF.

**Parameters**

:\* none

**Return value**

:\* none

static void putString(const char \*pc)
--------------------------------------

**Description**


Output, on debug interface, a string.

**Parameters**

:\* pc - input, the string to be output

**Return value**

:\* none

static void putString_P(const char \* PROGMEM pc)
--------------------------------------------------

**Description**


Output, on debug interface, the bytes at pc address, until the first zero byte. It requires the definition of OS_CONFIG_ARCH_AVR8.

**Parameters**

:\* pc - input, address of the first byte to be output

**Return value**

:\* none

static void putHex(unsigned char c)
-----------------------------------

**Description**


Output, on debug interface, the hex value of a byte; i.e. 2 hexadecimal characters.

**Parameters**

:\* c - input, character to be output

**Return value**

:\* none

static void putHex(unsigned short w)
------------------------------------

**Description**


Output, on debug interface, the hex value of a 2-byte word; i.e. 4 hexadecimal characters.

**Parameters**

:\* w - input, 2-byte word to be output

**Return value**

:\* none

static void putHex(unsigned long l)
-----------------------------------

**Description**


Output, on debug interface, the hex value of a 4-byte word; i.e. 8 hexadecimal characters. It requires the definition of OS_INCLUDE_OSDEVICEDEBUG_PUTHEX_LONG.

**Parameters**

:\* w - input, 4-byte word to be output

**Return value**

:\* none

static void putHex(unsigned int l)
----------------------------------

**Description**


Output, on debug interface, the hex value of a integer; i.e. 8 hexadecimal characters. It requires the definition of OS_INCLUDE_OSDEVICEDEBUG_PUTHEX_INT.

**Parameters**

:\* w - input, integer to be output

**Return value**

:\* none

== static void putDec(unsigned short w, unsigned short n = 0) == **Description**


Output, on debug interface, the decimal value of a 2-byte word, <n> last digits will not be output, max 5 decimal digits.

**Parameters**

:\* w - input, 2-byte word to be output

:\* n - input, number of last digital digits which will not be output

**Return value**

:\* none

== static void putDec(unsigned long l, unsigned short n = 0) == **Description**


Output, on debug interface, the decimal value of a 4-byte word, <n> last digits will not be output, max 10 decimal digits. It requires definition of OS_INCLUDE_OSDEVICEDEBUG_PUTDEC_LONG.

**Parameters**

:\* l - input, 4-byte word to be output

:\* n - input, number of last digital digits which will not be output

**Return value**

:\* none

static void putPtr(const void \*p)
----------------------------------

**Description**


Output, on debug interface, the address p, in hexadecimal.

**Parameters**

:\* p - input, the address to be output

**Return value**

:\* none

static void putPC(const char \* PROGMEM pc)
-------------------------------------------

**Description**


Output, on debug interface, the address p from program memory, in hexadecimal.

**Parameters**

:\* pc - input, the address to be output

**Return value**

:\* none

static void __assert(const char \*func, const char \*file, int lineno, const char \*sexp);
--------------------------------------------------------------------------------------------

**Description**


Output, on debug interface, function name, file name, line number and expression string. It is used in case of a failed assertion.

**Parameters**

:\* funct - input, the function name

:\* file - input, the filename

:\* lineno - input, the line number

:\* sexp - input, the string expression

**Return value**

:\* none

static void implWDReset(void)
-----------------------------

**Description**


Watchdog reset; implementation specific.

**Parameters**

:\* none

**Return value**

:\* none

static void earlyInit()
-----------------------

**Description**


Initialise debug interface and print greeting and build strings.

**Parameters**

:\* none

**Return value**

:\* none

Variables
=========
