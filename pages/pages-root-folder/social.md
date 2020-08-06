---
layout: page
permalink: /social/
title: Social Networks
---
<ul class="no-bullet">
{% for network_item in site.data.socialmedia %}
  {% if network_item.url contains 'http' %}{% assign domain = '' %}{% else %}{% capture domain %}{{ site.url }}{{ site.baseurl }}{% endcapture %}{% endif %}
    <li {% if network_item.class %}class="{{ network_item.class }}" {% endif %}>
      <a href="{{ domain }}{{ network_item.url }}" {% if network_item.url contains 'http' %}target="_blank" {% endif %} title="{{ network_item.title }}">{{ network_item.name }}</a>
    </li>
{% endfor %}
</ul>
