<<<<<<< HEAD
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// <input type="checkbox" class="campaign-selector" data-id="<%=job.id%>" value="<%=job.id%>"/>

=======


// grabs ids of writers from checkboxes
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var grabJobSelections = function() {
  var checkedValues = $('.campaign-selector:checked').map(function() {
    return this.value;
  }).get();
  return checkedValues;
};
<<<<<<< HEAD

=======
// gets the value of the campaing selection drop down in save to campaign modal
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var grabCampaignSelection = function() {
  var campaignValue = $('.campaign-dropdown').val();
  return campaignValue;
};
<<<<<<< HEAD

=======
// grabs text input of create new campaign modal
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var grabNewCampaignName = function() {
  var name = $('#new_campaign').val();
  return name;
};
<<<<<<< HEAD

=======
// Gets current Users ID
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var grabUserID = function() {
  var user = $('#user_id').val();
  return user;
};
<<<<<<< HEAD

var unselectAll = function() {
  $('.campaign-selector, .campaign-select-all-toggle').prop('checked', false);
}

var toggleRemoveButton = function(e) {
  $('#removeButton').removeClass("hidden");
}

=======
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
  console.log("worked")
  $('.flag-option-wrapper').attr('data-writer-id', $(this).attr('data-id'));
}
// sets the selected class on chosen reason for flagging in the flag modal
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
var selectFlag = function(e) {
  $(e.target).parents('.flag-option-wrapper').find('.flag-option').removeClass("selected");
  $(this).addClass("selected");
  console.log(this)
};
<<<<<<< HEAD

var openCreateCampaignModal = function(e) {
  $('#createCampaignModal').modal('toggle');
};

=======
// opens the modal for creating a campaign, tied to folder icon on sidebar
var openCreateCampaignModal = function(e) {
  $('#createCampaignModal').modal('toggle');
};
// this is for creating and saving jobs at the same time through the creat and save modal
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
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
<<<<<<< HEAD

=======
  // for highlighting selected campaign blue in left side bar
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  var pgurl = window.location.href.substr(window.location.href.indexOf("/campaigns/"));
  $(".campaign-link a").each(function(){
       if($(this).attr("href") == pgurl)
       $(this).addClass("selected-campaign-link");
  })
<<<<<<< HEAD

  $(document).on('change', '.campaign-select-all-toggle', toggleRemoveButton);
  $(document).on('change', '.campaign-selector', toggleRemoveButton);
  $(document).on('click', '.flag-option', selectFlag);
  $('.addCampaignFolder').click(openCreateCampaignModal);

  $('.create-save-campaign-selections').click(createCampaign);

=======
  //  Event Handlers
  $(document).on('change', '.campaign-select-all-toggle', toggleRemoveButton);
  $(document).on('change', '.campaign-selector', toggleRemoveButton);
  $(document).on('click', '.flag-contact', setWriterID);
  $(document).on('click', '.flag-option', selectFlag);
  $('.addCampaignFolder').click(openCreateCampaignModal);
  $('.create-save-campaign-selections').click(createCampaign);
  // for saving jobs to campaign that already exists
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $('.save-campaign-selections').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: grabCampaignSelection(), job_ids: grabJobSelections()} },
    }).done(unselectAll);
  });
<<<<<<< HEAD

=======
  // deleting saved jobs
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $('.remove-campaign-selections').click(function(e) {
    $.ajax({
      type: "DELETE",
      url: "/saved_jobs",
      data: { saved_job: { campaign_id: $('#campaign-name').attr('data-id'), job_ids: grabJobSelections()} },
    });
  });
<<<<<<< HEAD

=======
 // deleting a campaign
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $('.delete-campaign').click(function(e) {
    e.preventDefault();
    $.ajax({
      type: "DELETE",
      url: "/campaigns/"+$('.delete-campaign').attr('data-id'),
    });
  });
<<<<<<< HEAD

=======
  // sending flag values to controller that passes on to mailer
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $('.flag-job').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/campaigns/flag",
      data: {flag: { writer_id: $('.flag-option-wrapper').attr("data-writer-id"), flag_value: $('.flag-option-wrapper').find('.selected').attr('data-value')}},
    });
  });
<<<<<<< HEAD

=======
  // adding thumbs up and down responses to a writer
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $(document).on('click', '.thumbs-up', function(e) {
    $(e.target).parents('.response').find('.thumbs-down').removeClass('selected');
    $(e.target).addClass('selected');
    $.ajax({
      type: "PUT",
      url: "/saved_jobs/"+$(e.target).parents('.saved-job-wrapper').attr('data-id'),
      data: { saved_job: { response: "positive"} },
    });
  });
<<<<<<< HEAD

=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
  $(document).on('click', '.thumbs-down', function(e) {
    $(e.target).parents('.response').find('.thumbs-up').removeClass('selected');
    $(e.target).addClass('selected');
    $.ajax({
      type: "PUT",
      url: "/saved_jobs/"+$(e.target).parents('.saved-job-wrapper').attr('data-id'),
      data: { saved_job: { response: "negative"} },
    });
  });

<<<<<<< HEAD

=======
>>>>>>> 8044ab3c9323e32136c8fe20a82e4a0bd60d0931
});
