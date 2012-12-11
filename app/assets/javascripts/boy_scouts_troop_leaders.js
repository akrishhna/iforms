$(function () {
  $('#add_boy_scout').click(function () {
    var row_count = $('#boy_scouts_table tr.boy_scout_row').size();
    $.get("/boy_scouts_troop_leaders/get_boy_scouts_row",
      {row_count:row_count},
      function (data) {
      });
    return false;
  });

  $('.boy_scout_name, .boy_scout_parent_name, .boy_scout_email').live('blur', function () {
    var row_index = $(this).parents('tr').attr('data_row_number');
    var id = $('#id_' + row_index).val();
    var boy_scout_first_name = $('#first_name_' + row_index).val();
    var boy_scout_last_name = $('#last_name_' + row_index).val();
    var boy_scout_middle_name = $('#middle_name_' + row_index).val();
    var boy_scout_parent_first_name = $('#parent_first_name_' + row_index).val();
    var boy_scout_parent_last_name = $('#parent_last_name_' + row_index).val();
    var boy_scout_email = $('#email_' + row_index).val();
    $.post("/boy_scouts_troop_leaders/boy_scouts_roster",
      {row_index:row_index, id:id, first_name:boy_scout_first_name, last_name:boy_scout_last_name,middle_name:boy_scout_middle_name, parent_first_name:boy_scout_parent_first_name, parent_last_name:boy_scout_parent_last_name, email:boy_scout_email});
  });

  $('.select_all_check_box').click(function () {
    if ($(this).is(':checked')) {
      $("#boy_scouts_table  input[name=check_box_row]").attr('checked', true);
    }
    else {
      $("#boy_scouts_table  input[name=check_box_row]").attr('checked', false);
    }
    enable_delete_all_bs_btn();
  });

  $('#boy_scouts_table  input[name=check_box_row]').live('change',function () {
    enable_delete_all_bs_btn();
  });

  $('.delete_boy_scouts').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }
    $('.delete_boy_scouts').fancybox({
      closeBtn:false
    });
  });

  $('#delete_yes').click(function () {
    var checked_vals = $('#boy_scouts_table input[name=check_box_row]:checked').map(function () {
      return $(this).val();
    }).get();

    if (checked_vals.length != 0) {
      $.post("/boy_scouts_troop_leaders/delete_boy_scouts", {checked_vals:checked_vals.join()});
    }
    else {
      $.fancybox({href:'#alert_box_error', closeBtn:false});
    }
    return false;
  });

  function enable_delete_all_bs_btn() {
    var checkbox_count = $('#boy_scouts_table  input[name=check_box_row]').length;
    var checked_checkbox_count = $('#boy_scouts_table  input[name=check_box_row]:checked').length;
    if (checkbox_count == checked_checkbox_count) {
      $('.select_all_check_box').attr('checked', true)
    }
    else {
      $('.select_all_check_box').attr('checked', false)
    }
    if (checked_checkbox_count > 0) {
      $('.delete_boy_scouts').attr('disabled', false);
    }
    else {
      $('.delete_boy_scouts').attr('disabled', "disabled");
    }
  }

// activity tabs

$(".boy_scout_activity_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd");
$('#boy_scouts_activity_activity_date_begin').datepicker("setDate", $('#boy_scouts_activity_activity_date_begin').attr('data-value'));
$('#boy_scouts_activity_activity_date_end').datepicker("setDate", $('#boy_scouts_activity_activity_date_end').attr('data-value'));
$('#boy_scouts_activity_activity_signed_permission_due_date').datepicker("setDate", $('#boy_scouts_activity_activity_signed_permission_due_date').attr('data-value'));



$('.activity_nav_link').click(function () {
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#activity_tab_links a:eq(" + tab_index + ")").tab('show');
  return false;
});

$('select#boy_scouts_activities').change(function () {
  if ($(this).val() == 0) {
  } else {
    window.location = '/boy_scouts_troop_leaders/activities?id=' + $(this).val();
  }
});

$('.create_new_activity').click(function(){
  window.location = '/boy_scouts_troop_leaders/activities?id=' + 'new';
});

$('.boy_scouts_activity_form input,.boy_scouts_activity_form select').change(function () {
  $('input[name=_method]').val('post');
  var params = $('.boy_scouts_activity_form').serializeArray();
  $.post('/boy_scouts_troop_leaders/create_activity', params);
  return false;
});

$('#notification_email_to_parent').click(function () {
  if ($(this).attr('disabled') == "disabled") {
    return false;
  }
  $(this).attr('disabled', "disabled");
  $(this).text('Sending Email...');
  var id = $('.boy_scouts_activity_form #boy_scouts_activity_id').val();
  $.post('/boy_scouts_troop_leaders/send_notification_email', {id:id});
  return false;
});

$('.delete_activity').click(function () {
  var id = $('.boy_scouts_activity_form #boy_scouts_activity_id').val();
  if (id != '') {
    var activity_name =  $('#boy_scouts_activities option:selected').text();
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
  var id = $('.boy_scouts_activity_form #boy_scouts_activity_id').val();
  $.post('/boy_scouts_troop_leaders/delete_activity', {id:id});
  return false;
});

$('#boy_scouts_activities option:first').hide();

$('#boy_scouts_activity_leader_phone_1, #boy_scouts_activity_leader_phone_2, #boy_scouts_activity_leader_phone_3').autotab_filter('numeric');

$('#boy_scouts_activity_leader_phone_1, #boy_scouts_activity_leader_phone_2, #boy_scouts_activity_leader_phone_3').autotab_magic();
  
  
  // Permission Forms Tab

  $('.pf_select_all_check_box').click(function () {
    if ($(this).is(':checked')) {
      $("#boy_scouts_permission_form_table  input[name=check_box_row]").attr('checked', true);
    }
    else {
      $("#boy_scouts_permission_form_table  input[name=check_box_row]").attr('checked', false);
    }
    enable_pf_btns()
  });

  $('#boy_scouts_permission_form_table  input[name=check_box_row]').change(function () {
    enable_pf_btns();
  });

  function enable_pf_btns() {
    var checkbox_count = $('#boy_scouts_permission_form_table  input[name=check_box_row]').length;
    var checked_checkbox_count = $('#boy_scouts_permission_form_table  input[name=check_box_row]:checked').length;
    var checked_checkbox_status =false;
    $('#boy_scouts_permission_form_table  input[name=check_box_row]:checked').each(function(){
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

  $('select#boy_scout_permission_form').change(function () {
    if ($(this).val() == 0) {
      // window.location.reload();
      // window.location = '/boy_scouts_troop_leaders/activities?id=' + 'new';
    } else {
      window.location = '/boy_scouts_troop_leaders/permission_forms?id=' + $(this).val();
    }
  });

  $('#permission_form_send_email_btn').click(function () {
    activity_id = $('select#boy_scout_permission_form').val();
    $(this).attr('disabled', "disabled");
    $(this).text('Sending Email...');
    $.post("/boy_scouts_troop_leaders/resend_permission_form", {activity_id:activity_id});
    return false;
  });

  $('#permission_form_print_forms_btn').click(function () {
    if ($(this).attr('disabled') == "disabled") {
      return false;
    }

    var checked_vals = $('#boy_scouts_permission_form_table input[name=check_box_row]:checked').map(function () {
      return $(this).attr('data-id');
    }).get();

    var activity_id = $(this).attr('data-activity-id');

    if (checked_vals.length != 0) {
      $.get("/boy_scouts_troop_leaders/pdf_merging",
        {activity_id:activity_id, checked_vals:checked_vals.join()}
      ).success(function () {
          window.open("/boy_scouts_troop_leaders/show_all_permission_forms_pdf?activity_id=" + activity_id);
        });
    }
  });




  //permission forms
  if($('.page').attr('data-page') == 'boy_scouts_troop_leaders_permission_forms') {
    $('#boy_scout_permission_form option:first').hide();
    if(params["id"] == undefined && $('#selected_activity_id') == "") {
      $('#boy_scout_permission_form').val('');
    }
  }
});
