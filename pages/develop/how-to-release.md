---
layout: page
permalink: /develop/how-to-release/
title: How to release
author: Liviu Ionescu

date: 2016-07-11 20:50:00 +0300

---

## Commit git repos

With GitHub Desktop,

* commit cmsis-plus
* possibly commit posix-arch, micro-os-plus-iii, etc

## Update the doxygen change log

With Eclipse, edit `doxygen/pages/changes-log.markdown`

* add new `###` section, with version and date
* copy from GitHub Desktop the relevant changes, in chronological order

## Update the doxygen main.markdown

If the CMSIS APIs changed, update `doxygen/pages/main.markdown`.

## Update os-versions.h

With Eclipse,

* edit `include/os-versions.h`.

## Run doxygen

With Eclipse,

* select the `micro-os-plus-iii` project
* click the `@` button

If errors, fix them and repeat.

## Check the jekyll site

In Finder,

* double click the `jekyll-serve.command`
* double click the `localhost-4001.command`

Verify the changed pages.

## Build the jekyll site

In Finder,

* double click the `jekyll-build.command`

## Commit git repos

With GitHub Desktop,

* commit `cmsis-plus` (versions, message like v6.3.3)
* click the **Sync** button
* commit `micro-os-plus.github.io-source`
* click the **Sync** button

## Publish site

With GitHub Desktop,

* commit `micro-os-plus.github.io`
* click the **Sync** button
