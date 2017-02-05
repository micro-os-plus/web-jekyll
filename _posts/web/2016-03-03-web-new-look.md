---
layout: post
lang: en
title: The µOS++ IIIe new web site (using GitHub Pages)
author: Liviu Ionescu

date: 2016-03-03 22:10:00 +0300

categories:
  - news
  - web

---

After the µOS++ IIIe project was migrated from [SourceForge](http://sourceforge.net/projects/micro-os-plus/) to [GitHub](https://github.com/micro-os-plus), a new web site was created, to replace the previous wikis.

## Migration to GitHub

There are many reasons behind this decision (GitHub looks definitely cool!), but the main one is probably to reduce dependencies on custom DNS domains, like `livius.net`, which might not be available on long term.

### Repositories

The current project repositories are:

* [micro-os-plus-iii](https://github.com/micro-os-plus/micro-os-plus-iii) - µOS++ IIIe / CMSIS++
* [micro-os-plus-iii-cortexm](https://github.com/micro-os-plus/micro-os-plus-iii-cortexm) - the µOS++ Cortex-M port

Without much practical value, but preserved for historical reasons, the old SourceForge repositories will be migrated to GitHub at a later date.

## The web has a new look

Since [GitHub Pages](https://pages.github.com) is the GitHub solution for providing documentation sites, and this service makes the sites available in the `github.io` domain, it was considered acceptable to migrate the MediaWiki sites to GitHub Pages.

GitHub Pages uses [Jekyll](http://jekyllrb.com) to generate static web sites, and the most convenient input format for Jekyll is [markdown](http://daringfireball.net/projects/markdown/syntax), so the migration involved conversion from MediaWiki internal representation, to markdown. Given the differences, this conversion was not easy, and was done partly with scripts, partly manually. Similarly for MediaWiki, although the conversion from the MediaWiki format to markdown was easier. (Note: the migration is still work in progress).

Given the complexity of this migration, we are aware that it is very likely that lots of mistakes are still present in the pages; we would appreciate any help in fixing them (use the [Web Issues](https://github.com/micro-os-plus/micro-os-plus.github.io/issues/) tracker for this).

The web site has two dedicated projects:

* [micro-os-plus.github.io](https://github.com/micro-os-plus/micro-os-plus.github.io) - the µOS++ IIIe / CMSIS++ web static site
* [micro-os-plus.github.io-source](https://github.com/micro-os-plus/micro-os-plus.github.io-source) - the complete Jekyll source for the µOS++ IIIe / CMSIS++ web

The first one stores the actual static pages of the Web site and the second stores the Jekyll source files for generating the Web site.

## Old sites

The previous MediaWiki sites were initially moved back to SourceForge, but, after a while, were decommisioned and currently are no longer available.
