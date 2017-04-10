<<<<<<< HEAD
=======
// this handles infinite scroll

>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
$(document).on('turbolinks:load', function () {
  var isLoading = false;
  if ($('#infinite-scrolling').size() > 0) {
    $('.results').on('scroll', function() {
      var more_outlets_url = $('.pagination a.next_page').attr('href');
      if (!isLoading && more_outlets_url && $(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
        isLoading = true;
        $('#loading').removeClass("invisible")
        $.getScript(more_outlets_url).done(function (data,textStatus,jqxhr) {
          $('#loading').addClass("invisible")
          isLoading = false;
        }).fail(function() {
          $('#loading').addClass("invisible")
          isLoading = false;
        });
      }
    });
  }
});
