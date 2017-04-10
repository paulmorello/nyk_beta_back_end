<<<<<<< HEAD
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

=======



// expands outlet card and shows short writer cards/and reverse
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
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
<<<<<<< HEAD

=======
// expands writer cards/ and reverse
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var toggleLongCard = function(e) {
  if (e.target.tagName.toLowerCase() !== 'a' && e.target.tagName.toLowerCase() !== 'input' && e.target.tagName.toLowerCase() !== 'svg') {
    $(e.target).parents('.writer-card').find('.writer-card-bottom').toggleClass("hidden");
  };
}
<<<<<<< HEAD

=======
// selects all writer checkboxes if Outlet checkbox is selected
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var selectAllWriters = function(e) {
  if (this.checked) {
    $(e.target).parents('.outlet-writer-wrapper').find('.campaign-selector').prop('checked',true);
  } else if (!this.checked) {
    $(e.target).parents('.outlet-writer-wrapper').find('.campaign-selector').prop('checked', false);
  };
};
<<<<<<< HEAD

=======
// When checkboxes are selected, reveals/hides save and clear buttons
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var toggleSaveButton = function(e) {
  $('#saveButton').removeClass("hidden");
  $('#clearSaveButton').removeClass("hidden");
}
<<<<<<< HEAD

=======
// clears selections with clear button
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var clearSelections = function(e) {
  $(".results").find(":checkbox").prop('checked',false);
  $('#saveButton').addClass("hidden");
  $('#clearSaveButton').addClass("hidden");
}
<<<<<<< HEAD

=======
// event handlers
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
$(document).ready(function() {
  $(document).on('click', '.outlet-card', toggleShortCard);
  $(document).on('click', '.writer-card', toggleLongCard);
  $(document).on('click', '#clearSaveButton', clearSelections);
  $(document).on('change', '.campaign-select-all-toggle', selectAllWriters);
  $(document).on('change', '.campaign-select-all-toggle', toggleSaveButton);
  $(document).on('change', '.campaign-selector', toggleSaveButton);
});
