---
layout: page
lang: en
permalink: /develop/jekyll-style-guide/
title: Jekyll style guide
author: Liviu Ionescu

date: 2016-06-29 22:25:18 +0000

---

[Jekyll](https://jekyllrb.com) is a simple, blog-aware, static site generator.

The content is written in the GitHub-flavoured [markdown](https://help.github.com/articles/basic-writing-and-formatting-syntax/), as implemented by the [kramdown](http://kramdown.gettalong.org/syntax.html) converter. Syntax highlighting is provided by [Rouge](http://rouge.jneen.net).

## Centered images

```
<div style="text-align:center">
<img src="{{ site.baseurl }}/assets/images/2016/micro-os-plus-collection.png" />
</div>
```

## Code blocks

{% highlight cpp linenos %}
#include <cmsis-plus/rtos/os.h>

int
os_main (int argc, char* argv[])
{
  return 0;
}
{% endhighlight %}

Currently this is not acceptable.

``` c++
#include <cmsis-plus/rtos/os.h>

int
os_main (int argc, char* argv[])
{
  return 0;
}
```

The `highlight` would be preferable, but since it does not work properly, the second version will be used.
