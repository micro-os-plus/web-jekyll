---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Debug_support/
title: Debug support
author: Liviu Ionescu

date: 2010-11-10 13:53:13 +0000

---

Debug is a sensitive issue and an efficient debug support may significantly decrease development time.

With µOS++ any methods you are accustomed can be used, including JTAG, if you can afford it.

Based on my experience with embedded devices, I preffer to use a dedicated output-only device where to display debug messages. The routines should be simple and do not use interrupts, so they can be called to display messages even from interrupt service routines.

Currently µOS++ defines two debug devices: hardware USART and bit-banged I2C protocol. Both have advantages and disadvantages: the hardware USART is simple to use, but is unusable if the processor dinamically changes the running frequency; I2C is independent of running frequency, can run at higher speeds than regular USART, but requires an external device to pass characters from the I2C bus to a regular serial port (preferably to an USB device).

Examples
--------

    TaskBlink::TaskBlink(const char *pName, schedTicks_t rate) :
      OSTask(pName, m_stack, sizeof(m_stack))
      {
        if (os.isDebug())
          {
            os.sched.lock();
              {
                debug.putString("TaskBlink()=");
                debug.putHex((unsigned short) this);
                debug.putNewLine();
              }
            os.sched.unlock();
          }
        m_rate = rate;
      }

Display a message when the task constructor is invoked.

    void TaskCli::taskMain(void)
      {
        if (os.isDebug())
          {
            os.sched.lock();
              {
                clog << "TaskCli::taskMain(" << showbase << hex
                     << ( unsigned short ) this << ") SP=" << hex
                     << ( unsigned short ) SP << endl;
              }
            os.sched.unlock();
          }
        // ...
      }

Display a message when the task is started.
