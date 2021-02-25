# frozen_string_literal: true

module Jekyll
  # Generator plugin for author pages
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

      author = site.data['authors'][author]

      self.data['title'] = author['name']
      self.data['teaser'] = author['summary']
      self.data['description'] = author['bio']
    end
  end
end
