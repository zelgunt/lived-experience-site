(function($){
	$(".bt-video-container a.youtube").each(function(index) {
	  var $this = $(this),
	      embedURL,
	      videoFrame,
	      youtubeId = $this.data("videoid");

	  // empty any placeholders
	  $this.html('');
	  $this.prepend('<div class="bt-video-container-div"></div>&nbsp;');
	  // set the poster image from YT as the background for the div (sized to cover in CSS)
	  $this.css("background", "#000 url(http://img.youtube.com/vi/"+youtubeId+"/maxresdefault.jpg) center center no-repeat");
	  // set a unique id based on video ID.
	  $this.attr("id", "yt" + youtubeId);
	  // create an embed url.
	  // leave off the protocol to prevent http/https mismatch
	  // youtube-nocookie prevents YouTube from tracking your visitors *unless* they play the video
	  // autoplay makes sense because they've already clicked
	  // rel=0 prevents "Related Videos" from displaying at the end of the video
	  embedUrl = '//www.youtube-nocookie.com/embed/' + youtubeId + '?autoplay=1&rel=0';
	  // set up the embed iframe for injection. Hardcode the dimensions based on those passed in the video tag.
	  videoFrame = '<iframe width="' + parseInt($this.data("width"), 10) + '" height="' + parseInt($this.data("height"), 10) + '" style="vertical-align:top;" src="' + embedUrl + '" frameborder="0" allowfullscreen></iframe>';
	  // add a click handler to the link which stops it from following the default href and replaces it with the iframe we created
	  $this.click(function(ev) {
	    ev.preventDefault();
	    $("#yt" + youtubeId).replaceWith(videoFrame);
	    return false;
	  });
	});
	$(".bt-video-container a.vimeo").each(function(index) {
	  var $this = $(this),
	      embedURL,
	      videoFrame,
	      vimeoID = $this.data("videoid");

	  // empty any placeholders
	  $this.html('');
	  $this.prepend('<div class="bt-video-container-div"></div>&nbsp;');
	  // set the poster image from YT as the background for the div (sized to cover in CSS)
	  // set a unique id based on video ID.
	  $this.attr("id", "vi" + vimeoID);
	  // create an embed url.
	  embedUrl = '//player.vimeo.com/video/' + vimeoID;
	  // set up the embed iframe for injection. Hardcode the dimensions based on those passed in the video tag.
	  videoFrame = '<iframe width="' + parseInt($this.data("width"), 10) + '" height="' + parseInt($this.data("height"), 10) + '" style="vertical-align:top;" src="' + embedUrl + '" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';

	  $("#vi" + vimeoID).replaceWith(videoFrame);
	});

	$('#main article').tldr({
	      headerTag: 'h4 class=blocktitle', // the tag for the header above the list
	      headerTitle: '<span class="tldrarrow">&#9660;</span> Summary',
	      dataAttribute: 'summary',
	      collapsed: false, // if true, summaries collapse and expand on headline clicks
	      insertAfterLead: false, // insert the output before the first headline instead of at the top
	      grafsInSummary: 1, // number of paragraphs to summarize, 0 for unlimited
	      sentencesPerGraf: 0, // sentences per graf in summary, 0 for unlimited
	      maxSummaryLength: 300, // maximum characters in summary, 0 for unlimited
	      minimumHeadlines: 3 // minimum number of headlines in text required to execute
	    });

	$('.tldr-wrapper h4').click(function() {
	  $(this).parent('.tldr-wrapper').toggleClass('open');
	  $(this).next('ul,ol').slideToggle(200);
	});
})(jQuery);

