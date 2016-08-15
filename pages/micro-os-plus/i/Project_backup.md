---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Project_backup/
title: Project backup
author: Liviu Ionescu

date: 2011-07-12 15:22:55 +0000

---

SVN repository backup
=====================

Go to */Users/ilg/My Files/MacMini Vault/Projects/SourceForge.backup/micro-os-plus* and click on the **svn-rsync.command** executable.

    #!/bin/sh

    export PROJECT=micro-os-plus
    export MYSVNROOT="/Users/ilg/My Files/MacMini Vault/Projects/SourceForge.backup/$PROJECT/svn"
    mkdir -p $MYSVNROOT
    cd $MYSVNROOT
    rsync -av $PROJECT.svn.sourceforge.net::svn/$PROJECT/* .
    echo "Project '$PROJECT' ... Done."

MediaWiki backup
================

Go to [Hosted Application Backup](https://sourceforge.net/apps/backup/micro-os-plus/)

-   select Content to backup: **Database**
-   select Content format: **gzip**
-   select Application to backup: **mediawiki**
-   click the **Submit** buton

The result will be a file called:


micro-os-plus_mediawiki_files.tar.gz

Rename it to include the current date, like this:


micro-os-plus_mediawiki_files_20110712.tar.gz

Similarly for the MediaWiki files:

-   select Content to backup: **Files**
-   select Content format: **gzip**
-   select Application to backup: **mediawiki**
-   click the **Submit** buton

The result will be a file called:


micro-os-plus_mediawiki_files.tar.gz

Rename it to include the current date, like this:


micro-os-plus_mediawiki_files_20110712.tar.gz
