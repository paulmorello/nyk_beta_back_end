// var toggleShowWriters = function() {
//     if(this.checked) {
//       $('.outlet-writer-wrapper').find('.writer-card-top').removeClass("hidden");
//     } else if (!this.checked) {
//       $('.outlet-writer-wrapper').find('.outlet-card-bottom, .writer-card-top, .writer-card-bottom').addClass("hidden");
//     };
// };

var clearSearch = function(e) {
  $('#q').val('');
};

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
  // $('#show-writers').change(toggleShowWriters);
  $('.clear-search').click(clearSearch);
});
