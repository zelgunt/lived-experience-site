# Generator to create tag pages and an index of tags
#
# Layout pages required:
#
# _layouts/tag_page.html
# _layouts/tag_main_index.html
#
# These are provided with page.tags (main index) and page.posts (tag page)
#
# Site config keys
#
# tag_page_dir: the path for tag pages and location of index
# tag_title_prefix: not currently used
# tag_title_suffix: not currently used

module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_page.html')
      self.data['tag'] = tag
      self.data['taglist'] = get_tag_list(site, tag)
      tag_title_prefix = site.config['tag_title_prefix'] || 'Posts Tagged &ldquo;'
      tag_title_suffix = site.config['tag_title_suffix'] || '&rdquo;'
      # self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
      self.data['title'] = tag.split(/ /).map {|t| t.capitalize }.join(' ')
      self.data['posts'] = site.tags[tag]
    end

    def get_tag_list(site,tag)
      taglist = []
      tagposts = site.tags[tag]
      tagposts.sort! {|a,b|
        if a.data['date'] && b.data['date']
          atime = a.data['date']
          btime = b.data['date']
          atime <=> btime
        else
          0
        end
      }.reverse!
      tagposts.each {|post|
        if post.data["date"]
          date_time = post.data["date"].strftime('%FT%T%:z')
          post_date = post.data["date"].strftime('%Y.%m.%d')
        else
          date_time = ''
          post_date = ''
        end
        listitem = %(<li class="archive-list"><time class="dt-published" datetime="#{date_time}">#{post_date}</time> <a class="u-url p-name" href="#{post.url}" title="#{post.data["title"]}">#{post.data["title"]}</a></li>)
        taglist << listitem
      }
      return '<ul id="tag-index">' + taglist.join("\n") + '</ul>'
    end
  end

  class TagMainIndex < Page
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_main_index.html')
      self.data['title'] = "Topics"
      self.data['tags'] = site.tags.keys.sort
    end
  end

  class TagGenerator < Generator
    safe true
    priority :highest

    $timers = []
    $avg_string = ''

    def generate(site)
      if site.layouts.key? 'tag_page'
        dir = site.config['tag_page_dir'] || 'topic'

        site.tags.each_key do |tag|
          write_tag_index(site, File.join(dir, tag.slug), tag)
        end
      end
      if site.layouts.key? 'tag_main_index'
        dir = site.config['tag_page_dir'] || 'topic'
        write_main_tag_index(site, dir)
      end
    end

    def write_main_tag_index(site, dir)
      tindex = TagMainIndex.new(site, site.source, dir)
      tindex.render(site.layouts, site.site_payload)
      tindex.write(site.dest)
      site.pages << tindex
    end


    def write_tag_index(site, dir, tag)
      tindex = TagIndex.new(site, site.source, dir, tag)
      tindex.render(site.layouts, site.site_payload)
      tindex.write(site.dest)
      site.pages << tindex
    end

  end
end
