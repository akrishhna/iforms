/* changing date format MM-DD-YYYY */

var month = parseInt(new Date().getMonth()) + 1;
var date_value = (month < 10 ? '0' + month : month) + '-' + new Date().getDate() + '-' + new Date().getFullYear();
var time_hours = (new Date().getHours() > 11) ? (new Date().getHours() - 12) : new Date().getHours();
var minutes = new Date().getMinutes();
var time_min = '';
var am_pm = (new Date().getHours() > 11) ? 'pm' : 'am';
var today_date = '';

if (minutes % 5 == 0) {
  time_min = minutes
}
else {
  minutes = parseInt(minutes / 5);
  time_min = (minutes * 5) + 5;
  if (minutes == 11 && am_pm == 'pm') {
    time_min = minutes;
  }
}

if (new Date().getHours() == '12') {
  time_hours = '12'
}

if (new Date().getHours() == '24') {
  time_hours = '00'
}

today_date = date_value + ' ' + time_hours + ':' + time_min + ' ' + am_pm;
/* End of date format MM-DD-YYYY */

$(function () {

  /* For next appointment*/

  if (params['appointment_id'] != undefined) {
    $('#appointment_email').val(old_appointment['email']);
    $('#appointment_firstname').val(old_appointment['firstname']);
    $('#appointment_lastname').val(old_appointment['lastname']);
    $('#appointment_responsible_party').val(old_appointment['responsible_party']);
    $('[name="appointment[location]"][value="' + old_appointment['location'] + '"]').attr('checked', 'checked');

  } else {
    if ($('.page').attr('data-page') != 'appointments_new') {
      if (appointment.formname.search(/Child/) == 0) {
        $('#radio_buttons_Child').attr('checked', 'checked');
      } else if (appointment.formname.search(/Adult/) == 0) {
        $('#radio_buttons_Adult').attr('checked', 'checked');
      } else if (appointment.formname.search(/New Patient/) == 0) {
        $('#radio_buttons_New_Patient').attr('checked', 'checked');
      }
      else if (appointment.formname.search(/Rising Stars/) == 0) {
        $('#radio_buttons_Rising_Stars_Pediatric').attr('checked', 'checked');
      } else {
        $('#radio_buttons_None').attr('checked', 'checked');
      }
    }
  }
  /* End of for next appointment*/

  /* not using */

  $(window).load(function () {
    if (params.appointment != undefined) {
      // $('#appointment_date').datepicker('setDate', change_date_format(params.appointment["date"]));
    }
  });

  if (params.form_ids != undefined) {
    ids = params.form_ids
    $(ids).each(function (k, v) {
      $('.new_appointment input[value=' + v + ' ]').attr('checked', true);
    });
  }
  /* End of not using */

  /* changing Date to original format before create appointment */

  $('.appointment_form_submit').live('click', function () {
    var selected_date = $('#display_appointment_date_time').val().split(' ');
    var date = set_default_date_format(selected_date[0]);
    var time = selected_date[1] + ' ' + selected_date[2];
    $('#appointment_appointment_date_time').val(date + ' ' + time);
  });
  /* End of changing Date to original format before create appointment */

  /* For resend appointment*/

  if ($('div[data-page-controller=appointments][data-page-action=edit]').size()) {
    var date_time = appointment["appointment_date_time"];
    var date = change_date_format(date_time.split('T')[0]);
    var time_split = date_time.split('T')[1];
    var time_h = time_split.split(':')[0];
    var time_m = time_split.split(':')[1];
    var app_date_time = date + ' ' + time_h + ':' + time_m + ' ';

    $(window).load(function () {
      //  $("#appointment_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "mm-dd-yy").datetimepicker('setDate', app_date_time);
      $("#display_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "mm-dd-yy").datetimepicker('setDate', app_date_time);
    });
  }
  else {
    $(window).load(function () {
      // $("#appointment_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "mm-dd-yy").datetimepicker('setDate', today_date);
      $("#display_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "mm-dd-yy").datetimepicker('setDate', today_date);
      //$(".appointments_date_selector").datepicker().datepicker("option", "dateFormat", "mm-dd-yy").datepicker('setDate', appointment_date != '' ? appointment_date : today_date);
    });
    // $(".appointments_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : new Date());
  }
  /* End of For resend appointment*/
});
