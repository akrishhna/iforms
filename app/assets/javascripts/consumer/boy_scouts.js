// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){

  $('.boy_scout_permission_form input, .boy_scout_permission_form select').change(function () {
    $('input[name=_method]').val('post');
    var params = $('.boy_scout_permission_form').serializeArray();
    $.post('/consumer/boy_scouts/boy_scouts_permission_form', params);
    return false;
  });

  $('#notification_email_to_troop_leader').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }
    $(this).attr('disabled', "disabled");
    $(this).text('Sending Email Notification to Troop Leader...');
    var id = $('.boy_scout_permission_form #boy_scouts_activity_consent_form_id').val();
    $.post('/consumer/boy_scouts/send_permission_form_to_troop_leader', {id:id});
    return false;
  });

//  $(".boy_scout_activity_consent_form_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd");
  $('#boy_scouts_activity_consent_form_bacf_birthdate').datepicker("setDate", $('#boy_scouts_activity_consent_form_bacf_birthdate').attr('data-value'));

  $('.boy_scout_activity_consent_form_restrictions').change(function () {
    if($('.boy_scout_activity_consent_form_restrictions:checked').val() == "without_restrictions") {
      $('#boy_scouts_activity_consent_form_bacf_spcl_considerations_for_restriction').val('');
      $('#boy_scouts_activity_consent_form_bacf_spcl_considerations_for_restriction').attr('readonly', true);
    }else{
      $('#boy_scouts_activity_consent_form_bacf_spcl_considerations_for_restriction').attr('readonly', false);
    }
  });

  $('#parent_permission_tab').click(function() {
    if($('.boy_scout_activity_consent_form_restrictions:checked').val() == "without_restrictions") {
      $('#boy_scouts_activity_consent_form_bacf_spcl_considerations_for_restriction').val('');
      $('#boy_scouts_activity_consent_form_bacf_spcl_considerations_for_restriction').attr('readonly', true);
    }else{
      $('#boy_scouts_activity_consent_form_bacf_spcl_considerations_for_restriction').attr('readonly', false);
    }
  });

  $(".boy_scout_activity_consent_form_date_selector").datepicker({
    changeMonth:true,
    changeYear:true,
    dateFormat:'yy-mm-dd',
    yearRange: '1940:' + new Date().getFullYear()
  });



  $('#boy_scouts_activity_consent_form_bacf_address_zip, #boy_scouts_activity_consent_form_bacf_parent_phone_1,' +
    '#boy_scouts_activity_consent_form_bacf_parent_phone_2, #boy_scouts_activity_consent_form_bacf_parent_phone_3').autotab_filter('numeric');

//  $('#boy_scouts_activity_consent_form_bacf_address_zip, #boy_scouts_activity_consent_form_bacf_parent_first_name').autotab_magic();

  $('#boy_scouts_activity_consent_form_bacf_parent_phone_1, #boy_scouts_activity_consent_form_bacf_parent_phone_2,' +
    '#boy_scouts_activity_consent_form_bacf_parent_phone_3').autotab_magic();
});
