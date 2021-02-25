# Title: Pullquote tag for Jekyll
# Author: Brett Terpstra
# Description: Output pullquote markup
#
# Syntax {% pullquote [left|right|center] %}Text{% endpullquote %}
#
# Example (creates both ogg and mp3 sources because no extension is given):
# {% audio /share/myaudiofile "My Audio File" download=true %}
#

module Jekyll
  # Class for Jekyll {% pullquote %} tag
  class PullquoteTag < Liquid::Block
    @align = "center"

    def initialize(tag_name, markup, tokens)
        # if no mp3 or ogg extension, assume all
      @align = case markup
      when /right/
        "right"
      when /left/
        "left"
      else
        "center"
      end
      super
    end

    def render(context)
      output = super
      @quote = Kramdown::Document.new(output).to_html
      %Q(<blockquote class="pullquote #{@align}">#{@quote}</blockquote>)
    end

    Liquid::Template.register_tag('pullquote', self)
  end
end


