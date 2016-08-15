---
layout: old-wiki-page
lang: en
permalink: /micro-os-plus/i/Wiki_pages_style_guide/
title: Wiki pages style guide
author: Liviu Ionescu

date: 2011-03-08 14:42:00 +0000

---

Overview
========

This document describes recommended approaches for the format and structure of wiki pages.

Scope
=====

The guide is aimed to Wiki pages creators, editors and reviewers.

Environment
===========

This guide assumes the existence of a standard MediaWiki instance and the wiki syntax is specific to MediWiki.

References
==========

-   [MediaWiki User's Guide](http://meta.wikimedia.org/wiki/Help:Contents)
-   [MediWiki FAQ](http://www.mediawiki.org/wiki/Manual:FAQ)

Wiki markup
===========

Headers
-------

The wiki pages should be well structured, with multiple levels of headers.

    = Level 1 Header =

    == Level 2 Header ==

    === Level 3 Header ===

The recommended syntax is with one space between the equal signs and the content.

    = Level 1 Header =

is preferred over

    =Level 1 Header=

The headers are also used to generate the page hierarchical table of contents; all headers, down to the deepest level. This also dictates the limit between too few and too many headers: if the table of contents looks too long, with unnecessary details, then you probably went too far with adding headers, and some of the deepest levels should be removed. Similarly, if the page is long but the table of contents is just a few lines, you might consider adding some more intermediate headers.

Paragraphs
----------

Regardless of line legth, without any special characters, multiple text lines are concatenat and grouped in a single paragraph. To end a paragraph and open another one, use an empty line.

    This is the
    first paragraph.

    And this is the second.

Bold/Italic
-----------

Text that should be more visible than the rest of the sentence, can be marked as **bold** or, when appropriate, *italic*.

Lists
-----

Lists are a very convenient and nice looking way to present enumerations and should be used as often as needed.

### Bulleted lists

The usual format is a bulleted list:

List

-   item 1
-   item 2

<!-- -->

    List
    * item 1
    * item 2

### Numbered lists

For ordered items, or when it is necessary to refer to a particular item, numbered lists are available:

Orderd

1.  first
2.  second

<!-- -->

    Orderd
    # first
    # second

### Bulleted vs. Numbered

Please note that unless ordered or referred items, bulleted lists are preferred over numbered lists.

### Multilevel lists

It is not only perfectly possible to define, but also recommended to use multiple level lists:

Multilevel

-   level 1
    -   level 2
        -   level 3

<!-- -->

    Multilevel
    * level 1
    ** level 2
    *** level 3

This works for numbered lists too.

Indentation
-----------

When the text requires, for example when quoting a sentence, indentation can be used.


This sentence quotes from the classics

<!-- -->

    : This sentence quotes from the classics

Mixture of types
----------------

Multilevel lists and indentation can be mixed, if needed.

1.  one
2.  two
    -   two point one
    -   two point two

3.  three
    three item one
    three def one

4.  four

    four def one

    this looks like a continuation

    and is often used

    instead
    of \<br /\>

5.  five
    1.  five sub 1
        1.  five sub 1 sub 1

    2.  five sub 2

<!-- -->

    # one
    # two
    #* two point one
    #* two point two
    # three
    #; three item one
    #: three def one
    # four
    #: four def one
    #: this looks like a continuation
    #: and is often used
    #: instead<br />of <nowiki><br /></nowiki>
    # five
    ## five sub 1
    ### five sub 1 sub 1
    ## five sub 2

Tables
------

Tables are not exactly the easiest feature of formats like wiki or html.

The syntax, although quite simple, is not easy to remember, so the best way to enter tables is with... copy/paste.

|First Column|Second Column|
|------------|-------------|
|Bread|Pie|
|Butter|Ice cream|

    {|  class="wikitable"
    ! First Column !! Second Column
    |-
    | Bread || align="center" | Pie
    |-
    | Butter || Ice cream
    |}

Links
-----

### Internal links

To ease navigation, it is recommended to link from one wiki page to another. If the displayed text needs to be different than the link, it can be specified.

[different text]({{ site.baseurl }}/micro-os-plus/i/Main_Page "wikilink")

    [[/Main_Page|different text]]

### External links

Similarly, external links can be entered behind any text part:

[MediaWiki](http://mediawiki.org)

    [http://mediawiki.org MediaWiki]

Punctuation
===========

No spaces before punctuation
----------------------------

General punctuation rules should be respected, for example

-   do not use spaces **before** punctuation marks
-   use one single space **after** punctuation marks

The only exception to the rule are the open parenthesis, where the rule is symmetrical, i.e. one space before and no space after.

Capital letters
---------------

Capital letters should be used to mark:

-   the beginning of sentences
-   proper nouns or words derived from nouns
-   titles of persons or entities
-   acronyms

Although a matter of personal preferences, the (ab)use of capital letters inside titles, headings, and sub-headings should be avoided.

Lists
-----

One usually arguable topic is the punctuation to be used for lists.

There is no single rule to fit all needs.

Short enumerations look cleaner without any punctuation and without capital letters:


Sample list:

-   apples
-   oranges

If the items of the list are in general short enumeration and only occasionally contain multiple sentences, except the first one, the general rules apply, i.e. the subsequent sentences start with capital letters and are finished with dot.


Sample list with some sentences:

-   apples
-   oranges. Some might come from Florida.
-   peaches

If the list items are long, and might be considered parts of a long sentence that was split for readability reasons, itms should end with usual punctuation marks, like semi-colon, and the last item should end with a dot.


One possibility is:

-   a small initial letter at the start and a semi-colon at the end of each item;
-   and a full stop at the end of the final item.

If the list items are independent sentences, and you feel like they should start with capital letters and be ended with full stops, then you should probably reconsider the option of using lists and consider indentation.

Wiki page name
==============

According to the rule used for capital letters in titles, **capital letters should be avoided in wiki pages names**.

For example **Main page** is preferred to **Main Page**.

Minor vs. Major edits
=====================

The border between major and minor is not that obvious, but the rule should be that when significant content is added, the edit should be major. If the edit consists only of typos, spaces, punctuation, it is minor.

For the rest, it depends. As another rule, we can consider major all changes that:

-   add headers
-   change headers
-   add sentences or paragraphs
-   add elements to a list

In practical terms, the difference between major and minor edits is used when displaying the *Recent changes* page, and allows a better overview on the edit activity.

It is recommended for all users to set their preferences so that by default all edits are minor, and to manually mark major edits.
