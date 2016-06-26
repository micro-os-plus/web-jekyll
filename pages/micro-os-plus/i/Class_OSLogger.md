---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSLogger/
title: Class OSLogger
author: Liviu Ionescu

date: 2011-05-03 09:34:03 +0000

---

Overview
========

This class allows separate modules to set their own log level. Each module must have an instance of this class in order to log messages.

Constructors
============

OSLogger(const char\* name)
---------------------------

**Description**


Initialise the object with the specified name.

**Parameters**

:\* name - name of this logger instance.

**Return value**

:\* none

Methods
=======

void logError(logCode_t code, const char\* msg)
------------------------------------------------

**Description**


Log an error message. The Logger object must be register to the LogManager prior to use this method.

**Parameters**

:\* code - error code.

:\* msg - message to be logged. It's maximal size is 255 characters.

**Return value**

:\* none

void logWarning(logCode_t code, const char\* msg)
--------------------------------------------------

**Description**


Log a warning message. The Logger object must be register to the LogManager prior to use this method.

**Parameters**

:\* code - error code.

:\* msg - message to be logged. It's maximal size is 255 characters.

**Return value**

:\* none

void logInfo(logCode_t code, const char\* msg)
-----------------------------------------------

**Description**


Log an info message. The Logger object must be register to the LogManager prior to use this method.

**Parameters**

:\* code - error code.

:\* msg - message to be logged. It's maximal size is 255 characters.

**Return value**

:\* none

void logTrace(logCode_t code, const char\* msg)
------------------------------------------------

**Description**


Log a trace message. The Logger object must be register to the LogManager prior to use this method.

**Parameters**

:\* code - error code.

:\* msg - message to be logged. It's maximal size is 255 characters.

**Return value**

:\* none

char\* getName(void)
--------------------

**Description**


Return logger's name.

**Parameters**

:\* none

**Return value**

:\* The logger's name.

logLevel_t getLevel(void)
--------------------------

**Description**


Return logger's log level.

**Parameters**

:\* none

**Return value**

:\* The logger's log level.

void setLevel(logLevel_t level)
--------------------------------

**Description**


Set logger's log level.

**Parameters**

:\* level - the logger's log level.

**Return value**

:\* none.

static const char\* convertLevelToString(logLevel_t level)
-----------------------------------------------------------

**Description**


Convert log level for this logger to string, e.g. OS_ERROR to "error".

**Parameters**

:\* level - the log level to be translated.

**Return value**

:\* The string which contains the translated log level.

Member Variables
================

LogManager \*logManager
-----------------------


Pointer to the logManager at which this logger is registered.

logLevel_t m_minLevel
-----------------------


Minimum log level for the line to be logged.

const char\* m_name
--------------------


Logger's name.

