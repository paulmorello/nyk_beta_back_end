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
}

$(document).on('turbolinks:load', function() {
  $('.outlet-card').click(toggleShortCard);
  $('.writer-card').click(toggleLongCard);
  $('.campaign-select-all-toggle').change(selectAllWriters);
  $('.campaign-select-all-toggle, .campaign-selector').change(toggleSaveButton);
});
