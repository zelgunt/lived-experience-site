---
layout: page
title: Contributors
permalink: /contributors/
breadcrumb: true
header:
  image_fullwidth: lex-community.jpg
  caption: Artwork by TK
  caption_url: https://www.odera.net/
---
<ul id="author-list">
{% for author_hash in site.data.authors %}
{% assign author = author_hash[1] %}
{% if author.siterole == 'Contributor' %}
<li>
    <a href="/contributors/{{ author.slug }}">
        <div class="author" role="contentinfo">
            <div class="postUser">
                <div class="postUser__portrait">
                    {% if author.photo %}
                    
                    <img class="u-photo headshot" src="{{ site.url | join_path: 'images', author.photo }}" alt="Photo of {{ author.name }}" width="150" height="150">
                    {% endif %}
                </div>
            </div>
        </div>

        <span class="author-name" itemprop="author" itemscope itemtype="http://schema.org/Person"><span itemprop="name" class="p-name">{{ author.name }}</span></span>

        <span class="author-role">{{ author.siterole }}</span>
    </a>
</li>
{% endif %}
{% endfor %}
</ul>
    
