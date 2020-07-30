---
layout: page
title: Contributors
permalink: /contributors/
breadcrumb: true
header:
  image_fullwidth: lex-community.jpg
  caption: Artwork by Odera Igbokwe
  caption_url: https://www.odera.net/
---
<ul>
{% for author_hash in site.data.authors %}
{% assign author = author_hash[1] %}
{% if author.siterole == 'Contributor' %}
<li><a href="/contributors/{{ author.slug }}">{{ author.name }}</a> &mdash; {{ author.siterole }}</li>
{% endif %}
{% endfor %}
</ul>
    
