---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Class_LargeCircularStorage/
title: Class LargeCircularStorage
author: Liviu Ionescu

date: 2011-04-14 18:01:52 +0000

---

Overview
========

The LargeCircularStorage class manages a large circular buffer, based on a random access block device, like a flash memory, with a fixed block size of BLK_SIZE bytes and a fixed capacity of NUM_BLOCKS blocks, addressed from 0 to (NUM_BLOCKS-1).

Managing a circular buffer is usually trivial, by sequentially writing data blocks and restarting from the beginning when the last available block is used.

The only challenge is at power-up, to determine which is the first free block, or, in other words, which was the last written block. One could claim that such a mechanism is not needed, by always writing the last block address on an external persistent device.

Although this might work, it has two drawbacks:

-   the persistent device must allow a huge number of write cycles
-   due to external reasons (power failure, unexpected reset) the saved value might not be accurate

For a high reliability device, determining the address of the next free block is mandatory. Being, by definition, a large storage, let's say millions of blocks, a linear search is out of question, and a binary search should be possible.

Originally designed for linear structures, the binary search does not work directly on circular buffers, but with some carefully designed details, the binary search can be tailored on circular buffers too.

There are probably many possible implementations, one of them being described below.

Implementation
==============

One assumption intended to simplify things is that data block are grouped by a certain criteria, let's say by sessions with identical characteristics (for example a measurement session with a given acquisition rate, precision, etc).

Writing blocks to the storage is always done at the end, the only decision being

-   append the block to the previous session
-   start a new session

The grouping by sessions can be easily implemented by adding a pointer to each block, referring to the first block of the session, identified by referring to itself.

Assuming the sessions have a significant number of blocks, when a search is needed, instead of linearly scanning the entire storage it is much faster to scan session by session.

The second field required in each block is a monotone increasing unique ID, to simplify the detection of the last used block, since the next block should be an older one, so with a lower ID. The range of this ID should be at least two times larger than the total number of blocks, to accommodate the situation when this ID rolls over.

In conclusion, the overhead of the circular buffer is a two field header, added to each block, containing the following:

-   a block number (with a 1KB block size, a long integer covers about 4 TB, a value more than enough for regular embedded applications)
-   a monotone increasing unique ID (a long integer usually would be enough)
