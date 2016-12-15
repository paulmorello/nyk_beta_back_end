// just for highlighting current nav link
$(document).on('turbolinks:load', function() {
     var pgurl = window.location.href.substr(window.location.href.indexOf(".com/")+4);
     $(".nav a").each(function(){
          if($(this).attr("href") == pgurl || $(this).attr("href") == '' )
          $(this).addClass("active");
     })
});
