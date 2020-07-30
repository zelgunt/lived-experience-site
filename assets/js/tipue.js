
/*
Tipue Search 3.0
Copyright (c) 2013 Tipue
Tipue Search is released under the MIT License
http://www.tipue.com/search
*/

var tipuesearch_stop_words = ["and", "be", "by", "do", "for", "he", "how", "if", "is", "it", "my", "not", "of", "or", "the", "to", "up", "what", "when"];

var tipuesearch_replace = {"words": [
     {"word": "tipua", replace_with: "tipue"},
     {"word": "javscript", replace_with: "javascript"}
]};

var tipuesearch_stem = {"words": [
     {"word": "e-mail", stem: "email"},
     {"word": "javascript", stem: "script"},
     {"word": "javascript", stem: "js"}
]};


/*
Tipue Search 3.0
Copyright (c) 2013 Tipue
Tipue Search is released under the MIT License
http://www.tipue.com/search
*/

var btsearch_stop_words = ["abey","about","abov","absenc","absolut","abund","abundantli","acced","acceler","accentu","accommod","accompani","accomplish","accord","accordingli","acknowledg","acquaint","acquiesc","acquir","across","actual","addit","adjac","adjust","admiss","advanc","advantag","advis","affect","affix","afford","aforesaid","after","again","against","aggreg","align","aligncent","alignleft","alignright","all","allevi","alloc","allowfullscreen","almost","alon","along","alreadi","also","altern","although","alwai","amelior","amend","among","analysi","and","ani","annum","anoth","anticip","anybodi","anyon","anyth","anywher","appar","applic","appreci","appris","appropri","approxim","april","area","arent","around","ascertain","ask","assembl","assist","attempt","attend","attent","attribut","august","author","authoris","awai","axiomat","back","basic","becam","becaus","becom","been","befor","began","behalf","behind","belat","benefici","best","bestow","better","between","big","both","breach","but","calcul","came","can","cannot","cant","case","ceas","certain","certainli","circumv","clarif","clear","clearli","combin","come","commenc","commun","compet","compil","complet","compli","compon","compris","compulsori","conceal","concern","conclus","concur","condit","conjunct","connect","consequ","consider","constitut","constru","consult","consumpt","contempl","contrari","copi","correct","correspond","cost","could","counter","cours","courteou","cumul","current","customari","dai","date","decemb","deduct","deem","defer","defici","delai","delet","demonstr","denot","depict","design","desir","despatch","despit","determin","detriment","did","didnt","differ","difficulti","diminish","disburs","discharg","disclos","disconnect","discontinu","discret","discuss","dispatch","dissemin","document","doe","domicil","domin","done","dont","down","drawn","due","durat","dure","dwell","each","earli","econom","effect","either","elig","elucid","emphasis","empow","enabl","enclos","encount","end","endeavour","enough","enquir","enquiri","ensur","entitl","envisag","equal","equival","erron","establish","evalu","even","evenli","event","ever","everi","everybodi","everyon","everyth","everywher","evinc","exactli","exception","excess","exclud","exclus","exempt","exist","expedit","expediti","expenditur","expir","extant","extent","extrem","fabric","face","facilit","fact","factor","failur","far","februari","felt","few","final","finalis","find","first","five","follow","for","formul","forthwith","forward","four","frequent","from","full","fulli","furnish","further","furthermor","futur","gave","gener","get","give","given","gone","good","got","grant","great","greater","greatest","ground","group","had","hard","have","henceforth","her","here","herebi","herein","hereinaft","hereof","hereto","heretofor","hereund","herewith","herself","high","higher","highest","him","himself","hitherto","hold","hope","hot","how","howev","ill","illustr","immedi","implement","impli","import","inappropri","incept","includ","incorpor","incur","indic","inform","initi","insert","instanc","instead","intend","intent","interest","intim","into","irrespect","issu","itself","januari","jeopardis","juli","june","just","keep","kind","knew","know","known","larg","last","late","later","latest","least","less","let","liais","lieu","like","line","link","lion","local","locat","lol","long","longer","longest","look","made","magnitud","mai","major","make","man","manag","mandatori","mani","manner","manufactur","march","margin","materi","materialis","matter","mean","member","men","merchandis","might","mind","minimum","mislai","miss","modif","moment","month","more","moreov","most","mostli","much","must","myself","near","necessari","need","neglig","neighbourhood","never","nevertheless","new","newer","newest","next","nobodi","non","noon","nope","not","noth","notic","notifi","notwithstand","novemb","now","nowher","number","numer","object","obligatori","obtain","obvious","occas","octob","of/that","off","officio","often","old","older","oldest","onc","onli","open","oper","opinion","opportun","optimum","option","order","ordinarili","other","otherwis","our","out","outstand","over","own","part","partial","particip","particular","past","per","percentag","perfect","perform","perhap","period","permiss","permit","person","personnel","perus","place","plain","pleas","pleasur","point","possess","possibl","post","power","practic","predomin","prescrib","present","preserv","pretti","previou","princip","prior","probabl","problem","proce","procur","profus","progress","prohibit","project","prolong","promptli","promulg","proport","provid","provis","proxim","purchas","purpos","pursuant","put","qualifi","question","quit","rather","read","realli","reason","receipt","reconsid","record","reduc","reduct","refer","regard","regul","reimburs","reiter","relat","remain","remaind","remitt","remuner","render","repres","request","requir","resid","respect","restrict","result","retain","review","revis","right","room","sai","said","same","saw","scrutinis","second","see","seem","seen","select","septemb","set","settl","sever","shall","she","should","show","side","similarli","sinc","site","size","small","smaller","smallest","sole","some","somebodi","someon","someth","somewher","specifi","start","state","statutori","still","subject","submit","subsequ","substanti","such","suffici","sum","supplement","supplementari","suppli","sure","sweet","take","taken","tell","tenant","termin","than","that","the","thei","their","them","then","there","thereaft","therebi","therefor","therein","thereof","thereto","these","theyll","theyv","thi","thing","think","those","though","thought","three","through","thu","time","todai","togeth","too","took","total","toward","transfer","transmit","trust","try","turn","tweet","two","type","ultim","unavail","under","undernot","undersign","understood","undertak","uniform","unilater","unless","unoccupi","until","updat","upon","usual","utilis","variat","veri","view","virtual","visualis","wai","wait","want","week","well","went","were","weve","what","whatsoev","when","whensoev","where","wherea","whether","which","while","who","whole","whose","why","will","with","within","without","work","would","yeah","year","yet","you","youll","young","younger","youngest","your","yourself","youv","zone"];

var btsearch_replace = {"words": [
     {"word": "trpstra", replace_with: "terpstra"}
]};

var btsearch_stem = {"words": [
     {"word": "e-mail", stem: "email"},
     {"word": "javascript", stem: "script"},
     {"word": "javascript", stem: "js"}
]};

(function($) {

     $.fn.btsearch = function(options) {

          var delay = (function(){
               var timer = 0;
               return function(callback, ms){
                    clearTimeout (timer);
                    timer = setTimeout(callback, ms);
               };
          })();
          var searching = false;

          var set = $.extend( {

               'show'                   : 7,
               'newWindow'              : false,
               'showURL'                : true,
               'showTags'               : true,
               'minimumLength'          : 3,
               'descriptiveWords'       : 25,
               'highlightTerms'         : true,
               'highlightEveryTerm'     : false,
               'mode'                   : 'static',
               'liveDescription'        : '*',
               'liveContent'            : '*',
               'contentLocation'        : 'btsearch/btsearch_content.json'

          }, options);

          return this.each(function() {

               var btsearch_in = {
                    pages: []
               };
               $.ajaxSetup({
                    async: false
               });

               if (set.mode == 'live')
               {
                    for (var i = 0; i < btsearch_pages.length; i++)
                    {
                         $.get(btsearch_pages[i], '',
                              function (html)
                              {
                                   var cont = $(set.liveContent, html).text().replace(/\s+/g, ' '),
                                        desc = $(set.liveDescription, html).text().replace(/\s+/g, ' '),
                                        t_1 = html.toLowerCase().indexOf('<title>'),
                                        t_2 = html.toLowerCase().indexOf('</title>', t_1 + 7),
                                        tit;

                                   if (t_1 != -1 && t_2 != -1)
                                   {
                                        tit = html.slice(t_1 + 7, t_2);
                                   }
                                   else
                                   {
                                        tit = 'No title';
                                   }

                                   btsearch_in.pages.push({
                                        "title": tit,
                                        "text": desc,
                                        "tags": cont,
                                        "loc": btsearch_pages[i]
                                   });
                              }
                         );
                    }
               }

               if (set.mode == 'json')
               {
                    $.getJSON(set.contentLocation,
                         function(json)
                         {
                              btsearch_in = $.extend({}, json);
                         }
                    );
               }

               if (set.mode == 'static')
               {
                    btsearch_in = $.extend({}, btsearch);
               }

               var tipue_search_w = '';
               if (set.newWindow)
               {
                    tipue_search_w = ' target="_blank"';
               }

               function getURLP(name)
               {
                    return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20')) || null;
               }
               if (getURLP('q'))
               {
                    $('#typeahead').val(getURLP('q'));
                    $('#searchspinner').show();
                    getbtsearch(0, true);
               }

               $('#tipue_search_button').click(function()
               {
                    getbtsearch(0, true);
               });
               $(this).keyup(function(event)
               {
                    if(event.keyCode == '13' && !searching)
                    {
                         getbtsearch(0, true);
                    }
               });

               function getbtsearch(start, replace)
               {
                    var i, f, d, d_w, d_r, patr,
                         out = '',
                         results = '',
                         show_replace = false,
                         show_stop = false;

                    $('#searchresults').hide();
                    $('#searchspinner').show();

                    d = $('#typeahead').val().toLowerCase();
                    d = $.trim(d);

                    if (d !== '') {
                         out = '<p class="error">Uh oh, nothing found for "'+$('#typeahead').val()+'"</p>';
                    }
                    d_w = d.split(' ');
                    d = '';
                    for (i = 0; i < d_w.length; i++)
                    {
                         var a_w = true;
                         for (f = 0; f < btsearch_stop_words.length; f++)
                         {
                              if (d_w[i] == btsearch_stop_words[f])
                              {
                                   a_w = false;
                                   show_stop = true;
                              }
                         }
                         if (a_w)
                         {
                              d = d + ' ' + d_w[i];
                         }
                    }
                    d = $.trim(d);
                    d_w = d.split(' ');

                    if (d.length >= set.minimumLength)
                    {
                         if (replace)
                         {
                              d_r = d;
                              for (i = 0; i < d_w.length; i++)
                              {
                                   for (f = 0; f < btsearch_replace.words.length; f++)
                                   {
                                        if (d_w[i] == btsearch_replace.words[f].word)
                                        {
                                             d = d.replace(d_w[i], btsearch_replace.words[f].replace_with);
                                             show_replace = true;
                                        }
                                   }
                              }
                              d_w = d.split(' ');
                         }

                         var d_t = d;
                         for (i = 0; i < d_w.length; i++)
                         {
                              for (f = 0; f < btsearch_stem.words.length; f++)
                              {
                                   if (d_w[i] == btsearch_stem.words[f].word)
                                   {
                                        d_t = d_t + ' ' + btsearch_stem.words[f].stem;
                                   }
                              }
                         }
                         d_w = d_t.split(' ');

                         var c = 0;
                         found = new Array();
                         for (i = 0; i < btsearch_in.pages.length; i++)
                         {
                              var score = 1000000000;
                              var s_t = btsearch_in.pages[i].text;
                              for (f = 0; f < d_w.length; f++)
                              {
                                   var pat = new RegExp(d_w[f], 'i');
                                   if (btsearch_in.pages[i].title.search(pat) != -1)
                                   {
                                        score -= (200000 - i);
                                   }
                                   if (btsearch_in.pages[i].text.search(pat) != -1)
                                   {
                                        score -= (150000 - i);
                                   }

                                   if (set.highlightTerms)
                                   {
                                        if (set.highlightEveryTerm)
                                        {
                                             patr = new RegExp('(' + d_w[f] + ')', 'gi');
                                        }
                                        else
                                        {
                                             patr = new RegExp('(' + d_w[f] + ')', 'i');
                                        }
                                        s_t = s_t.replace(patr, "<mark>$1</mark>");
                                   }
                                   if (btsearch_in.pages[i].tags.search(pat) != -1)
                                   {
                                        score -= (100000 - i);
                                   }

                              }
                              if (score < 1000000000)
                              {
                                   found[c++] = score + '^' + btsearch_in.pages[i].title + '^' + s_t + '^' + btsearch_in.pages[i].loc + '^' + btsearch_in.pages[i].tags;
                              }
                         }

                         if (c !== 0)
                         {
                              found.sort();
                              var l_o = 0;
                              out = '<ul>';

                              for (i = 0; i < found.length; i++)
                              {
                                   var fo = found[i].split('^');
                                   if (l_o >= start && l_o < set.show + start)
                                   {
                                        out += '<li><a href="' + fo[3] + '"' + tipue_search_w + '>' +  fo[1] + '</a>';

                                        var t = fo[2];
                                        var t_d = '';
                                        var t_w = t.split(' ');
                                        if (t_w.length < set.descriptiveWords)
                                        {
                                             t_d = t;
                                        }
                                        else
                                        {
                                             for (f = 0; f < set.descriptiveWords; f++)
                                             {
                                                  t_d += t_w[f] + ' ';
                                             }
                                        }
                                        t_d = $.trim(t_d);
                                        if (t_d.charAt(t_d.length - 1) != '.')
                                        {
                                             t_d += ' ...';
                                        }
                                        out += '<p>' + t_d + '</p>';

                                        if (set.showURL || set.showTags) {
                                             out += '<div class="meta">';

                                             if (set.showURL)
                                             {
                                                  t_url = fo[3];
                                                  if (t_url.length > 45)
                                                  {
                                                       t_url = fo[3].substr(0, 45) + ' ...';
                                                  }
                                                  out += '<span class="searchresults_loc"><a href="' + fo[3] + '"' + tipue_search_w + ' tabindex="-1">' + t_url + '</a></span>';
                                             }
                                             if (set.showTags)
                                             {
                                                  var tags = fo[4].trim().split(' ').map(function(tag) {
                                                       return '<a tabindex="-1" href="/topics/' + tag + '">' + tag + '</a>';
                                                  }).join(" ");
                                                  out += '<span class="tags">' + tags + '</span>';
                                             }

                                             out += "</div>";
                                        }

                                        out += '</li>';
                                   }
                                   l_o++;
                              }
                              out += '</ul>';
                              if (c > set.show)
                              {
                                   var pages = Math.ceil(c / set.show);
                                   var page = (start / set.show);
                                   out += '<div id="tipue_search_foot"><ul id="tipue_search_foot_boxes">';

                                   if (start > 0)
                                   {
                                       out += '<li><a href="javascript:void(0)" class="tipue_search_foot_box" id="' + (start - set.show) + '_' + replace + '">Prev</a></li>';
                                   }

                                   if (page <= 2)
                                   {
                                        var p_b = pages;
                                        if (pages > 3)
                                        {
                                             p_b = 3;
                                        }
                                        for (f = 0; f < p_b; f++)
                                        {
                                             if (f == page)
                                             {
                                                  out += '<li class="current">' + (f + 1) + '</li>';
                                             }
                                             else
                                             {
                                                  out += '<li><a href="javascript:void(0)" class="tipue_search_foot_box" id="' + (f * set.show) + '_' + replace + '">' + (f + 1) + '</a></li>';
                                             }
                                        }
                                   }
                                   else
                                   {
                                        p_b = pages + 2;
                                        if (p_b > pages)
                                        {
                                             p_b = pages;
                                        }
                                        for (f = page; f < p_b; f++)
                                        {
                                             if (f == page)
                                             {
                                                  out += '<li class="current">' + (f + 1) + '</li>';
                                             }
                                             else
                                             {
                                                  out += '<li><a href="javascript:void(0)" class="tipue_search_foot_box" id="' + (f * set.show) + '_' + replace + '">' + (f + 1) + '</a></li>';
                                             }
                                        }
                                   }

                                   if (page + 1 != pages)
                                   {
                                       out += '<li><a href="javascript:void(0)" class="tipue_search_foot_box" id="' + (start + set.show) + '_' + replace + '">Next</a></li>';
                                   }

                                   out += '</ul></div>';
                              }
                         }

                    }
                    $('#searchspinner').hide();
                    $('#searchresults').html(out);
                    $('#searchresults').slideDown(200);

                    $('#tipue_search_replaced').click(function()
                    {
                         getbtsearch(0, false);
                    });

                    $('.tipue_search_foot_box').click(function()
                    {
                         var id_v = $(this).attr('id');
                         var id_a = id_v.split('_');

                         getbtsearch(parseInt(id_a[0], 10), id_a[1]);
                    });
               }

               function progressIndicator(state)
               {
                    if (state) {
                         $('#typeahead').css({ background: "#fff url(/images/ajax-loader.gif) no-repeat 90% 50%" });
                    } else {
                         $('#typeahead').css({ background: "#fff" });
                    }
               }

               $('#typeahead').on('keypress keyup', function(e) {
                    if ($(this).val().replace(/\s+/,'').length < 3) { return true; }
                    if (!searching) {
                         progressIndicator(true);
                         searching = true;
                         $('#searchspinner').show();
                    }
                    delay(function(){
                         getbtsearch(0, true);
                         progressIndicator(false);
                         searching = false;
                    }, 200 );
                    return true;
               }).on('keydown', function(e) {
                    if(e.keyCode === 8) {
                         if (!(/^\s*$/).test($('#typeahead').val())) {
                              getbtsearch(0, true);
                         } else {
                              progressIndicator(false);
                              searching = false;
                         }
                    } else if (e.keyCode === 27) {
                         e.preventDefault();
                         $('#typeahead').val('');
                         progressIndicator(false);
                         searching = false;
                         return false;
                    }
                    return true;
               });

          });
     };

     $('#typeahead').btsearch({
       'show': 50,
       'mode': 'json',
       'contentLocation': '/search/bt.json',
       'showURL': true
     });

})(jQuery);

