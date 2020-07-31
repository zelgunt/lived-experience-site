---
layout: page
title:  "Welcome to the Lived Experience Project"
subheadline: Blog
date:   2020-07-16 08:48
meta_teaser: "Description used for meta tags. Short, no HTML."
teaser: "Lead in text for summary pages. HTML OK."
header:
  image_fullwidth: lex-shadows.jpg
  caption: Artwork by Odera Igbokwe
  caption_url: https://www.odera.net/
categories:
    - lex
tags: [test tag, another tag]
author: brett
gallery:
    - image_url: lex-courtroom.jpg
      caption: Gallery example 1
    - image_url: lex-healing.jpg
      caption: Gallery example 2
    - image_url: lex-shadows.jpg
      caption: Gallery example 3
---
You'll find this post in your `_posts` directory. Edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.md`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers. After that, include the necessary front matter. Take a look at the source for this post to get an idea about how it works. 

### Include a Table of Contents

{: #toc }
*  TOC
{:toc}

    {: #toc }
    *  TOC
    {:toc}

### General notes

- Edit main menu in `_data/navigation.yml`
- Sidebar can be enabled with frontmatter `sidebar: right` or `sidebar: left`
    - content is edited in `_includes/sidebar.html`
- The info in the footer:
    - About blurb is in `_config.yml`
    - Services are in `_data/services.yml`
    - Other Resources are in `_data/network.yml`

### Other frontmatter

- Page layouts available:
    - `layout: page`
    - `layout: page-fullwidth`
- `breadcrumb: true` adds a navigation breadcrumb based on categories
- `permalink: /path/to/post` to a post or page frontmatter defines its URL
- `author` should be set to the key name for an author listed in `_data/authors.yml`

        author: author-name
- `header` can be `no` or have an array of settings. Most common (`image_fullwidth` should exist in `/images/`, `caption` and `caption_url` are  optional):
    
        header:
            image_fullwidth: lex-shadows.jpg
            caption: Artwork by Odera Igbokwe
            caption_url: https://www.odera.net/
- `image:` can define an article image that appears before the headline. Must exist in `/images/`

        image:
            title: image_name.jpg

### Footnotes

Add footnotes in typical MultiMarkdown format: `[^identifier]` in the text, then define it on its own line:

    [^identifier]: This is the text for the footnote

It will insert a footnote like this[^fn1].

[^fn1]: This is a pretty cool footnote, if you ask me.

### Include a gallery. 

See the frontmatter of this post for a demo, then include {% raw %}`{% include gallery %}`{% endraw %} in the post.

{% include gallery %}

To include a terminator at the end of the last paragraph, use {% raw %}`{% eof %}`{% endraw %}. {% eof %}
