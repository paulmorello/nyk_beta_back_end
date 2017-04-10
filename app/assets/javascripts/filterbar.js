// var toggleShowWriters = function() {
//     if(this.checked) {
//       $('.outlet-writer-wrapper').find('.writer-card-top').removeClass("hidden");
//     } else if (!this.checked) {
//       $('.outlet-writer-wrapper').find('.outlet-card-bottom, .writer-card-top, .writer-card-bottom').addClass("hidden");
//     };
// };

<<<<<<< HEAD
var clearSearch = function(e) {
  $('#q').val('');
};

=======
// clears search bar
var clearSearch = function(e) {
  $('#q').val('');
};
// configures multi-select plugin options for genre and press type drop downs
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
$(document).on('turbolinks:load', function() {
  if ($('.multiselect-native-select')[0] == undefined) {
    $('#filter_params_genre_id').multiselect({
      maxHeight: 300,
      buttonWidth: 245,
      includeSelectAllOption: true,
      buttonClass: "form-control"
    });
    $('#filter_params_presstype_id').multiselect({
      maxHeight: 300,
      buttonWidth: 245,
      includeSelectAllOption: true,
      buttonClass: "form-control"
    });
  }
<<<<<<< HEAD
  // $('#show-writers').change(toggleShowWriters);
=======
  // event handler
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $('.clear-search').click(clearSearch);
});
