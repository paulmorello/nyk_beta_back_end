// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var toggleShortCard = function(e) {
  if (e.target.tagName.toLowerCase() !== 'a') {
    $(e.target).parents('.outlet-writer-wrapper').find('.writer-card-bottom').addClass("hidden");
    $(e.target).parents('.outlet-writer-wrapper').find('.writer-card-top').toggleClass("hidden");
  };
};

var toggleLongCard = function(e) {
  if (e.target.tagName.toLowerCase() !== 'a') {
    $(e.target).parents('.writer-card').find('.writer-card-bottom').toggleClass("hidden");
  };
}

$(document).on('turbolinks:load', function() {
  $('.outlet-card').click(toggleShortCard);
  $('.writer-card-top').click(toggleLongCard);
});
