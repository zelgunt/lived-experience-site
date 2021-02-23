---
layout: page
title: "Contact"
meta_title: "Contact the Lived Experience Project"
permalink: "/contact/"
---

If you have questions about the Lived Experience Project, we would love to hear from you.

Please contact our Project Manager at [keith@terralunacollaborative.com](mailto:keith@terralunacollaborative.com)

<ul class="no-bullet">
{% for network_item in site.data.socialmedia %}
  {% if network_item.url contains 'http' %}{% assign domain = '' %}{% else %}{% capture domain %}{{ site.url }}{{ site.baseurl }}{% endcapture %}{% endif %}
    <li {% if network_item.class %}class="{{ network_item.class }}" {% endif %}>
      <a href="{{ domain }}{{ network_item.url }}" {% if network_item.url contains 'http' %}target="_blank" {% endif %} title="{{ network_item.title }}">{{ network_item.name }}</a>
    </li>
{% endfor %}
</ul>
