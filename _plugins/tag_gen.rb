module Jekyll
  class AuthorPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'author_page'
        dir = site.config['author_dir'] || 'authors'
        site.data['authors'].each_key do |author|
          site.pages << AuthorPage.new(site, site.source, File.join(dir, site.data['authors'][author]['slug']), author)
        end
      end
    end
  end


  class AuthorPage < Page
    def initialize(site, base, dir, author)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'author_page.html')
      self.data['author'] = author

      author_name = site.data['authors'][author]['name']
      self.data['title'] = "#{author_name}"
    end
  end
end

module Jekyll
  # class TagIndex < Page
  #   def initialize(site, base, dir, tag)
  #     @site = site
  #     @base = base
  #     @dir = dir
  #     @name = 'index.html'
  #     self.process(@name)
  #     self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
  #     self.data['tag'] = tag
  #     self.data['taglist'] = get_tag_list(site,tag)
  #     tag_title_prefix = site.config['tag_title_prefix'] || 'Posts Tagged &ldquo;'
  #     tag_title_suffix = site.config['tag_title_suffix'] || '&rdquo;'
  #     self.data['title'] = "#{tag_title_prefix}#{tag}#{tag_title_suffix}"
  #     self.data['body_id'] = "topic"
  #   end

  #   def get_tag_list(site,tag)
  #     taglist = []
  #     tagposts = site.tags[tag]
  #     tagposts.sort! {|a,b|
  #       if a.data['date'] && b.data['date']
  #         atime = a.data['date']
  #         btime = b.data['date']
  #         atime <=> btime
  #       else
  #         0
  #       end
  #     }.reverse!
  #     tagposts.each {|post|
  #       if post.data["date"]
  #         date_time = post.data["date"].strftime('%FT%T%:z')
  #         post_date = post.data["date"].strftime('%Y.%m.%d')
  #       else
  #         date_time = ''
  #         post_date = ''
  #       end
  #       listitem = %Q{<li class="archive-list"><time class="dt-published" datetime="#{date_time}">#{post_date}</time> <a class="u-url p-name" href="#{post.url}" title="#{post.data["title"]}">#{post.data["title"]}</a>}
  #       if tag == 'bookmarks'
  #         listitem += %Q{<span></span><article class="summary">#{render_markdown(extract_dl(post.content))}</article>}
  #       end
  #       listitem += '</li>'
  #       taglist << listitem
  #     }
  #     return '<ul id="tag-index">' + taglist.join("\n") + '</ul>'
  #   end

  #   def render_markdown(input)
  #     Kramdown::Document.new(input).to_html
  #   end

  #   def extract_dl(input)
  #     links = input.scan(/(?mi)^(\[.*?\]\(.*?\)(?=\n:))/)
  #     return links.map {|l| "- #{l[0]}"}.join("\n")
  #   end
  # end
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
      if site.layouts.key? 'tag_main_index'
        dir = site.config['tag_dir'] || 'topic'
        write_main_tag_index(site, dir)
      end
    end

    def write_main_tag_index(site, dir)
      index = TagMainIndex.new(site, site.source, dir)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end


  end
end
