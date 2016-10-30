// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// <input type="checkbox" class="campaign-selector" data-id="<%=job.id%>" value="<%=job.id%>"/>

var grabJobSelections = function() {
  var checkedValues = $('.campaign-selector:checked').map(function() {
    return this.value;
  }).get();
  return checkedValues;
};

var grabCampaignSelection = function() {
  var campaignValue = $('.campaign-dropdown').val();
  return campaignValue;
};



$(document).on('turbolinks:load', function() {

  $('.save-campaign-selections').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: grabCampaignSelection(), job_ids: grabJobSelections()} },

    });
  });
});
