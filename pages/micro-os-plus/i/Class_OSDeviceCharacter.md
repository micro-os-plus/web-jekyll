---
layout: old-wiki-page
permalink: /micro-os-plus/i/Class_OSDeviceCharacter/
title: Class OSDeviceCharacter
author: Liviu Ionescu

date: 2011-03-28 11:05:55 +0000

---

Classes hierarchy
=================

-   streambuf
    -   OSDeviceCharacter

The OSDeviceCharacter class may or may not derive from streambuf, based on configuration variables.

Children classes
================

-   [OSDeviceCharacterBuffered]({{ site.baseurl }}/micro-os-plus/i/Class_OSDeviceCharacterBuffered "wikilink")
-   [DeviceCharacterUsb]({{ site.baseurl }}/micro-os-plus/i/Class_DeviceCharacterUsb "wikilink")

Overview
========

The OSDeviceCharacter class is the parent class of all character devices in µOS++. A character device is defined as a device having the transfer unit as low as one ASCII character.

Example of such devices are USART, CDC USB.

OSDeviceCharacter is an abstract class, requiring children classes to implement the actual read/write code.

Constructors
============

OSDeviceCharacter(void)
-----------------------

**Description**


Initialize the character device with the default values.

**Parameters**

:\* none

**Return value**

:\* none

Methods
=======

OSReturn_t open(void)
----------------------

**Description**


Open the device. Block the calling task until the communication channel is established. For RS-232 devices, this usually means that the DTE activated the [DTR](http://en.wikipedia.org/wiki/Data_Terminal_Ready) signal to the DCE. If the device does not support ready signals, the open() will return immediately.

**Parameters**

:\* none

**Return value**

:\* status for this operation

OSReturn_t close(void)
-----------------------

**Description**


Close the device.

**Parameters**

:\* none

**Return value**

:\* status for this operation

bool isOpened(void) const
-------------------------

**Description**


Test if the device is opened.

**Parameters**

:\* none

**Return value**

:\* true if the device is opened

bool isConnected(void) const
----------------------------

**Description**


Test if the device is connected. On RS-232 devices, the connected status reflects the [DTR](http://en.wikipedia.org/wiki/Data_Terminal_Ready) control signal.

**Parameters**

:\* none

**Return value**

:\* true if the device is connected

void setBaudRate(unsigned long baud)
------------------------------------

**Description**


Set the communication baud rate. Must be called before **open()**, and the value remains efective for the entire communication session.

**Parameters**

:\* baud - baud rate in bits per second

**Return value**

:\* none

unsigned long getBaudRate(void)
-------------------------------

**Description**


Get the communication baud rate. May be different from the value set by **setBaudRate()**, some communication devices (like USB) get this baud rate during connection, reflecting the baud rate set by the peer.

**Parameters**

:\* none

**Return value**

:\* baud - baud rate in bits per second

OSReturn_t readByte(void)
--------------------------

**Description**


Single byte read. Return the byte or negative (OSReturn::OS_DISCONNECTED, OSReturn::OS_TIMEOUT). Normally the call will block until the next character is received, in other words the application will wakeup after each received byte. If the application expects a packet terminated by certain bytes, it is possible to buffer the packet and wakeup the application only once. To specify the bytes to match for packet termination, use **setReadMatchArray()**.

**Parameters**

:\* none

**Return value**

:\* return read byte or negative if an error occur

OSReturn_t readBytes(unsigned char\* pBuf, int bufSize)
--------------------------------------------------------

**Description**


Multi-byte read. Fill in the buffer with bufSize bytes. Normally the call will block until all bytes are received, in other words the application will wakeup only once, after all requested bytes are available. If the application expects a packet terminated by a certain byte, it is possible to return earlier, when the terminating byte is encountered. To specify the bytes to match for packet termination, use **setReadMatchArray()**.

**Parameters**

:\* pBuf - pointer to the array where to store the byte

:\* bufSize - size of buffer, number of expected bytes

**Return value**

:\* status

:\*\* OSReturn::OS_OK

:\*\* OSReturn::OS_DISCONNECTED

:\*\* OSReturn::OS_TIMEOUT

OSReturn_t availableRead(void)
-------------------------------

**Description**


Check if there is available data for read and if it is return the number of available bytes. It is guaranteed that reading no more than this number of bytes will not block.

**Parameters**

:\* none

**Return value**

:\* the number of available bytes for read if the operation succeeded or error status otherwise

int writeByte(unsigned char b)
------------------------------

**Description**


Single byte write. Does not flush, unless the implementation decides to do so (for example when the transmit buffer high water mark is reached). Return the same byte or negative (OSReturn::OS_DISCONNECTED, OSReturn::OS_TIMEOUT).

**Parameters**

:\* byte to be written

**Return value**

:\* status of the operation

int writeBytes(unsigned char\* pBuf, int len)
---------------------------------------------

**Description**


Multi-byte write. Does not flush, unless the implementation decides to do so (for example when the transmit buffer high water mark is reached).

**Parameters**

:\* pBuf - pointer to the array of bytes to write

:\* len - the number of bytes to write

**Return value**

:\* status of the operation

:\*\* OSReturn::OS_OK

:\*\* OSReturn::OS_DISCONNECTED

:\*\* OSReturn::OS_TIMEOUT

OSReturn_t flush(void)
-----------------------

**Description**


Flush the transmit buffer. Normally all bytes written are buffered and only when the high watermark is reached, the transmission begins. At the end of the line, or at other special moments, it might be needed to call flush() to force the transmission.

**Parameters**

:\* none

**Return value**

:\* status of the operation

void setReadMatchArray(char\* pMatch)
-------------------------------------

**Description**


Set the read matching array. The read functions will block until one received character will match any of the bytes in this array, or the receive buffer will reach the high watermark. The pointer is automatically cleared before returning from read. Setting an empty array will match no character, and will block the read until the high watermark is reached.

**Parameters**

:\* pMatch - pointer to array of characters to match ('\\0' terminated)

**Return value**

:\* none

deviceCharacterType_t getDeviceType(void)
------------------------------------------

**Description**


Get the device type. Currently only OS_DEVICECHARACTER_USART or OS_DEVICECHARACTER_USB_CDC.

**Parameters**

:\* none

**Return value**

:\* type of the device

Event methods
=============

Unique event IDs are automatically set for each instance of this class, and common applications do not need to change them. For special application, that need to send multiple notification, it is possible to access the event IDs, independently for open/read/write.

void setReadEvent(OSEvent_t event)
-----------------------------------

**Description**


Set the task event to be used by read.

**Parameters**

:\* event - event to be used by read

**Return value**

:\* none

OSEvent_t getReadEvent(void)
-----------------------------

**Description**


Get the task event for read operation.

**Parameters**

:\* none

**Return value**

:\* task event

void setWriteEvent(OSEvent_t event)
------------------------------------

**Description**


Set the task event to be used by write.

**Parameters**

:\* event - event to be used by write

**Return value**

:\* none

OSEvent_t getWriteEvent(void)
------------------------------

**Description**


Get the task event for write operation.

**Parameters**

:\* none

**Return value**

:\* task event

void setOpenEvent(OSEvent_t event)
-----------------------------------

**Description**


Set the task event to be used by open.

**Parameters**

:\* event - event to be used by open

**Return value**

:\* none

OSEvent_t getOpenEvent(void)
-----------------------------

**Description**


Get the task event for open operation.

**Parameters**

:\* none

**Return value**

:\* task event

Timeout methods
===============

void setOpenTimeout(OSTimerTicks_t t)
--------------------------------------

**Description**


Set the open timeout.

**Parameters**

:\* t - ticks for this timeout

**Return value**

:\* none

OSTimerTicks_t getOpenTimeout(void)
------------------------------------

**Description**


Get the open timeout.

**Parameters**

:\* none

**Return value**

:\* the open timeout

void setReadTimeout(OSTimerTicks_t t)
--------------------------------------

**Description**


Set the read timeout.

**Parameters**

:\* t - ticks for this timeout

**Return value**

:\* none

OSTimerTicks_t getReadTimeout(void)
------------------------------------

**Description**


Get the read timeout.

**Parameters**

:\* none

**Return value**

:\* the read timeout

void setWriteTimeout(OSTimerTicks_t t)
---------------------------------------

**Description**


Set the write timeout.

**Parameters**

:\* t - ticks for this timeout

**Return value**

:\* none

OSTimerTicks_t getWriteTimeout(void)
-------------------------------------

**Description**


Get the write timeout.

**Parameters**

:\* none

**Return value**

:\* the write timeout

void setOpenTimer(OSTimer \*pTimer)
-----------------------------------

**Description**


Set timer to be used by the open operation. If the operation doesn't succeed after the open-timeout (set with setOpenTimeout), this timer is used to wake-up the task and return with an error code.

**Parameters**

:\* pTimer - timer to be used by the open operation

**Return value**

:\* none

OSTimer \*getOpenTimer(void)
----------------------------

**Description**


Get the timer used by the open operation.

**Parameters**

:\* none

**Return value**

:\* timer used by the open operation

void setReadTimer(OSTimer \*pTimer)
-----------------------------------

**Description**


Set timer to be used by the read operation. If the operation doesn't succeed after the read-timeout (set with setReadTimeout), this timer is used to wake-up the task and return with an error code.

**Parameters**

:\* pTimer - timer to be used by the read operation

**Return value**

:\* none

OSTimer \*getReadTimer(void)
----------------------------

**Description**


Get the timer used by the read operation.

**Parameters**

:\* none

**Return value**

:\* timer used by the read operation

void setWriteTimer(OSTimer \*pTimer)
------------------------------------

**Description**


Set timer to be used by the write operation. If the operation doesn't succeed after the write-timeout (set with setWriteTimeout), this timer is used to wake-up the task and return with an error code.

**Parameters**

:\* pTimer - timer to be used by the write operation

**Return value**

:\* none

OSTimer \*getWriteTimer(void)
-----------------------------

**Description**


Get the timer used by the write operation.

**Parameters**

:\* none

**Return value**

:\* timer used by the write operation

Virtual/Abstract Methods
========================

These methods must be implemented by children classes, for specific functionality.

== virtual OSReturn_t implOpen(void) = 0 == **Description**


Children classes must implement this to open the device.

**Parameters**

:\* none

**Return value**

:\* status

== virtual OSReturn_t implClose(void) = 0 == **Description**


Children classes must implement this to close the device.

**Parameters**

:\* none

**Return value**

:\* status

virtual bool implIsConnected(void) const
----------------------------------------

**Description**


Children classes may implement this to test if the device is connected.

**Parameters**

:\* none

**Return value**

:\* true if the device is connected

== virtual bool implCanRead(void) = 0 == **Description**


Children classes must implement this to check if characters are available.

**Parameters**

:\* none

**Return value**

:\* true if characters are available for read

== virtual int implAvailableRead(void) = 0 == **Description**


Children classes must implement this to return the number of available characters.

**Parameters**

:\* none

**Return value**

:\* number of available characters

== virtual int implReadByte(void) = 0 == **Description**


Children classes must implement this to read one byte.

**Parameters**

:\* none

**Return value**

:\* return byte or negative if an error occur

== virtual bool implCanWrite(void) = 0 == **Description**


Children classes must implement this to check if characters are available.

**Parameters**

:\* none

**Return value**

:\* none

== virtual int implWriteByte(unsigned char b) = 0 == **Description**


Children classes must implement this to write one byte.

**Parameters**

:\* none

**Return value**

:\* status

== virtual int implFlush(void) = 0 == **Description**


Children classes must implement this to start transmission.

**Parameters**

:\* none

**Return value**

:\* status of the operation

virtual OSEvent_t implGetOpenEvent(void)
-----------------------------------------

**Description**


Children classes may implement this if they need to use a custom open event.

**Parameters**

:\* none

**Return value**

:\* event

virtual OSEvent_t implGetReadEvent(void)
-----------------------------------------

**Description**


Children classes may implement this if they need to use a custom read event.

**Parameters**

:\* none

**Return value**

:\* event

virtual OSEvent_t implGetWriteEvent(void)
------------------------------------------

**Description**


Children classes may implement this if they need to use a custom write event.

**Parameters**

:\* none

**Return value**

:\* event
