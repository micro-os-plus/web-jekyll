---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/ii/Development_environment/
title: Development environment
author: Liviu Ionescu

date: 2013-08-24 16:36:42 +0000

---

OS X
----

My main development environment is based on OS X (currently at 10.8).

     ilg-mbp:~ ilg$ cd My\ Files/MacBookPro\ Projects/uOS
     ilg-mbp:uOS ilg$

Here it is the main project repository **micro-os-plus-se.git** and a link to the **xcdl-python.git** repository.

Running the tests can be done with the command already shown in the [How to test]({{ site.baseurl }}/micro-os-plus/ii/How_to_test) page..

GNU/Linux
---------

For running the tests on GNU/Linux, I have several virtual machines, running on Parallels Desktop.

Since the OS X environment is much more convenient than any GNU/Linux GUI, for running the tests I prefer to start Ubuntu faceless (well, a minimised Parallels window) and just SSH into it.

Also, since I already have the full source repositories on OS X and my Home folder is already available to guest virtual machines as a standard mount point, it is more convenient to use it directly instead of cloning local repositories.

Running the tests can be done with the commands already shown in the [How to tests]({{ site.baseurl }}/micro-os-plus/ii/How_to_test) page.

### Ubuntu 13.10 x64

    ilg-mbp:~ ilg$ ssh ilg-ud1304x64-uos.local
    ilg@ilg-ud1304x64-uos.local's password:
    Welcome to Ubuntu 13.04 (GNU/Linux 3.8.0-26-generic x86_64)
     ...
    ilg@ilg-ud1304x64-uos:~$ cd /media/psf/Home/My\ Files/MacBookPro\ Projects/uOS
    ilg@ilg-ud1304x64-uos:/media/psf/Home/My Files/MacBookPro Projects/uOS$ ...
