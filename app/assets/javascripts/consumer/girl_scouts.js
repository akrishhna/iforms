// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function () {

  $('.girl_scout_permission_form input, textarea').change(function () {
    $('input[name=_method]').val('post');
    var params = $('.girl_scout_permission_form').serializeArray();
    $.post('/consumer/girl_scouts/girl_scouts_permission_form', params);
    return false;
  });

  $('#notification_email_to_troop_leader').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }
    $(this).attr('disabled', "disabled");
    $(this).text('Sending Email Notification to Troop Leader...');
    var id = $('.girl_scout_permission_form #girl_scouts_activity_permission_form_id').val();
    $.post('/consumer/girl_scouts/send_permission_form_to_troop_leader', {id:id});
    return false;
  });

  $('.arizona_special_needs').change(function () {
    if ($('.arizona_special_needs:checked').val() == 'Yes') {
      $('#girl_scouts_activity_permission_form_gapf_special_needs').show()
    } else {
      $('#girl_scouts_activity_permission_form_gapf_special_needs').hide()
    }
  });

  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_1_1, #girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_1_2,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_1_3, #girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_2_1,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_2_2, #girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_2_3,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_1_1, #girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_1_2,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_1_3, #girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_2_1,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_2_2, #girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_2_3,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_1_1, #girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_1_2,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_1_3, #girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_2_1,' +
    '#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_2_2, #girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_2_3,' +
    '#girl_scouts_activity_permission_form_gapf_physician_phone_1, #girl_scouts_activity_permission_form_gapf_physician_phone_2,' +
    '#girl_scouts_activity_permission_form_gapf_physician_phone_3, #girl_scouts_activity_permission_form_parent_phone_number_during_activity_1,' +
    '#girl_scouts_activity_permission_form_parent_phone_number_during_activity_2, #girl_scouts_activity_permission_form_parent_phone_number_during_activity_3,' +
    '#girl_scouts_activity_permission_form_emergency_contact_phone_number_1, #girl_scouts_activity_permission_form_emergency_contact_phone_number_2,' +
    '#girl_scouts_activity_permission_form_emergency_contact_phone_number_3, #girl_scouts_activity_permission_form_emergency_contact_cell_number_1,' +
    '#girl_scouts_activity_permission_form_emergency_contact_cell_number_2, #girl_scouts_activity_permission_form_emergency_contact_cell_number_3,' +
    '#girl_scouts_activity_permission_form_emergency_contact_address_zip, #girl_scouts_activity_permission_form_act_in_my_behalf_address_zip, ' +
    '#gapf_activity_my_behalf_phone_1, #gapf_activity_my_behalf_phone_2, #gapf_activity_my_behalf_phone_3, #girl_scouts_activity_permission_form_gapf_parent_home_phone_1,' +
    '#girl_scouts_activity_permission_form_gapf_parent_home_phone_2, #girl_scouts_activity_permission_form_gapf_parent_home_phone_3, #girl_scouts_activity_permission_form_gapf_parent_cell_phone_1,' +
    '#girl_scouts_activity_permission_form_gapf_parent_cell_phone_2,#girl_scouts_activity_permission_form_gapf_parent_cell_phone_3, #girl_scouts_activity_permission_form_gapf_parent_other_phone_1,' +
    '#girl_scouts_activity_permission_form_gapf_parent_other_phone_2, #girl_scouts_activity_permission_form_gapf_parent_other_phone_3, #girl_scouts_activity_permission_form_gapf_parent_1_address_zip,' +
    '#girl_scouts_activity_permission_form_gapf_parent_1_home_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_home_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_home_phone_3,' +
    '#girl_scouts_activity_permission_form_gapf_parent_1_work_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_work_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_work_phone_3,' +
    '#girl_scouts_activity_permission_form_gapf_parent_1_mobile_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_mobile_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_mobile_phone_3,' +
    '#girl_scouts_activity_permission_form_gapf_parent_1_other_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_other_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_other_phone_3,' +
    '#girl_scouts_activity_permission_form_gapf_parent_2_address_zip, #girl_scouts_activity_permission_form_gapf_parent_2_home_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_home_phone_2,' +
    '#girl_scouts_activity_permission_form_gapf_parent_2_home_phone_3,#girl_scouts_activity_permission_form_gapf_parent_2_work_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_work_phone_2,' +
    '#girl_scouts_activity_permission_form_gapf_parent_2_work_phone_3,#girl_scouts_activity_permission_form_gapf_parent_2_mobile_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_mobile_phone_2,' +
    '#girl_scouts_activity_permission_form_gapf_parent_2_mobile_phone_3, #girl_scouts_activity_permission_form_gapf_parent_2_other_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_other_phone_2,' +
    '#girl_scouts_activity_permission_form_gapf_parent_2_other_phone_3, #girl_scouts_activity_permission_form_gapf_activity_my_behalf_phone_1, #girl_scouts_activity_permission_form_gapf_activity_my_behalf_phone_2,' +
    '#girl_scouts_activity_permission_form_gapf_activity_my_behalf_phone_3').autotab_filter('numeric');


  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_1_1, #girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_1_2,#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_1_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_2_1,#girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_2_2, #girl_scouts_activity_permission_form_gapf_emergency_contact_1_phone_2_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_1_1, #girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_1_2,#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_1_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_2_1,#girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_2_2, #girl_scouts_activity_permission_form_gapf_emergency_contact_2_phone_2_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_1_1, #girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_1_2,#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_1_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_2_1,#girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_2_2, #girl_scouts_activity_permission_form_gapf_emergency_contact_3_phone_2_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_physician_phone_1, #girl_scouts_activity_permission_form_gapf_physician_phone_2, #girl_scouts_activity_permission_form_gapf_physician_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_parent_phone_number_during_activity_1, #girl_scouts_activity_permission_form_parent_phone_number_during_activity_2, #girl_scouts_activity_permission_form_parent_phone_number_during_activity_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_emergency_contact_phone_number_1, #girl_scouts_activity_permission_form_emergency_contact_phone_number_2,#girl_scouts_activity_permission_form_emergency_contact_phone_number_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_emergency_contact_cell_number_1,#girl_scouts_activity_permission_form_emergency_contact_cell_number_2, #girl_scouts_activity_permission_form_emergency_contact_cell_number_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_home_phone_1, #girl_scouts_activity_permission_form_gapf_parent_home_phone_2, #girl_scouts_activity_permission_form_gapf_parent_home_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_cell_phone_1, #girl_scouts_activity_permission_form_gapf_parent_cell_phone_2, #girl_scouts_activity_permission_form_gapf_parent_cell_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_other_phone_1, #girl_scouts_activity_permission_form_gapf_parent_other_phone_2, #girl_scouts_activity_permission_form_gapf_parent_other_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_1_home_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_home_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_home_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_1_work_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_work_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_work_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_1_mobile_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_mobile_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_mobile_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_1_other_phone_1, #girl_scouts_activity_permission_form_gapf_parent_1_other_phone_2, #girl_scouts_activity_permission_form_gapf_parent_1_other_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_2_home_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_home_phone_2, #girl_scouts_activity_permission_form_gapf_parent_2_home_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_2_work_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_work_phone_2, #girl_scouts_activity_permission_form_gapf_parent_2_work_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_2_mobile_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_mobile_phone_2, #girl_scouts_activity_permission_form_gapf_parent_2_mobile_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_parent_2_other_phone_1, #girl_scouts_activity_permission_form_gapf_parent_2_other_phone_2, #girl_scouts_activity_permission_form_gapf_parent_2_other_phone_3').autotab_magic();

  $('#girl_scouts_activity_permission_form_gapf_activity_my_behalf_phone_1, #girl_scouts_activity_permission_form_gapf_activity_my_behalf_phone_2, #girl_scouts_activity_permission_form_gapf_activity_my_behalf_phone_3').autotab_magic();
});