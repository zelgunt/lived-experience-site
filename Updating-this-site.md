- Edit main menu in `_data/navigation.yml`
- Page layouts available:
    - `layout: page`
    - `layout: page-fullwidth`
- The info in the footer:
    - About blurb is in `_config.yml`
    - Services are in `_data/services.yml`
    - Other Resources are in `_data/network.yml`
- Sidebar can be enabled with `sidebar: right` or `sidebar: left`
    - content is edited in `_includes/sidebar.html`
- Other frontmatter
    - `breadcrumb: true` adds a navigation breadcrumb based on categories
    - `permalink: /path/to/post` to a post or page frontmatter defines its URL
    - `author` should be set to the key name for an author listed in `_data/authors.yml`

            author: author-name
    - `header` can be `no` or have an array of settings. Most common:
        
            header:
                image_fullwidth: lex-shadows.jpg
                caption: Artwork by Odera Igbokwe
                caption_url: https://www.odera.net/
    - `image:` can define an article image that appears before the headline. Must exist in `/images/`
    
            image:
                title: image_name.jpg

TODO:

- tag pages
- google analytics
- social links
- author pages
