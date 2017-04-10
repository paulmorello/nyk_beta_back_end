<<<<<<< HEAD
=======
// just for highlighting current nav link
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
$(document).on('turbolinks:load', function() {
     var pgurl = window.location.href.substr(window.location.href.indexOf(".com/")+4);
     $(".nav a").each(function(){
          if($(this).attr("href") == pgurl || $(this).attr("href") == '' )
          $(this).addClass("active");
     })
});
