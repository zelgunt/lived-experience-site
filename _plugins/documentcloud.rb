# Title: DocumentCloud tag for Jekyll
# Author: Brett Terpstra
# Description: Embed document or annotation from DocumentCloud.org
#
# Syntax {% dc URL %}
#
# Example (Embed annotation):
# {% dc https://beta.documentcloud.org/documents/20413901#document/p1/a2005512 %}
#
# Example (Embed full document):
# {% dc https://beta.documentcloud.org/documents/20413901 }

module Jekyll
  # Class for Jekyll {% dc %} tag
  class DCTag < Liquid::Tag
    @document = nil
    @annotation = nil

    def initialize(tag_name, markup, tokens)
      if markup.strip =~ /(?mi)(?:https:\/\/.*documentcloud\.org\/documents\/)(?<doc>\d+).*?(?:#document\/p(?<page>\d+)(?:\/a(?<note>\d+))?|$)/
        m = Regexp.last_match
        @document = m['doc']
        @page = m['page']
        @annotation = m['note']
      end
      super
    end

    def render(context)
      super

      unless @document.nil?
        if @annotation
          %(<div id="DC-note-#{@annotation}" class="DC-embed DC-embed-note DC-note-container" style="max-width:750px"></div><script src="https://beta.documentcloud.org/notes/loader.js"></script><script>dc.embed.loadNote('https://embed.documentcloud.org/documents/#{@document}/annotations/#{@annotation}.js');</script><noscript><a href="https://embed.documentcloud.org/documents/#{@document}/annotations/#{@annotation}">View note</a></noscript>)
        elsif @page
          %(<div class="DC-embed"><div style="font-size:14px;line-height:18px;"><a class="DC-embed-resource" style="color:#5a76a0;text-decoration:underline;" href="https://embed.documentcloud.org/documents/#{@document}/#document/p#{@page}" title="View entire document" target="_blank"></a></div></div><script src="https://beta.documentcloud.org/embed/enhance.js"></script>)
        else
          %(<iframe src="https://embed.documentcloud.org/documents/#{@document}/?embed=1&amp;title=1" title="(Hosted by DocumentCloud)" width="700" height="905" style="border: 1px solid #aaa;" sandbox="allow-scripts allow-same-origin allow-popups allow-forms"></iframe>)
        end
      else
        'Error processing input, expected syntax: {% dc DOCUMENT_CLOUD_URL %}'
      end
    end
  end
end

Liquid::Template.register_tag('dc', Jekyll::DCTag)
