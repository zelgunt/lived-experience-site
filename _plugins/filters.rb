require 'fileutils'
# require 'porter_stemming.rb'
require 'json'
require 'kramdown'

module LEXLiquidFilters
  base_url = "http://lex.invalid/"
  cdn_url = "http://lex.invalid/"

  def fixer(input)
    input.force_encoding('utf-8')
  end

  def render_markdown(input)
    Kramdown::Document.new(input).to_html
  end

  def keyword_string(keywords)
    keywords.join(" ").strip
  end

  def trailing_comma(kstring)
    kstring + "," unless kstring.nil? || kstring.length == 0
  end

  def page_type(input)
    case input
    when /topics?\//
      "topic"
    when /categor(y|ies)\//
      "category"
    when /projects?\//
      "project"
    when /404/
      "error"
    when /\d{4}\//
      "post"
    else
      "page"
    end
  end

  # Returns a datetime if the input is a string
  def datetime(date)
    if date.class == String
      date = Time.parse(date)
    end
    date
  end

  # Returns an ordidinal date eg July 22 2007 -> July 22nd 2007
  def ordinalize(date)
    date = datetime(date)
    "#{date.strftime('%b')} #{ordinal(date.strftime('%e').to_i)}, #{date.strftime('%Y')}"
  end

  def timestamp(date)
    date = datetime(date)
    date.strftime('%s')
  end

  # Returns an ordinal number. 13 -> 13th, 21 -> 21st etc.
  def ordinal(number)
    if (11..13).include?(number.to_i % 100)
      "#{number}<span>th</span>"
    else
      case number.to_i % 10
      when 1; "#{number}<span>st</span>"
      when 2; "#{number}<span>nd</span>"
      when 3; "#{number}<span>rd</span>"
      else    "#{number}<span>th</span>"
      end
    end
  end

  # Format date and add time string
  def format_datetime(date, format)
    date_string = format_date(date, format)
    date = datetime(date)
    time_string = date.strftime('%-I:%M %p')
    %Q{#{date_string} at #{time_string}}
  end

  # Formats date either as ordinal or by given date format
  # Adds %o as ordinal representation of the day
  def format_date(date, format)
    date = datetime(date)
    if format.nil? || format.empty? || format == "ordinal"
      date_formatted = ordinalize(date)
    else
      date_formatted = date.strftime(format)
      date_formatted.gsub!(/%o/, ordinal(date.strftime('%e').to_i))
    end
    date_formatted
  end

  def check_sticky(date)
    date = datetime(date).strftime('%Y%m%d')
    return date == Time.now.strftime('%Y%m%d')
  end

  def should_search(input)
    if input =~ /(^\/?(archives?|series|downloads|topics?|categor(y|ies)|page|search|404|index\.html)|\.(xslt|xml|rb|jpg|png|gif|txt|md|json|css)$)/
      false
    else
      true
    end
  end

  def jsonify(input)
    begin
      out = input.to_json
    rescue
      return %Q{"#{input.gsub(/"/,'\"')}"}
    else
      return out
    end
  end

  def trunc(input, length)
    return "" if input.nil?
    if input.length > length && input[0..(length-1)] =~ /(.+)\b.+$/im
      $1
    else
      input
    end
  end

  def strip_markdown(input)
    # strip all Markdown and Liquid tags
    output = input.dup
    begin
      output.gsub!(/\{%.*?%\}/,'')
      output.gsub!(/\{[:\.].*?\}/,'')
      output.gsub!(/\[\^.+?\](\: .*?$)?/,'')
      output.gsub!(/\s{0,2}\[.*?\]: .*?$/,'')
      output.gsub!(/\!\[.*?\][\[\(].*?[\]\)]/,"")
      output.gsub!(/\[(.*?)\][\[\(].*?[\]\)]/,"\\1")
      output.gsub!(/^\s{1,2}\[(.*?)\]: (\S+)( ".*?")?\s*$/,'')
      output.gsub!(/^\#{1,6}\s*/,'')
      output.gsub!(/(\*{1,2})(\S.*?\S)\1/,"\\2")
      output.gsub!(/\{[%{](.*?)[%}]\}/,"\\1")
      output.gsub!(/(`{3,})(.*?)\1/m,"\\2")
      output.gsub!(/^-{3,}\s*$/,"")
      output.gsub!(/`(.+)`/,"\\1")
      output.gsub!(/(?i-m)(_|\*)+(\S.*?\S)\1+/) {|match|
        $2.gsub(/(?i-m)(_|\*)+(\S.*?\S)\1+/,"\\2")
      }
      output.gsub(/\n{2,}/,"\n\n")
    rescue
      return input
    else
      output
    end
  end

  def drill_down(input)
    # remove all HTML and Markdown
    content = strip_tags(strip_markdown(input),false)
    # find the first block of text with more than 3 punctuation marks
    # this is assumed to be the first real block of content
    content.split(/\n\n/).delete_if {|block| block.nil? }.delete_if {|block|
      punct = block.scan(/[\.,\!\?;]/)
      punct.nil? ? true : punct.length < 2
    }
  end

  # generate a truncated description
  def description(input)
    blocks = drill_down(input.force_encoding('utf-8'))
    return "" if blocks.empty?
    # truncate the description
    desc = CGI.escapeHTML(trunc(blocks[0],200).gsub(/\n/,' ').gsub(/\s+/,' ').strip)
    # if blank, return site name
    desc == "" ? "The Lived Experience Project." : desc
  end

  # generate a truncated description
  def long_description(input)

    blocks = drill_down(input.force_encoding('utf-8'))
    # truncate the description
    desc = CGI.escapeHTML(trunc(blocks.join(" "),2500).gsub(/[\r\n\t]/,' ').squeeze(" ").strip)
    desc.gsub!(/\^/,"&#2C6;")
    # if blank, return site name
    desc == "" ? "The Lived Experience Project" : desc
  end

  def expand_url(input)
    input.strip!
    unless input =~ /^http/
      input = "#{cdn_url}/#{input.sub(/^\//,'')}"
    end
    input
  end

  def expand_url_cdn(input)
    input.strip!
    unless input =~ /^http/
      input = "#{cdn_url}/#{input.sub(/^\//,'')}"
    end
    input.sub(/^#{Regexp.escape(base_url)}/, "#{cdn_url}")
  end

  def just_text(input)
    # strip_tags(strip_markdown(CGI.unescapeHTML(input)),false).gsub(/[\r\t\s\n]+/,' ').strip
    return "" if input.nil?
    begin
      strip_tags(CGI.unescapeHTML(input.force_encoding('utf-8')),false)
    rescue
      strip_tags(input, false)
    end
  end

  # generate a list of keywords for the post
  def keywords(input)
    # words to ignore
    blockwords = %w[1 2 3 4 5 6 7 8 9 0 one two three four five about actually always even given into
                    just not i'm that's its it's aren't we've i've didn't don't the of to and a in is it
                    you that he was for on are with as i his they be at one have this from or had by hot
                    but some what what's there we can out were all your you're yours when up use how said
                    an each she which do their if will way many then them would like so these her see him
                    has more could go come did my no get me say too here must such try us own oh any
                    you'll also than those though thing things january february march april may june
                    july august september october november december post know link never should yeah go
                    look need last seen us befor well we'll make much tweet show want been follow around
                    very pretty unless other probably update nope seem copy really case date something
                    start still day turn total perfect notice plain become back include type might
                    already read part find someone most see hard tell miss lately down good instead
                    size after actual manage anything least usual wait site past there less exactly
                    set gone without better sweet power affect over open week time result dai i'll
                    i've i'm i'd they they'll they've]
    blockwords += %w[ a abeyance absence absolutely abundance abundantly accede accelerate accentuate
                      accommodation accompanying accomplish accordance according accordingly acknowledge
                      acquaint acquiesce acquire actually addition additional adjacent adjustment
                      admissible advance advantageous advise affix afford afforded aforesaid aggregate
                      aligned all alleviate allocate along alternative alternatively am ameliorate
                      amendment an analysis and annum anticipate apparent applicant application
                      appreciable apprise appropriate approximately are as ascertain assemble assistance
                      at attempt attend attention attributable authorise authority axiomatic basically
                      be behalf being belated beneficial bestow breach but by
                      calculate case cases cease circumvent clarification combine combined commence
                      communicate competent compile complete completion comply component comprise compulsory
                      conceal concerned concerning conclusion concur condition conjunction connection consequence
                      consequently considerable consideration constitute construe consult consumption contemplate
                      contrary correct correspond costs counter course courteous cumulative current currently
                      customary date day deduct deem defer deficiency delay delete
                      demonstrate denote depict designate desire despatch despite determine detrimental
                      difficulties diminish disburse discharge disclose disconnect discontinue discrete discretion
                      discuss dispatch disseminate documentation domiciled dominant drawn due duration
                      during dwelling each early economical effect eligible elucidate emphasise
                      empower enable enclosed encounter end endeavour enquire enquiry ensure
                      entitlement envisage equal equivalent erroneous establish evaluate event every
                      evince ex exceptionally excess excessive exclude excluding exclusively exempt
                      existing expedite expeditiously expenditure expire extant extent extremely extremity
                      fabricate facilitate fact factor failure far final finalise find
                      following for formulate forthwith forward frequently from furnish further
                      furthermore future generate give grant grounds have henceforth hereby
                      herein hereinafter hereof hereto heretofore hereunder herewith hitherto hold
                      hope i if illustrate immediately implement imply in inappropriate
                      inception incorporating incurred indicate inform initially initiate insert instances
                      intend intents intimate irrespective is issue it its jeopardise
                      known large last least liaise lieu like lines locality
                      locate magnitude majority mandatory manner manufacture marginal material materialise
                      matter may means merchandise mind minimum mislay modification moment
                      month months moreover near negligible neighbourhood nevertheless not notify
                      notwithstanding number numerous objective obligatory obtain obviously occasion occasioned
                      occasions of of/that officio on one one's operate opinion
                      opportunity optimum option or order ordinarily other otherwise our
                      outstanding owing own partially participate particulars per percentage perform
                      period permissible permit personnel persons peruse place please pleasure
                      possess possessions practically predominant prescribe present preserve previous principal
                      prior proceed procure profusion progress prohibit projected prolonged promptly
                      promulgate proportion provide provided provisions proximity purchase purpose purposes
                      pursuant qualify question quite really reason receipt reconsider records
                      reduce reduction refer reference referred regard regarding regards regulation
                      reimburse reiterate relating relation remain remainder remittance remuneration render
                      represent request requested require requirements reside residence respect restriction
                      retain review revised say scrutinise select settle should similarly
                      solely something specified state statutory subject submit subsequent subsequently
                      substantial substantially such sufficient sum supplement supplementary supply take
                      tenant terminate that the thereafter thereby therein thereof thereto
                      things this thus time to total transfer transmit trust
                      ultimately unavailability undernoted undersigned understood undertake uniform
                      unilateral unoccupied until upon utilisation utilise variation very view virtually
                      visualise ways we whatsoever when whensoever whereas whether which with would you
                      your yourself zone]
    blockwords += %w[alignleft alignright aligncenter allowfullscreen]
    # strip tags/markdown, create an array of words,
    # delete blockwords and short words,
    # combine remaining elements into string
    input = strip_tags(input.force_encoding('utf-8').strip)
    arr = input.gsub(/[^A-Z ']/i, ' ').squeeze(' ').split(' ')
    arr.uniq!
    arr.delete_if { |word| word.nil? || word.length < 5 || blockwords.include?(word.downcase) }
    # arr.map!{|word|
    #   if word.length > 7
    #     Text::PorterStemming.stem(word).downcase
    #   else
    #     word
    #   end
    # }

    arr.sort!
    arr.map! do |word|
      %("#{CGI.escapeHTML(word.downcase.strip)}")
    end

    arr.slice(0,200).join(',').gsub(/(^,|,$)/, '')
  end

  # remove all HTML tags and smart quotes
  def strip_tags(html, decode = true)
    begin
      out = CGI.unescapeHTML(html.
        gsub(/<(script|style|pre|code|figure).*?>.*?<\/\1>/im, '').
        gsub(/<!--.*?-->/m, '').
        gsub(/<(img|hr|br).*?>/i, " ").
        gsub(/<(dd|a|h\d|p|small|b|i|blockquote|li)( [^>]*?)?>(.*?)<\/\1>/i, " \\3 ").
        gsub(/<\/?(dt|a|ul|ol)( [^>]+)?>/i, " ").
        gsub(/<[^>]+?>/, '').
        gsub(/\[\d+\]/, '').
        gsub(/&#8217;/,"'").gsub(/&.*?;/,' ').gsub(/;/,' ').
        gsub(/\u2028/,'')
      ).lstrip
      if decode
        out.force_encoding("ASCII-8BIT").gsub("\xE2\x80\x98","'").gsub("\xE2\x80\x99","'").gsub("\xCA\xBC","'").gsub("\xE2\x80\x9C",'"').gsub("\xE2\x80\x9D",'"').gsub("\xCB\xAE",'"').squeeze(" ")
      else
        out.squeeze(" ")
      end
    rescue
      CGI.unescapeHTML(html)
    end
  end

  # Outputs a list of categories as comma-separated <a> links. This is used
  # to output the category list for each post on a category page.
  #
  #  +categories+ is the list of categories to format.
  #
  # Returns string
  #
  def category_links(categories)
    dir = @context.registers[:site].config['category_dir']
    categories = categories.sort!.map do |item|
      "<a class='category' href='/#{dir}/#{item.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase}/'>#{item}</a>"
    end

    case categories.length
    when 0
      ""
    when 1
      categories[0].to_s
    else
      "#{categories[0...-1].join(', ')}, #{categories[-1]}"
    end
  end

  def tag_links(tags)
    dir = @context.registers[:site].config['tag_index_dir']
    tags = tags.sort!.map do |item|
      "<a class='tag p-category' href='/#{dir}/#{item.gsub(/-+/, '%20').downcase}/'>#{item}</a>"
    end

    case tags.length
    when 0
      ""
    when 1
      tags[0].to_s
    else
      "#{tags[0...-1].join(', ')}, #{tags[-1]}"
    end
  end

  def tag_text(tags)

    tags = tags.sort!.map do |item|
      item.gsub(/-+/, ' ').downcase
    end

    case tags.length
    when 0
      ""
    when 1
      tags[0].to_s
    else
      tags.join(' ')
    end
  end

  def tag_json(tags)
    return [] if tags.nil?

    tags = tags.sort!.map do |item|
      item.gsub(/-+/, ' ').downcase
    end

    case tags.length
    when 0
      "null"
    when 1
      %Q{["#{tags[0].to_s}"]}
    else
      taglist = tags.map {|tag|
        %Q{"#{tag}"}
      }.join(',')
      %Q{#{taglist}}
    end
  end

  # Outputs the post.date as formatted html, with hooks for CSS styling.
  #
  #  +date+ is the date object to format as HTML.
  #
  # Returns string
  def date_to_html_string(date)
    result = '<span class="month">' + date.strftime('%b').upcase + '</span> '
    result += date.strftime('<span class="day">%d</span> ')
    result += date.strftime('<span class="year">%Y</span> ')
    result
  end

  def join_path(path, *paths)
    File.join(path, paths) rescue path
  end

  def og_suffix(url, suffix)
    url.sub(/(_(tw|fb|lg|sq))?\.(jpe?g|png|gif)$/, "_#{suffix}.\\3")
  end

  Liquid::Template.register_filter self
end


