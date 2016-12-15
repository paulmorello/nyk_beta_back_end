

// grabs ids of writers from checkboxes
var grabJobSelections = function() {
  var checkedValues = $('.campaign-selector:checked').map(function() {
    return this.value;
  }).get();
  return checkedValues;
};
// gets the value of the campaing selection drop down in save to campaign modal
var grabCampaignSelection = function() {
  var campaignValue = $('.campaign-dropdown').val();
  return campaignValue;
};
// grabs text input of create new campaign modal
var grabNewCampaignName = function() {
  var name = $('#new_campaign').val();
  return name;
};
// Gets current Users ID
var grabUserID = function() {
  var user = $('#user_id').val();
  return user;
};
// Unselects all checkboxes
var unselectAll = function() {
  $('.campaign-selector, .campaign-select-all-toggle').prop('checked', false);
}
// hides/reveals button for removing writers
var toggleRemoveButton = function(e) {
  $('#removeButton').removeClass("hidden");
}
// sets the data-writer-id attribute in the flag modal which is later assed to the mailer along with choice of flag
var setWriterID = function(e) {
  // grab data-id attr tied to flag button clicked on and put in data-writer-id attr on flag option modal
}
// sets the selected class on chosen reason for flagging in the flag modal
var selectFlag = function(e) {
  $(e.target).parents('.flag-option-wrapper').find('.flag-option').removeClass("selected");
  $(this).addClass("selected");
  console.log(this)
};
// opens the modal for creating a campaign, tied to folder icon on sidebar
var openCreateCampaignModal = function(e) {
  $('#createCampaignModal').modal('toggle');
};
// this is for creating and saving jobs at the same time through the creat and save modal
var createCampaign = function() {
  $.ajax({
    type: "POST",
    url: "/campaigns",
    dataType: "json",
    data: { campaign: { name: grabNewCampaignName(), user_id: grabUserID()} },
  }).done(function(data) {
    var campaignID = data['id'];
    $.ajax({
      type: "POST",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: campaignID, job_ids: grabJobSelections()} },
    }).done(unselectAll);
  });
};



$(document).on('turbolinks:load', function() {
  // for highlighting selected campaign blue in left side bar
  var pgurl = window.location.href.substr(window.location.href.indexOf("/campaigns/"));
  $(".campaign-link a").each(function(){
       if($(this).attr("href") == pgurl)
       $(this).addClass("selected-campaign-link");
  })
  //  Event Handlers
  $(document).on('change', '.campaign-select-all-toggle', toggleRemoveButton);
  $(document).on('change', '.campaign-selector', toggleRemoveButton);
  $(document).on('click', '.flag-option', selectFlag);
  $('.addCampaignFolder').click(openCreateCampaignModal);
  $('.create-save-campaign-selections').click(createCampaign);
  // for saving jobs to campaign that already exists
  $('.save-campaign-selections').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: grabCampaignSelection(), job_ids: grabJobSelections()} },
    }).done(unselectAll);
  });
  // deleting saved jobs
  $('.remove-campaign-selections').click(function(e) {
    $.ajax({
      type: "DELETE",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: $('#campaign-name').attr('data-id'), job_ids: grabJobSelections()} },
    });
  });
 // deleting a campaign
  $('.delete-campaign').click(function(e) {
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: "/campaigns/"+$('.delete-campaign').attr('data-id'),
    });
  });
  // sending flag values to controller that passes on to mailer
  $('.flag-job').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/campaigns/flag",
      data: {flag: { writer_id: $('.flag-option-wrapper').attr("data-writer-id"), flag_value: $('.flag-option-wrapper').find('.selected').attr('data-value')}},
    });
  });
  // adding thumbs up and down responses to a writer
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
