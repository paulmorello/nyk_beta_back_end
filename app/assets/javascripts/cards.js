


// expands outlet card and shows short writer cards/and reverse
var toggleShortCard = function(e) {
  if (e.target.tagName.toLowerCase() !== 'a' && e.target.tagName.toLowerCase() !== 'input' && e.target.tagName.toLowerCase() !== 'svg') {
    var checked = $('#show-writers').is(':checked');
    $(e.target).parents('.outlet-writer-wrapper').find('.outlet-card-bottom').toggleClass("hidden");
    $(e.target).parents('.outlet-writer-wrapper').find('.writer-card-bottom').addClass("hidden");
    if (!checked) {
      $(e.target).parents('.outlet-writer-wrapper').find('.writer-card-top').toggleClass("hidden");
    };
  };
};
// expands writer cards/ and reverse
var toggleLongCard = function(e) {
  if (e.target.tagName.toLowerCase() !== 'a' && e.target.tagName.toLowerCase() !== 'input' && e.target.tagName.toLowerCase() !== 'svg') {
    $(e.target).parents('.writer-card').find('.writer-card-bottom').toggleClass("hidden");
  };
}
// selects all writer checkboxes if Outlet checkbox is selected
var selectAllWriters = function(e) {
  if (this.checked) {
    $(e.target).parents('.outlet-writer-wrapper').find('.campaign-selector').prop('checked',true);
  } else if (!this.checked) {
    $(e.target).parents('.outlet-writer-wrapper').find('.campaign-selector').prop('checked', false);
  };
};
// When checkboxes are selected, reveals/hides save and clear buttons
var toggleSaveButton = function(e) {
  $('#saveButton').removeClass("hidden");
  $('#clearSaveButton').removeClass("hidden");
}
// clears selections with clear button
var clearSelections = function(e) {
  $(".results").find(":checkbox").prop('checked',false);
  $('#saveButton').addClass("hidden");
  $('#clearSaveButton').addClass("hidden");
}
// event handlers
$(document).ready(function() {
  $(document).on('click', '.outlet-card', toggleShortCard);
  $(document).on('click', '.writer-card', toggleLongCard);
  $(document).on('click', '#clearSaveButton', clearSelections);
  $(document).on('change', '.campaign-select-all-toggle', selectAllWriters);
  $(document).on('change', '.campaign-select-all-toggle', toggleSaveButton);
  $(document).on('change', '.campaign-selector', toggleSaveButton);
});
