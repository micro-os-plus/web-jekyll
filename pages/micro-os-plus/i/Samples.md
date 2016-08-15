---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Samples/
title: Samples
author: Liviu Ionescu

date: 2011-03-08 09:29:14 +0000

---

Several samples are provided:

-   the 'minimal' sample is the simplest code and does... nothing;
-   'blinkX3' shows how to run 3 instances of the same task to blink 3 different leds with different blink rates;
-   'blinkX3Sync' defines 4 different tasks and shows some simple task synchronization methods;
-   'blinkPitpalac' shows how to implement a progressive blinking LED;
-   'calibrateBustWait' allows calibration of constants used in busyWait();
-   '[mutexStress]({{ site.baseurl }}/micro-os-plus/i/Sample_Mutex_Stress "wikilink")' shows several tasks using the same resource protected by a mutex;

More advanced samples, using special hardware:

-   'cliX2' shows how to run two instances of a simple CLI process on both the USART port and the USB port, emulating a serial port (CDC);
-   'sdcard' shows how to read data from a MMC/SD Card;
-   'sdi12sensor' sample shows how to build a SDI-12 sensor.
