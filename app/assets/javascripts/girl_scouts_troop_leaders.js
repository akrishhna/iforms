// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
//You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//= require jquery.numeric
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

  $('#select_all_check_box').click(function () {
    if ($(this).is(':checked')) {
      $("#girl_scouts_table  input[name=check_box_row]").attr('checked', true);
    }
    else {
      $("#girl_scouts_table  input[name=check_box_row]").attr('checked', false);
    }
    enable_delete_all_gs_btn();
  });

  $('#girl_scouts_table  input[name=check_box_row]').change(function () {
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
      $('#select_all_check_box').attr('checked', true)
    }
    else {
      $('#select_all_check_box').attr('checked', false)
    }
    if (checked_checkbox_count > 0) {
      $('.delete_girls_scouts').attr('disabled', false);
    }
    else {
      $('.delete_girls_scouts').attr('disabled', "disabled");
    }
  }


  // activity tabs

  $(".girls_scout_activity_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd");

  $('.activity_nav_link').click(function () {
    var tab_index = parseInt($(this).attr('data_tab_index'));
    $("#activity_tab_links a:eq(" + tab_index + ")").tab('show');
    return false;
  });

  $('select#girls_scouts_activities').change(function () {
    if ($(this).val() == 0) {
      window.location = '/girl_scouts_troop_leaders/activities';
    } else {
      window.location = '/girl_scouts_troop_leaders/activities?id=' + $(this).val();
    }
  });

  $('.girl_scouts_activity_form input,.girl_scouts_activity_form select').change(function () {
    var params = {};
    params["girl_scouts_activity[id]"] = $('.girl_scouts_activity_form #girl_scouts_activity_id').val();
    params[$(this).attr('name')] = $(this).val();
    $.post('/girl_scouts_troop_leaders/create_activity', params);
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
      $.fancybox({
        href:'#delete_activity_alert_box',
        closeBtn:false
      });
    }
    return false;
  });

  $('#delete_activity_yes').click(function () {
    var id = $('.girl_scouts_activity_form #girl_scouts_activity_id').val();
    $.post('/girl_scouts_troop_leaders/delete_activity', {id:id});
    return false;
  });

  $('#activity_leave_time_hh,#activity_return_time_hh,#activity_leave_time_mm,#activity_return_time_mm,#activity_cost_cents').keyup(function (e) {
    var id = $(this).attr('id');
    var val = 0;
    if (id == "activity_leave_time_hh" || id == "activity_return_time_hh") {
      val = 12;
    } else if (id == "activity_leave_time_mm" || id == "activity_return_time_mm") {
      val = 59;
    } else if (id == "activity_cost_cents") {
      val = 99;
    } else {
      val = 0;
    }
    if ($(this).val().length <= 2 && $(this).val() <= val) {
      if (e.keyCode >= 48 && e.keyCode <= 57) {
      }
      else {
        $(this).val('')
      }
    }
    else {
      $(this).val('')
    }
  });

  $('#activity_leave_time_hh,#activity_return_time_hh,#activity_return_time_mm,#activity_leave_time_mm,#activity_cost_cents').blur(function () {
    if ($(this).val().length < 2) {
      var hh = $(this).val();
      $(this).val('0' + hh);
    }
  });

  $("#activity_cost_dollars").numeric({decimal:false, negative:false}, function () {
    this.value = "";
    this.focus();
  });

      $('#activity_cost_dollars').currency({
       decimals: 0,
       hidePrefix: true,
       thousands: ','
  });
});
