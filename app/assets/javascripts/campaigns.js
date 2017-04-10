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

var grabNewCampaignName = function() {
  var name = $('#new_campaign').val();
  return name;
};

var grabUserID = function() {
  var user = $('#user_id').val();
  return user;
};

var unselectAll = function() {
  $('.campaign-selector, .campaign-select-all-toggle').prop('checked', false);
}

var toggleRemoveButton = function(e) {
  $('#removeButton').removeClass("hidden");
}

var selectFlag = function(e) {
  $(e.target).parents('.flag-option-wrapper').find('.flag-option').removeClass("selected");
  $(this).addClass("selected");
  console.log(this)
};

var openCreateCampaignModal = function(e) {
  $('#createCampaignModal').modal('toggle');
};

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

  var pgurl = window.location.href.substr(window.location.href.indexOf("/campaigns/"));
  $(".campaign-link a").each(function(){
       if($(this).attr("href") == pgurl)
       $(this).addClass("selected-campaign-link");
  })

  $(document).on('change', '.campaign-select-all-toggle', toggleRemoveButton);
  $(document).on('change', '.campaign-selector', toggleRemoveButton);
  $(document).on('click', '.flag-option', selectFlag);
  $('.addCampaignFolder').click(openCreateCampaignModal);

  $('.create-save-campaign-selections').click(createCampaign);

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

  $('.flag-job').click(function(e) {
    $.ajax({
      type: "POST",
      url: "/campaigns/flag",
      data: {flag: { writer_id: $('.flag-option-wrapper').attr("data-writer-id"), flag_value: $('.flag-option-wrapper').find('.selected').attr('data-value')}},
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
