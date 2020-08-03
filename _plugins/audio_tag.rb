# Title: Audio tag for Jekyll
# Author: Brett Terpstra
# Description: Output HTML5 audio tag
#
# Syntax {% audio url/to/mp3,ogg,blank ["Title"] %}
#
# Example (creates both ogg and mp3 sources because no extension is given):
# {% audio /share/junkyangel "Junky Angel" %}
#
#
# Output:
# <figure class="audio">
#   <audio controls="true">
#       <source src="/share/JunkyAngel.mp3" type="audio/mp3">
#       <source src="/share/JunkyAngel.ogg" type="audio/ogg">
#       HTML5 audio not supported
#   </audio>
#   <figcaption>Junky Angel</figcaption>
# </figure>
#

module Jekyll

  class AudioTag < Liquid::Tag
    @mp3 = nil
    @ogg = nil
    @oga = nil
    @wav = nil
    @title = nil
    @download = false

    def initialize(tag_name, markup, tokens)
        # if no mp3 or ogg extension, assume all
      if markup =~ /((\S+)(mp3|og[ga]|wav)?)(\s+(.*))?/i
        song = $1
        @title = $5 unless $4.nil?

        if @title && @title =~ /\s+download=(true|false)/i
          @download = $1 =~ /true/i ? true : false
          @title = @title.sub(/\s+download=(true|false)/i, '')
        end

        if song =~ /\.mp3$/
            @mp3  = song
        elsif song =~ /\.ogg$/
            @ogg = song
        elsif song =~ /\.oga$/
            @oga = song
        elsif song =~ /\.wav$/
            @wav = song
        else
            @mp3 = song+".mp3"
            @ogg = song+".ogg"
            @oga = song+".oga"
            @wav = song+".wav"
        end
      end
      super
    end

    def audio_exist?(path)
      base_path = File.expand_path('.')
      audio = File.join(base_path, path)
      File.exist?(audio)
    end

    def render(context)
      output = super
      basedir = context.registers[:site].config["audio_base_path"] || "/media/audio"
      if @mp3 || @ogg || @oga || @wav
        audio =  %Q{<figure class="audio"><audio controls="true" class="mejs__player">}
        @mp3 = File.join(basedir, @mp3) if @mp3
        @ogg = File.join(basedir, @ogg) if @ogg
        @oga = File.join(basedir, @oga) if @oga
        @wav = File.join(basedir, @wav) if @wav
        if @mp3 && audio_exist?(@mp3)
          audio += %Q{<source src="#{@mp3}" type="audio/mp3">}
        end
        if @ogg && audio_exist?(@ogg)
          audio += %Q{<source src="#{@ogg}" type="audio/ogg">}
        end
        if @oga && audio_exist?(@oga)
          audio += %Q{<source src="#{@oga}" type="audio/oga">}
        end
        if @wav && audio_exist?(@wav)
          audio += %Q{<source src="#{@wav}" type="audio/wav">} if @wav
        end
        audio += "HTML5 audio not supported </audio>"
        if @mp3 && @download
          dl_link = %( <a href="#{@mp3}" title="Download #{@title}">Download</a>)
        else
          dl_link = ''
        end
        audio += "<figcaption>#{@title}#{dl_link}</figcaption>" if @title || @download
        audio += "</figure>"
      else
        "Error processing input, expected syntax: {% audio url/to/mp3,ogg,blank [\"Title\"] %}"
      end
    end
  end

end

Liquid::Template.register_tag('audio', Jekyll::AudioTag)
