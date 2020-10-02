#!/usr/bin/ruby
# WebExcursions, a script for gathering new Pinboard links with a certain tag
# and generating Markdown/Jekyll posts when enough are collected.
# Brett Terpstra 2013
#
# -f to force writing out current bookmarks to file regardless of count

%w[fileutils set net/https zlib rexml/document time base64 uri cgi stringio optparse].each do |filename|
  require filename
end

config = {
  # Pinboard credentials
  apikey: 'livedexp:160D6FCDBA45C687EE53',
  # Where to store the database
  db_location: File.expand_path('./webexcursions'),
  # How many posts must be gathered before publishing
  min_count: 3,
  # relative location of folder for creating drafts
  drafts_folder: File.expand_path('_drafts')
}

# template for post headers
config[:post_template] = <<-ENDTEMPLATE
---
title: "%%TYPE%% links for #{Time.now.strftime('%B %-d, %Y')}"
layout: post
tags:
- bookmarks
- %%TYPE_TAG%%
categories:
- Bookmarks
post_class: bookmarks
description: "The latest links from around the web."
comments: false
---

ENDTEMPLATE

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename(__FILE__)} [-f] [-d] [--type=local|national]"
  config[:force] = false
  opts.on('-f', '--force', 'Create post even if there are fewer than minimum bookmarks') do
    config[:force] = true
  end
  config[:type] = 'national'
  opts.on('-t', '--type TYPE', '(l)ocal or (n)ational (default national)') do |type|
    config[:type] = type =~ /^l/ ? 'local' : 'national'
  end
  config[:debug] = false
  opts.on('-d', '--debug', 'Output debug messages') do
    config[:debug] = true
  end
  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end

optparse.parse!

# Tag to use for finding bloggable bookmarks
config[:blog_tag] = case config[:type]
                    when 'local'
                      '.locblogit'
                    else
                      '.natblogit'
                    end

class Net::HTTP
  alias_method :old_initialize, :initialize

  def initialize(*args)
    old_initialize(*args)
    @ssl_context = OpenSSL::SSL::SSLContext.new
    @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end

# Pinboard methods
class Pinboard
  attr_accessor :existing_bookmarks, :new_bookmarks
  def initialize(config)
    @config = config
    # Make storage directory if needed
    FileUtils.mkdir_p(@config[:db_location], :mode => 0755) unless File.exist? @config[:db_location]

    # load existing bookmarks database
    @existing_bookmarks = read_bookmarks
  end

  def debug_msg(message,sticky = true)
    if @config[:debug]
      $stderr.puts message
    end
  end

  # Store a Marshal dump of a hash
  def store obj = @existing_bookmarks, file_name = @config[:db_location]+"/#{@config[:type]}-bookmarks.stash", options={:gzip => false }
    marshal_dump = Marshal.dump(obj)
    file = File.new(file_name,'w')
    file = Zlib::GzipWriter.new(file) unless options[:gzip] == false
    file.write marshal_dump
    file.close
    return obj
  end
  # Load the Marshal dump to a hash
  def load file_name
    begin
      file = Zlib::GzipReader.open(file_name)
    rescue Zlib::GzipFile::Error
      file = File.open(file_name, 'r')
    ensure
      obj = Marshal.load file.read
      file.close
      return obj
    end
  end

  def new_bookmarks
     return self.unique_bookmarks
  end

  def existing_bookmarks
    @existing_bookmarks
  end

  def add_auth(api_call)
    api_call + "&auth_token=#{@config[:apikey]}"
  end

  # retrieves the XML output from the Pinboard API
  def get_xml(api_call)
    xml = ''
    request = Net::HTTP.new('api.pinboard.in', 443)
    request.use_ssl = true
    request.start do |http|
    	req = Net::HTTP::Get.new(add_auth(api_call))
    	response = http.request(req)
    	response.value
    	xml = response.body
    end
    return REXML::Document.new(xml)
  end
  # converts Pinboard API output to an array of URLs
  def bookmarks_to_array(doc)
    bookmarks = []
    doc.elements.each('posts/post') do |ele|
      post = {}
      ele.attributes.each {|key,val|
        post[key] = val;
      }
      bookmarks.push(post)
    end
    return bookmarks
  end
  # compares bookmark array to existing bookmarks to find new urls
  def unique_bookmarks
      xml = self.get_xml("/v1/posts/recent?tag=#{@config[:blog_tag]}&count=100")
      bookmarks = self.bookmarks_to_array(xml)
      unless @existing_bookmarks.nil?
        old_hrefs = @existing_bookmarks.map { |x| x['href'] }
        bookmarks.reject! { |s| old_hrefs.include? s['href'] }
      end
      return bookmarks
  end
  # wrapper for load
  def read_bookmarks
    # if the file exists, read it
    if File.exists? @config[:db_location]+"/#{@config[:type]}-bookmarks.stash"
      return self.load @config[:db_location]+"/#{@config[:type]}-bookmarks.stash"
    else # new database
      return []
    end
  end

  def read_current_excursion
    # if the file exists, read it
    if File.exists? @config[:db_location]+"/#{@config[:type]}-current.stash"
      return self.load @config[:db_location]+"/#{@config[:type]}-current.stash"
    else # new database
      return []
    end
  end
end

pb = Pinboard.new(config)

# retrieve recent bookmarks
new_bookmarks = pb.new_bookmarks

# load the current draft stash
current_excursion = pb.read_current_excursion
if new_bookmarks.count > 0 || current_excursion.count > 0
  pb.debug_msg("Found #{new_bookmarks.count} unindexed bookmarks.",false)
else
  pb.debug_msg("No new bookmarks. Exiting.",false)
  exit
end

# merge new bookmarks into main database
existing_hrefs = current_excursion.map { |x| x['href'] }
new_bookmarks.each {|bookmark|
  pb.existing_bookmarks.push(bookmark)
  unless existing_hrefs.include? bookmark['href']
    current_excursion.push(bookmark)
  end
}

pb.store

# if there are at least min_count bookmarks, create a draft post and clear cache
if current_excursion.length >= config[:min_count].to_i || config[:force]
  if current_excursion.length > config[:min_count].to_i && !config[:force]
    excursions = current_excursion.slice!(0,config[:min_count])
  else
    excursions = current_excursion
    current_excursion = []
  end

  output = config[:post_template].gsub(/%%TYPE%%/, config[:type].capitalize).gsub(/%%TYPE_TAG%%/, config[:type].downcase)

  excursions.each_with_index {|bookmark, i|
    output += "[#{bookmark['description']}](#{bookmark['href']})\n"
    output += ": #{bookmark['extended'].gsub(/\n+/,' ')}\n\n"
  }

  draft = "#{config[:drafts_folder]}/#{config[:type]}-web-excursions-#{Time.now.strftime('%B-%d-%Y-1').downcase}"
  while (File.exist?(draft + '.md'))
    draft.next!
  end
  draft += '.md'

  File.open(draft, 'w+') do |f|
    f.puts output
  end

  puts "Draft post written to #{draft}"
  current_stash = config[:db_location] + "/#{config[:type]}-current.stash"
  published_stash = config[:db_location] + "/#{config[:type]}-published-#{Time.now.strftime('%Y-%m-%d-%s')}.stash"
  FileUtils.mv(current_stash, published_stash) if File.exist?(current_stash)
end

puts "There are currently #{current_excursion.count} bookmarks collected."
current_excursion.each_with_index do |bookmark, i|
  idx = i + 1
  puts "#{idx}: #{bookmark['description']}"
end

pb.store(current_excursion, config[:db_location]+"/#{config[:type]}-current.stash", options={ gzip: false })
