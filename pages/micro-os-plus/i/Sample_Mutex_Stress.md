---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Sample_Mutex_Stress/
title: Sample Mutex Stress
author: Liviu Ionescu

date: 2011-03-09 15:56:11 +0000

---

Objective
---------

This project tests the OSMutex class extensively.

Description
-----------

A few concurrent tasks (about 10, but let it be N) iteratively attempt to access the protected region for M times, which has a side effect (e.g. update to a global) so that the number of accesses and writes can be counted to ensure that the number of updates to the global is exactly (N)\*(M).

Implementation Details
----------------------

1.  global variables:
    1.  an OSMutex object is created, let it be mutex
    2.  an integer value, resourceValue, is the resource which will be shared by all tasks
    3.  an integer array, let it be resourceAccessNum, size N, each tasks increments its number of access of the resource; it is used for debugging and live statistics

2.  one task (let it be called main task) is created and started
    1.  this task sleeps for 5 seconds
    2.  when it wakes up, it attempts to take the mutex
    3.  when mutex is acquired, a few information is output to debug interface: resourceValue, resourceAccessNum
    4.  releases the mutex and goes back to sleep for another 5 seconds

3.  all the N tasks are created and started, and have access to the global variables
    1.  each task, while the resourceAccessNum[taskNum] did not reached the maximum M
        1.  it sleeps for a random amount of time, and then it blocks until the mutex is acquired
        2.  when mutex is acquired resourceValue is incremented and resourceAccessNum[taskNum] is incremented also
        3.  checks if itself is the owner of the mutex (the last task which acquired it)
            1.  if not signal error

        4.  finally the mutex is released

Resources
---------

-   [Stackoverflow forum question](http://stackoverflow.com/questions/2380869/how-best-to-test-a-mutex-implementation)
