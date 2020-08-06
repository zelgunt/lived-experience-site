## Configutation

### Main menu navigation

Edit the main menu in `_data/navigation.yml`. Add a submenu to an item using the dropdown key.

    - title: About
      url: "/about/"
      side: left
      dropdown:
      - title: "About TerraLuna"
        url: "/about/terraluna"

### Homepage

Homepage 3-column widgets are edited in `pages/pages-root-folder/index.md` as frontmatter (widget1, 2, etc.)

### Page layouts

When creating a page or post you can define a page layout. This is set by default for pages and posts, so you only need to define it if you want to override the default.

Page layouts available:

- `layout: page` 8-column centered
- `layout: page-fullwidth` 12-column

### Footer info

The info in the footer:

- About blurb is in `_config.yml`
- Services are in `_data/services.yml`
- Social links are in `_data/socialmedia.yml`

### Sidebar

A sidebar can be enabled with `sidebar: right` or `sidebar: left`

Content of the sidebar is edited in `_includes/sidebar.html`. It's static using HTML (not Markdown). I don't know how useful this will be.


- Other frontmatter
    - `breadcrumb: true` adds a navigation breadcrumb based on categories
    - `permalink: /path/to/page` to a post or page frontmatter defines its URL. Optional.
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

## Posts

Jekyll requires blog post files to be named according to the following format:

`YEAR-MONTH-DAY-title.md`

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers. After that, include the necessary front matter. Take a look at the source for this post to get an idea about how it works. 

### Table of contents

To include a table of contents, include the following code in a post or page:

    {: #toc }
    *  TOC
    {:toc}

### Include a gallery. 

See the frontmatter of this post for a demo, then include `{% include gallery %}` in the post.

### Audio player

To include an audio file use `{% audio audio_file_name %}` in the post/page. If an extension is specified, only that format will be linked. Otherwise it's assumed that you have multiple formats from mp3, wav, ogg, and oga available and any that exist in media/audio with the same base filename will be included in the tag's sources.

For example, if the tag is `{% audio sys078 %}` and the `/media/audio/` directory contains `sys078.mp3` and `sys078.ogg`, then an HTML5 audio tag with sources for both formats will be created.

Using subdirectories is fine, in which case the tag would look like `{% audio subdir/file %}`.

Add a title after the filename, and optionally include `download=true` to include a download link.


    {% audio sys078 Systematic Episode 78 download=true %}

### Images

In addition to the header image, a post image can be defined in the frontmatter like this:

    image:
        title: path/to/image.jpg

The path should be relative to `/images/`. An image defined in this manner will appear full-width above the headline and makes a good way to add a banner image to the post. This can be combined with `header: no` in the frontmatter to disable the standard banner image with logo. (Alternatively, you can always set a post image as the header image as well, see frontmatter section).

The easiest way to include an image in the post with all appropriate markup is to use the `{% img %}` tag. This takes a series of arguments, the simplest version being:

  {% img path/to/image.jpg %}

Images are expected to be in the `/images/` directory, and can use relative paths to subdirectories from there. E.g. if you have an image in `/images/2020/07/myimage.png`, you can reference it with `{% img 2020/07/myimage.png %}`

You can apply CSS classes to the image by preceding the filename with one or more class names:

  {% img alignleft path/to/image.jpg %}

You can also specify a width and height after the image, which can help with lazy loading and page layout. This should be the natural size of the main (non-2x) image:

  {% img path/to/image.jpg 800 600 %}

Alt text should always be included, and comes after any width or height:

  {% img path/to/image.jpg 800 600 Alt Text for image %}

If you want a title as well (which creates a caption on the image), use two strings in quotes. The first one will become the title, the second the alt tag:

  {% img path/to/image.jpg "This is the title" "image alt text" %}

A full tag would look like this:

  {% img alignleft path/to/image.jpg 800 600 "The image title" "The Alt Text" %}

Use `{% imgd image... %}` to define an image as the default image for the page, affecting social sharing. Otherwise `image:` in frontmatter is default.

#### A note on image sizes

Multiple sizes of an image can (and often should) be provided. Preferably, a regular size image and a 2x size would be included, named with the same base: `myimage.png` and `myimage@2x.png`.

Using the same base name you can also add a size for mobile screens (which will also be used for the Twitter/Facebook thumbnail). To do so, add `_tw`, which in the previous example would give you a filename of `myimage_tw.png`. This image should be a 2:1 ratio at a minimum of 600px x 300px.

You can also specify a Facebook-only image with the suffix `_fb`. All of these suffixed images will be correctly extrapolated from the base img tag if they exist at the time of rendering.

### Contributor profiles

Contributors are edited in `_data/authors.yml`. The first entry in that file is commented to describe what each key does. The comments (lines starting with `#`) do not need to be copied when adding new authors.

Author photo: Photo should be specified as a relative path from `/images/`. Photo should be square (will be cropped to circle), at 300x300px.

Bio:  Note that a bio and summary can be included. The summary will appear at the end of a post attributed to that author, and the full bio will appear on the author page, along with a list of posts attributed to that author.

### Footnotes

Add footnotes in typical MultiMarkdown format: `[^identifier]` in the text, then define it on its own line:

    [^identifier]: This is the text for the footnote

It will insert a footnote like this[^fn1].

[^fn1]: This is a pretty cool footnote, if you ask me.


### Post terminator

To include a terminator at the end of the last paragraph, use `...end of post.{% eof %}`. If you don't leave a space between the last character and the tag, it will ensure that the last word breaks to a new line and doesn't leave the terminator hanging. This is recommended.

