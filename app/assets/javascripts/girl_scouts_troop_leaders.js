// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require jquery.format.1.05
//= require jquery.currency

$(function () {
  $('#add_girl_scout').click(function () {
    var row_count = $('#girl_scouts_table tr.girl_scout_row').size();
    $.get("/girl_scouts_troop_leaders/get_girl_scouts_row",
      {row_count:row_count},
      function (data) {
      });
    return false;
  });

  $('.girl_scout_name, .girl_scout_parent_name, .girl_scout_email').live('blur', function () {
    var row_index = $(this).parents('tr').attr('data_row_number');
    var id = $('#id_' + row_index).val();
    var girl_scout_first_name = $('#first_name_' + row_index).val();
    var girl_scout_last_name = $('#last_name_' + row_index).val();
    var girl_scout_parent_first_name = $('#parent_first_name_' + row_index).val();
    var girl_scout_parent_last_name = $('#parent_last_name_' + row_index).val();
    var girl_scout_email = $('#email_' + row_index).val();
    $.post("/girl_scouts_troop_leaders/girl_scouts_roster",
      {row_index:row_index, id:id, first_name:girl_scout_first_name, last_name:girl_scout_last_name, parent_first_name:girl_scout_parent_first_name, parent_last_name:girl_scout_parent_last_name, email:girl_scout_email});
  });

  $('.select_all_check_box').click(function () {
    if ($(this).is(':checked')) {
      $("#girl_scouts_table  input[name=check_box_row]").attr('checked', true);
    }
    else {
      $("#girl_scouts_table  input[name=check_box_row]").attr('checked', false);
    }
    enable_delete_all_gs_btn();
  });

  $('#girl_scouts_table  input[name=check_box_row]').live('change', function () {
    enable_delete_all_gs_btn();
  });

  $('.delete_girls_scouts').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }
    $('.delete_girls_scouts').fancybox({
      closeBtn:false
    });
  });

  $('#delete_yes').click(function () {
    var checked_vals = $('#girl_scouts_table input[name=check_box_row]:checked').map(function () {
      return $(this).val();
    }).get();

    if (checked_vals.length != 0) {
      $.post("/girl_scouts_troop_leaders/delete_girl_scouts", {checked_vals:checked_vals.join()});
    }
    else {
      $.fancybox({href:'#alert_box_error', closeBtn:false});
    }
    return false;
  });

  function enable_delete_all_gs_btn() {
    var checkbox_count = $('#girl_scouts_table  input[name=check_box_row]').length;
    var checked_checkbox_count = $('#girl_scouts_table  input[name=check_box_row]:checked').length;
    if (checkbox_count == checked_checkbox_count) {
      $('.select_all_check_box').attr('checked', true)
    }
    else {
      $('.select_all_check_box').attr('checked', false)
    }
    if (checked_checkbox_count > 0) {
      $('.delete_girls_scouts').attr('disabled', false);
    }
    else {
      $('.delete_girls_scouts').attr('disabled', "disabled");
    }
  }


  // activity tabs

  $(".girls_scout_activity_date_selector").datepicker({
    changeMonth: true,
    changeYear: true
  }).datepicker("option", "dateFormat", "yy-mm-dd");
  $('#girl_scouts_activity_activity_date_begin').datepicker("setDate", $('#girl_scouts_activity_activity_date_begin').attr('data-value'));
  $('#girl_scouts_activity_activity_date_end').datepicker("setDate", $('#girl_scouts_activity_activity_date_end').attr('data-value'));
  $('#girl_scouts_activity_activity_signed_permission_due_date').datepicker("setDate", $('#girl_scouts_activity_activity_signed_permission_due_date').attr('data-value'));


  $('.activity_nav_link').click(function () {
    var tab_index = parseInt($(this).attr('data_tab_index'));
    $("#activity_tab_links a:eq(" + tab_index + ")").tab('show');
    return false;
  });

  $('select#girls_scouts_activities').change(function () {
    if ($(this).val() == 0) {
      //window.location.reload();
     // window.location = '/girl_scouts_troop_leaders/activities?id=' + 'new';
    } else {
      window.location = '/girl_scouts_troop_leaders/activities?id=' + $(this).val();
    }
  });

  $('.create_new_activity').click(function(){
    window.location = '/girl_scouts_troop_leaders/activities?id=' + 'new';
  });

  $('.girl_scouts_activity_form input,.girl_scouts_activity_form select').change(function () {
    $('input[name=_method]').val('post');
    var params = $('.girl_scouts_activity_form').serializeArray();
    $.post('/girl_scouts_troop_leaders/create_activity', params).success(function () {
      $('#activity_cost_dollars').currency({
        decimals:0,
        hidePrefix:true
      });
    });
    return false;
  });

  $('#notification_email_to_parent').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }
    $(this).attr('disabled', "disabled");
    $(this).text('Sending Email...');
    var id = $('.girl_scouts_activity_form #girl_scouts_activity_id').val();
    $.post('/girl_scouts_troop_leaders/send_notification_email', {id:id});
    return false;
  });

  $('.delete_activity').click(function () {
    var id = $('.girl_scouts_activity_form #girl_scouts_activity_id').val();
    if (id != '') {
      var activity_name =  $('#girls_scouts_activities option:selected').text();
      $.fancybox({
        href:'#delete_activity_alert_box',
        closeBtn:false,
        beforeShow: function(){
          $('#delete_activity_name').text(activity_name);
        }
      });
    }
    return false;
  });

  $('#delete_activity_yes').click(function () {
    var id = $('.girl_scouts_activity_form #girl_scouts_activity_id').val();
    $.post('/girl_scouts_troop_leaders/delete_activity', {id:id});
    return false;
  });

  $('#activity_cost_dollars').format({type:'decimal', precision:0, allow_negative:false, autofix:true});
  var activity_cost_dollars
  $('#activity_cost_dollars').keyup(function (e) {
    $('#hidden_activity_cost_dollars').val($(this).val());
    if ($(this).val().length <= 5 && $(this).val() <= 99999) {
      activity_cost_dollars = $(this).val();
    } else {
      if (e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 13 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 46) {
        return true;
      } else {
        $(this).val(activity_cost_dollars);
      }
    }
  });

  $('#activity_cost_dollars').currency({
    decimals:0,
    hidePrefix:true
  });
  var activity_cost_cents;
  $('#activity_cost_cents').keyup(function (e) {

    if ($(this).val().length <= 2 && $(this).val() <= 99) {
      if (e.keyCode >= 48 && e.keyCode <= 57) {
        activity_cost_cents = $(this).val();
      }
    } else {
      if (e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 13 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 46) {
        return true;
      } else {
        $(this).val(activity_cost_cents)
      }
    }
  });

  $('#activity_cost_cents').blur(function () {
    if ($(this).val().length < 2) {
      var hh = $(this).val();
      $(this).val('0' + hh);
    }
  });

  $('#girls_scouts_activities option:first').hide();

  $('#girl_scouts_activity_activity_location_phone_1, #girl_scouts_activity_activity_location_phone_2, #girl_scouts_activity_activity_location_phone_3,' +
    '#girl_scouts_activity_troop_leader_phone_1, #girl_scouts_activity_troop_leader_phone_2, #girl_scouts_activity_troop_leader_phone_3,' +
    '#girl_scouts_activity_leader_day_phone_1, #girl_scouts_activity_leader_day_phone_2, #girl_scouts_activity_leader_day_phone_3,' +
    '#girl_scouts_activity_leader_evening_phone_1, #girl_scouts_activity_leader_evening_phone_2, #girl_scouts_activity_leader_evening_phone_3,' +
    '#girl_scouts_activity_leader_cell_phone_1, #girl_scouts_activity_leader_cell_phone_2, #girl_scouts_activity_leader_cell_phone_3,' +
    '#girl_scouts_activity_emergency_day_phone_1, #girl_scouts_activity_emergency_day_phone_2, #girl_scouts_activity_emergency_day_phone_3,' +
    '#girl_scouts_activity_emergency_evening_phone_1, #girl_scouts_activity_emergency_evening_phone_2, #girl_scouts_activity_emergency_evening_phone_3,' +
    '#girl_scouts_activity_leader_advisor_1_phone_1, #girl_scouts_activity_leader_advisor_1_phone_2, #girl_scouts_activity_leader_advisor_1_phone_3,' +
    '#girl_scouts_activity_leader_advisor_1_cell_1, #girl_scouts_activity_leader_advisor_1_cell_2, #girl_scouts_activity_leader_advisor_1_cell_3,' +
    '#girl_scouts_activity_leader_advisor_2_phone_1, #girl_scouts_activity_leader_advisor_2_phone_2, #girl_scouts_activity_leader_advisor_2_phone_3,' +
    '#girl_scouts_activity_leader_advisor_2_cell_1, #girl_scouts_activity_leader_advisor_2_cell_2, #girl_scouts_activity_leader_advisor_2_cell_3,' +
    '#girl_scouts_activity_troop_leader_emergency_contact_phone_number_1, #girl_scouts_activity_troop_leader_emergency_contact_phone_number_2, ' +
    '#girl_scouts_activity_troop_leader_emergency_contact_phone_number_3, #girl_scouts_activity_troop_leader_emergency_contact_cell_number_1,' +
    '#girl_scouts_activity_troop_leader_emergency_contact_cell_number_2, #girl_scouts_activity_troop_leader_emergency_contact_cell_number_3').autotab_filter('numeric');


  $('#girl_scouts_activity_activity_location_phone_1, #girl_scouts_activity_activity_location_phone_2, #girl_scouts_activity_activity_location_phone_3').autotab_magic();

  $('#girl_scouts_activity_troop_leader_phone_1, #girl_scouts_activity_troop_leader_phone_2, #girl_scouts_activity_troop_leader_phone_3').autotab_magic();

  $('#girl_scouts_activity_leader_day_phone_1, #girl_scouts_activity_leader_day_phone_2, #girl_scouts_activity_leader_day_phone_3,' +
    '#girl_scouts_activity_leader_evening_phone_1, #girl_scouts_activity_leader_evening_phone_2, #girl_scouts_activity_leader_evening_phone_3,' +
    '#girl_scouts_activity_leader_cell_phone_1, #girl_scouts_activity_leader_cell_phone_2, #girl_scouts_activity_leader_cell_phone_3').autotab_magic();

  $('#girl_scouts_activity_emergency_day_phone_1, #girl_scouts_activity_emergency_day_phone_2, #girl_scouts_activity_emergency_day_phone_3,' +
    '#girl_scouts_activity_emergency_evening_phone_1, #girl_scouts_activity_emergency_evening_phone_2, #girl_scouts_activity_emergency_evening_phone_3').autotab_magic();

  $('#girl_scouts_activity_leader_advisor_1_phone_1, #girl_scouts_activity_leader_advisor_1_phone_2, #girl_scouts_activity_leader_advisor_1_phone_3,' +
    '#girl_scouts_activity_leader_advisor_1_cell_1, #girl_scouts_activity_leader_advisor_1_cell_2, #girl_scouts_activity_leader_advisor_1_cell_3').autotab_magic();

  $('#girl_scouts_activity_leader_advisor_2_phone_1, #girl_scouts_activity_leader_advisor_2_phone_2, #girl_scouts_activity_leader_advisor_2_phone_3,' +
    '#girl_scouts_activity_leader_advisor_2_cell_1, #girl_scouts_activity_leader_advisor_2_cell_2, #girl_scouts_activity_leader_advisor_2_cell_3').autotab_magic();

  $('#girl_scouts_activity_troop_leader_emergency_contact_phone_number_1, #girl_scouts_activity_troop_leader_emergency_contact_phone_number_2, #girl_scouts_activity_troop_leader_emergency_contact_phone_number_3,' +
    '#girl_scouts_activity_troop_leader_emergency_contact_cell_number_1, #girl_scouts_activity_troop_leader_emergency_contact_cell_number_2, #girl_scouts_activity_troop_leader_emergency_contact_cell_number_3').autotab_magic();

  // Permission Forms Tab

  $('.pf_select_all_check_box').click(function () {
    if ($(this).is(':checked')) {
      $("#girl_scouts_permission_form_table  input[name=check_box_row]").attr('checked', true);
    }
    else {
      $("#girl_scouts_permission_form_table  input[name=check_box_row]").attr('checked', false);
    }
    enable_pf_btns()
  });

  $('#girl_scouts_permission_form_table  input[name=check_box_row]').change(function () {
    enable_pf_btns();
  });

  function enable_pf_btns() {
    var checkbox_count = $('#girl_scouts_permission_form_table  input[name=check_box_row]').length;
    var checked_checkbox_count = $('#girl_scouts_permission_form_table  input[name=check_box_row]:checked').length;
    var checked_checkbox_status =false;
      $('#girl_scouts_permission_form_table  input[name=check_box_row]:checked').each(function(){
      if($(this).attr('data-status') == 'Submitted' || $(this).attr('data-status') == 'Updated'){
       checked_checkbox_status = true;
      }
    });
    if (checkbox_count == checked_checkbox_count) {
      $('.pf_select_all_check_box').attr('checked', true)
    }
    else {
      $('.pf_select_all_check_box').attr('checked', false)
    }
    if (checked_checkbox_count > 0 && checked_checkbox_status) {
      $('#permission_form_print_forms_btn').attr('disabled', false);
    }
    else {
      $('#permission_form_print_forms_btn').attr('disabled', "disabled");
    }
  }

  $('select#girls_scout_permission_form').change(function () {
    if ($(this).val() == 0) {
     // window.location.reload();
     // window.location = '/girl_scouts_troop_leaders/activities?id=' + 'new';
    } else {
      window.location = '/girl_scouts_troop_leaders/permission_forms?id=' + $(this).val();
    }
  });

  $('#permission_form_send_email_btn').click(function () {
    activity_id = $('select#girls_scout_permission_form').val();
    $(this).attr('disabled', "disabled");
    $(this).text('Sending Email...');
    $.post("/girl_scouts_troop_leaders/resend_permission_form", {activity_id:activity_id});
    return false;
  });

  $('#permission_form_print_forms_btn').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }

    var checked_vals = $('#girl_scouts_permission_form_table input[name=check_box_row]:checked').map(function () {
      return $(this).attr('data-id');
    }).get();

    var activity_id = $(this).attr('data-activity-id');

    if (checked_vals.length != 0) {
      $.get("/girl_scouts_troop_leaders/pdf_merging",
        {activity_id:activity_id, checked_vals:checked_vals.join()}
      ).success(function () {
          window.open("/girl_scouts_troop_leaders/show_all_permission_forms_pdf?activity_id=" + activity_id);
        });
    }
  });




  //permission forms
  if($('.page').attr('data-page') == 'girl_scouts_troop_leaders_permission_forms') {
    $('#girls_scout_permission_form option:first').hide();
    if(params["id"] == undefined && $('#selected_activity_id') == "") {
      $('#girls_scout_permission_form').val('');
    }
  }
});
