var toggleShowWriters = function() {
    if(this.checked) {
      $('.outlet-writer-wrapper').find('.writer-card-top, .writer-card-bottom').removeClass("hidden");
    } else if (!this.checked) {
      $('.outlet-writer-wrapper').find('.writer-card-top, .writer-card-bottom').addClass("hidden");
    };
};


$(document).on('turbolinks:load', function() {
  $('#show-writers').change(toggleShowWriters);
});
