---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_OSDeviceCharacterBuffered/
title: Class OSDeviceCharacterBuffered
author: Liviu Ionescu

date: 2011-03-05 00:22:16 +0000

---

Classes hierarchy
=================

-   streambuf
    -   OSDeviceCharacter
        -   OSDeviceCharacterBuffered

The OSDeviceCharacter class may or may not derive from streambuf, based on configuration variables.

Children classes
================

-   OSDeviceCharacterBufferedUsart0
-   OSDeviceCharacterBufferedUsart1

Overview
========

The OSDeviceCharacterBuffered class implements circular receive/transmit buffers. It is the parent class for devices like USART.

OSDeviceCharacterBuffered is an abstract class, requiring children classes to implement the actual read/write code.

Constructors
============

OSDeviceCharacterBuffered(unsigned char \*pRxBuf, unsigned short rxBufSize, unsigned short rxHWM, unsigned short rxLWM, unsigned char \*pTxBuf, unsigned short txBufSize, unsigned short txHWM, unsigned short txLWM)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Description**


Initialize the buffered character device with the given circular buffers and with custom water mark values.

**Parameters**

:\* pRxBuf - pointer to receive buffer

:\* rxBufSize - size of receive buffer

:\* rxHWM - receive high water mark

:\* rxLWM - receive low water mark

:\* tRxBuf - pointer to transmit buffer

:\* txBufSize - size of transmit buffer

:\* txHWM - transmit high water mark

:\* txLWM - transmit low water mark

**Return value**

:\* none

OSDeviceCharacterBuffered(unsigned char \*pRxBuf, unsigned short rxBufSize, unsigned char \*pTxBuf, unsigned short txBufSize)
-----------------------------------------------------------------------------------------------------------------------------

**Description**


Initialize the buffered character device with the given circular buffers and default 1/4 low and 3/4 high water mark values.

**Parameters**

:\* pRxBuf - pointer to receive buffer

:\* rxBufSize - size of receive buffer

:\* tRxBuf - pointer to transmit buffer

:\* txBufSize - size of transmit buffer

**Return value**

:\* none

Virtual Methods
===============

virtual OSReturn_t implOpen(void)
----------------------------------

**Description**


Call implPortInit() to open the device.

**Parameters**

:\* none

**Return value**

:\* status

virtual OSReturn_t implClose(void)
-----------------------------------

**Description**


Call implPortDisable() to close the device.

**Parameters**

:\* none

**Return value**

:\* status

virtual bool implIsConnected(void) const
----------------------------------------

**Description**


Check if the device is connected. Not yet fully implemented, currently just returns returns true.

**Parameters**

:\* none

**Return value**

:\* true if the device is connected

virtual bool implCanRead(void)
------------------------------

**Description**


Check if the receive buffer is not empty.

**Parameters**

:\* none

**Return value**

:\* true if characters are available for read

virtual int implAvailableRead(void)
-----------------------------------

**Description**


Return the number of available characters in the receive buffer.

**Parameters**

:\* none

**Return value**

:\* number of available characters

virtual int implReadByte(void)
------------------------------

**Description**


Return the next byte available in the receive buffer.

**Parameters**

:\* none

**Return value**

:\* return byte or negative if an error occur

virtual bool implCanWrite(void)
-------------------------------

**Description**


Check if the transmit buffer is not full.

**Parameters**

:\* none

**Return value**

:\* true if transmit queue not full

virtual int implWriteByte(unsigned char b)
------------------------------------------

**Description**


Add one byte to the transmit buffer. If above high water mark, start transmission by enabling transmit interrupts.

**Parameters**

:\* none

**Return value**

:\* status

virtual int implFlush(void)
---------------------------

**Description**


If the transmit buffer is above high water mark, start transmission by enabling transmit interrupts.

**Parameters**

:\* none

**Return value**

:\* status of the operation

Methods
=======

void interruptRxServiceRoutine(void)
------------------------------------

**Description**


Implement the receive interrupt service routine. Read from the device and if the receive buffer is not full, insert in it.

**Parameters**

:\* none

**Return value**

:\* none

void interruptTxServiceRoutine(void)
------------------------------------

**Description**


Implement the transmit interrupt service routine. If the transmit buffer is empty, disable transmit interrupts. Get one byte from the transmit buffer and write it to the device. If the buffer is below the low water mark, notify writer to send more bytes.

**Parameters**

:\* none

**Return value**

:\* none

Abstract Methods
================

== virtual int implPortInit(void) = 0 ==

virtual int implPortDisable(void)
---------------------------------

== virtual void implInterruptTxEnable(void) = 0 ==

== virtual void implInterruptTxDisable(void) = 0 ==

== virtual unsigned char implPortRead(void) = 0 ==

== virtual void implPortWrite(unsigned char b) = 0 ==
