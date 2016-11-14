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

var unselectAll = function() {
  $('.campaign-selector, .campaign-select-all-toggle').prop('checked', false);
}

var toggleRemoveButton = function(e) {
  $('#removeButton').removeClass("hidden");
}

var openFlagModal = function(e) {
  $('#flagModal').modal('toggle');
}

var openCreateCampaignModal = function(e) {
  $('#createCampaignModal').modal('toggle');
}

$(document).on('turbolinks:load', function() {

  var pgurl = window.location.href.substr(window.location.href.indexOf("/campaigns/"));
  $(".campaign-link a").each(function(){
       if($(this).attr("href") == pgurl)
       $(this).addClass("selected-campaign-link");
  })

  $(document).on('change', '.campaign-select-all-toggle', toggleRemoveButton);
  $(document).on('change', '.campaign-selector', toggleRemoveButton);
  $(document).on('click', '.flag-contact', openFlagModal);
  $('.addCampaignFolder').click(openCreateCampaignModal);

  $('.save-campaign-selections').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: grabCampaignSelection(), job_ids: grabJobSelections()} },
    }).done(unselectAll);
  });

  $('.remove-campaign-selections').click(function(e) {
    $.ajax({
      type: "DELETE",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: $('#campaign-name').attr('data-id'), job_ids: grabJobSelections()} },
    });
  });

  $('.delete-campaign').click(function(e) {
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: "/campaigns/"+$('.delete-campaign').attr('data-id'),
    });
  });

  $(document).on('click', '.thumbs-up', function(e) {
    $(e.target).parents('.response').find('.thumbs-down').removeClass('selected');
    $(e.target).addClass('selected');
    $.ajax({
      type: "PUT",
      url: "/saved_jobs/"+$(e.target).parents('.saved-job-wrapper').attr('data-id'),
      data: { saved_job: { response: "positive"} },
    });
  });

  $(document).on('click', '.thumbs-down', function(e) {
    $(e.target).parents('.response').find('.thumbs-up').removeClass('selected');
    $(e.target).addClass('selected');
    $.ajax({
      type: "PUT",
      url: "/saved_jobs/"+$(e.target).parents('.saved-job-wrapper').attr('data-id'),
      data: { saved_job: { response: "negative"} },
    });
  });

});
