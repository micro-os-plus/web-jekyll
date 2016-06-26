---
layout: old-wiki-page
permalink: /micro-os-plus/i/How_to_install_Eclipse_SVN/
title: How to install Eclipse SVN
author: Liviu Ionescu

date: 2012-04-02 14:13:00 +0000

---

The SVN client provides Eclipse a way to use the SVN repository. For µOS++ versions later than spring 2012, SVN support is no longer mandatory, install it only if you need to acces your own repositories.

SVN Team Provider
-----------------

[Polarion](http://www.polarion.com/products/svn/subversive.php) contributed the main code to Eclipse, and from 3.6 it is available in the standard distribution, it just needs to be installed.


**Eclipse** menu: **Help** → **Install New Software**

-   Work with: Helios
-   Expand **Collaboration**
-   select **Subversive SVN Team Provider (Incubation)**
-   click the **Next** button

SVN Connectors
--------------

As it is organised now, the Team Provider code uses some separate connectors to access the SVN. Polarion provided an automated Connector Discovery page, that pops up after installing the Team Provider.

This page is also reachable at


**Eclipse** menu: **Window** → **Preferences** → **Team** → **SVN**

Usually the portable SVNKit connector is the best choice. On my setup, SVNKit 1.3.2 worked just fine, allowing access to SVN 1.6.

As of Jan. 2010, the automated Connector Discovery procedure fails, and the alternative is to install manually from [Polarion Helios Site](http://community.polarion.com/projects/subversive/download/eclipse/2.0/helios-site/)


**Eclipse** menu: **Help** → **Install New Software**

-   in the *Install* window, click the **Add...** button (on future updates, just select the URL)
    -   fill in **Location:** with <http://community.polarion.com/projects/subversive/download/eclipse/2.0/helios-site/>
    -   fill in **Name:** with **Polarion Helios Site**
    -   click the **OK** button
-   in the main window, expand the *'Subversive SVN Connectors* section
-   select **SVNKit 1.3.2 Implementation**
-   click the **Next** button
-   restart Eclipse, if asked

SVN Configuration Check
-----------------------

Since a functional SVN configuration is mandatory for using the latest repository versions, we recommend a configuration check.


**Eclipse** menu: **Window** → **Preferences** → **Team**

-   if there is no SVN entry below, go back to **SVN Team Provider**
-   if there is a SVN entry; click on it
    -   the right window should change to SVN configuration, with multiple tabs
    -   select the **SVN Connector** tab
    -   check if the **SVNKit 1.3.2** connector is selected
    -   if the SVN Connector field is empty, go back to **SVN Connectors**

