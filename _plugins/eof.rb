module Jekyll
  class EOFTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      %(<span class="terminator"></span>)
    end
  end
end

Liquid::Template.register_tag('eof', Jekyll::EOFTag)
