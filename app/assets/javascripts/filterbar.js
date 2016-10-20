var toggleShowWriters = function() {
    if(this.checked) {
      $('.outlet-writer-wrapper').find('.writer-card-top, .writer-card-bottom').removeClass("hidden");
    } else if (!this.checked) {
      $('.outlet-writer-wrapper').find('.writer-card-top, .writer-card-bottom').addClass("hidden");
    };
};


$(document).on('turbolinks:load', function() {
  $('#filter_params_genre_id').multiselect({
    maxHeight: 300,
    buttonWidth: 225,
    includeSelectAllOption: true,
    buttonClass: "form-control"
  });
  $('#filter_params_presstype_id').multiselect({
    maxHeight: 300,
    buttonWidth: 225,
    includeSelectAllOption: true,
    buttonClass: "form-control"
  });
  $('#show-writers').change(toggleShowWriters);
});
