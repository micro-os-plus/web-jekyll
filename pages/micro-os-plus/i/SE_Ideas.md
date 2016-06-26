---
layout: old-wiki-page
permalink: /micro-os-plus/i/SE_Ideas/
title: SE Ideas
author: Liviu Ionescu

date: 2011-09-17 22:28:31 +0000

---

Overview
--------

This page is intended to collect various ideas regarding the design of the SE.

µOS++ SE SRS
------------

The requirements for the SE should be defined in a Software Requirements Specifications, according to IEEE Standard 830-1998.

Threads vs. Active Objects
--------------------------

Threads are the basic scheduling units, and from the scheduler perspective this should be enough.

However, the design of applications should not be limited to threads only, but should be considered in terms of processes, each aiming to perform a specific task. Simple tasks can usually be solved with single threads, but for real world cases some of these processes may require the cooperation of multiple threads.

Large systems (like POSIX ones) afford to use real processes for this, but for embedded systems these are too heavy in terms of resources. One possible alternative is to use active objects, which are objects that include one or more threads.

The first idea would be to make the active objects children of threads. For simple active objects this one-to-one relationship might be enough. However, a more general solution would be to include the threads as members of active objects, so the relationship between active objects and threads is extended to one-to-many.

os::core::Object
----------------

This can be used as the base class for all system objects.

One common functionality of system objects is to have a name, so a **const char\* m_name** private member can be automatically added to all system objects, together with a public getName() method and a constructor to set the name.

    namespace os
    {
      namespace core
        {
          class Object
          public:
            Object(const char* pName):

            const char*
            getName(void) const;

          private:
            const char* m_pName;
        }
    }

Note: having a name added to all system objects was inspired by MicroC/OS III.

os::core::ActiveObject : public os::core::Object
------------------------------------------------

This can be the base class of all active objects, and can include one thread plus code inspired from POSIX process management.

Possible methods:

-   powerDown() - turn off devices used by the active object, turn off clocks, power supplies, etc. as for just before entering sleep or deep sleep
-   powerUp() - turn on everything needed to make the active object work after wake-up from sleep
-   terminate() - try to orderly terminate all activities and associated threads
-   kill() - forced termination of all threads
