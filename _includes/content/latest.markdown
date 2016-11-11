{% if include.title %}
{% if include.url %}
#### [ {{ include.title }} ]({{ include.url }})
{% else %}
#### {{ include.title }}
{% endif %}
{% endif %}

<ul>
{% for post in site.posts limit: site.latestpages[include.layout] %}
{% if post.layout == include.layout %} <li><a href="{{ post.url }}">{{ post.title }}</a></li>{% endif %}
{% endfor %}
</ul>