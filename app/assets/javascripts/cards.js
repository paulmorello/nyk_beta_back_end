// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

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

var toggleLongCard = function(e) {
  if (e.target.tagName.toLowerCase() !== 'a' && e.target.tagName.toLowerCase() !== 'input' && e.target.tagName.toLowerCase() !== 'svg') {
    $(e.target).parents('.writer-card').find('.writer-card-bottom').toggleClass("hidden");
  };
}

var selectAllWriters = function(e) {
  if (this.checked) {
    $(e.target).parents('.outlet-writer-wrapper').find('.campaign-selector').prop('checked',true);
  } else if (!this.checked) {
    $(e.target).parents('.outlet-writer-wrapper').find('.campaign-selector').prop('checked', false);
  };
};

var toggleSaveButton = function(e) {
  $('#saveButton').removeClass("hidden");
  $('#clearSaveButton').removeClass("hidden");
}

var clearSelections = function(e) {
  $(".results").find(":checkbox").prop('checked',false);
  $('#saveButton').addClass("hidden");
  $('#clearSaveButton').addClass("hidden");
}

$(document).ready(function() {
  $(document).on('click', '.outlet-card', toggleShortCard);
  $(document).on('click', '.writer-card', toggleLongCard);
  $(document).on('click', '#clearSaveButton', clearSelections);
  $(document).on('change', '.campaign-select-all-toggle', selectAllWriters);
  $(document).on('change', '.campaign-select-all-toggle', toggleSaveButton);
  $(document).on('change', '.campaign-selector', toggleSaveButton);
});
