---
layout: page
lang: en
permalink: /develop/how-to-release/
title: How to release
author: Liviu Ionescu

date: 2016-07-11 20:50:00 +0300

---

## Check git repos

In `xPacks/ilg/scripts.git`, run `xpacks-git-status.mac.command` to check 
which repositories need to be updated.

## Commit git repos

With SourceTree,

* commit `micro-os-plus-iii.git`
* possibly commit `micro-os-plus-iii-cortexm.git`, `posix-arch.git`, etc

## Update the doxygen change log

With Eclipse, edit `micro-os-plus-iii.git/doxygen/pages/changes-log.markdown`

* add new `###` section, with version and date
* copy from SourceTree the relevant changes, in reverse chronological order

## Update the doxygen header version

With Eclipse, edit `micro-os-plus-iii.git/doxygen/config-common.doxyfile`.

## Update os-versions.h

With Visual Studio Code,

* edit `micro-os-plus-iii.git/include/os-versions.h`, remove `-beta`

## Run doxygen

With Terminal,

```console
$ cd /Users/ilg/Library/xPacks/ilg/micro-os-plus-iii.git/doxygen
$ axbb
$ doxygen --version
1.8.14
$ doxygen config.doxyfile
```

If errors, fix them and repeat.

## Check the jekyll site

In Finder,

* double click the `jekyll-serve.command`
* double click the `localhost-4001.command`

Verify the changed pages.

## Add post to announce new release

* in `_posts/releases/`
* add a new post named file like `2016-11-27-micro-os-plus-v6-3-10-released.md`

## Commit git repos

With SourceTree, update `micro-os-plus-iii.git`

* select the `develop` branch
* commit, message like v6.3.10
* select the `xpack` branch
* merge the `develop` branch
* click the **Push** button, select both branches
* select the `develop` branch

With SourceTree, update `micro-os-plus-iii-cortexm.git`

* select the `develop` branch
* commit, message like v6.3.10
* select the `xpack` branch
* merge the `develop` branch
* click the **Push** button, select both branches
* select the `develop` branch


## Publish site

With SourceTree,

With SourceTree, update `micro-os-plus.github.io-source`

* commit, message like v6.3.10
* click the **Push** button

## Update os-versions.h

With Eclipse,

* edit `include/os-versions.h`, increment version, add `-beta`

With SourceTree, update `micro-os-plus-iii.git`

* select the `develop` branch
* commit, message like 'os-version.h: 6.3.11-beta'
