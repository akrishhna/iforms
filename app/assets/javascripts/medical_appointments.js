/* changing date format MM-DD-YYYY */
var appointment_date = '';
var month = parseInt(new Date().getMonth()) + 1;
var date_value = (month < 10 ? '0' + month : month) + '-' + new Date().getDate() + '-' + new Date().getFullYear();
var time_hours = (new Date().getHours() > 11) ? (new Date().getHours() - 12) : new Date().getHours();
var minutes = new Date().getMinutes();
var time_min = '';// new Date().getMinutes();
var am_pm = (new Date().getHours() > 11) ? 'pm' : 'am';
var today_date = '';

if (minutes % 5 == 0) {
  time_min = minutes
} else {
  minutes = parseInt(minutes / 5);
  time_min = (minutes * 5) + 5;
  if (minutes != 11 && am_pm == 'pm') {
    time_min = minutes;//new Date().getMinutes();
  }
}

if (params['appointment_date'] != undefined) {
  appointment_date = change_date_format(params['appointment_date']);
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

  /* redirecting url with today date */

//  $(window).load(function () {
//    if (params['appointment_date'] == undefined && params['action'] == 'index') {
//      var date = new Date();
//      var year = date.getFullYear();
//      var month = (date.getMonth() + 1);
//      var today_date = date.getDate();
//      if (month <= 9) {
//        month = '0' + month
//      }
//      window.location = '/medical_appointments?appointment_date=' + year + '-' + month + '-' + today_date
//    }
//  });
  /* End of redirecting url with today date */

  /* changing Date to original format before create appointment */

  $('.appointment_form_submit').live('click', function () {
    var selected_date = $('#display_appointment_date_time').val().split(' ');
    var date = set_default_date_format(selected_date[0]);
    var time = selected_date[1] + ' ' + selected_date[2];
    $('#medical_appointment_appointment_date_time').val(date + ' ' + time);
  });

  /* End of changing Date to original format before create appointment */

  /* For resend appointment*/

  if ($('div[data-page-controller=medical_appointments][data-page-action=edit]').size()) {
    var date_time = appointment["appointment_date_time"];
    var date = change_date_format(date_time.split('T')[0]);
    var time_split = date_time.split('T')[1];
    var time_h = time_split.split(':')[0];
    var time_m = time_split.split(':')[1];
    var app_date_time = date + ' ' + time_h + ':' + time_m + ' ';
    $(window).load(function () {
      //$("#medical_appointment_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "mm-dd-yy").datetimepicker('setDate', app_date_time);
      $("#display_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "mm-dd-yy").datetimepicker('setDate', app_date_time);
    });
  }
  /* End of For resend appointment*/

  /* For next appointment*/

  if (params['appointment_id'] != undefined) {
    $('#medical_appointment_email').val(old_appointment['email']);
    $('#medical_appointment_firstname').val(old_appointment['firstname']);
    $('#medical_appointment_lastname').val(old_appointment['lastname']);
    $('#medical_appointment_responsible_party').val(old_appointment['responsible_party']);
    $('#medical_appointment_preferred_name').val(old_appointment['preferred_name']);
    $('[name="medical_appointment[location]"][value="' + old_appointment['location'] + '"]').attr('checked', 'checked');
  } else {
    if ($('.page').attr('data-page') != 'medical_appointments_index' && $('.page').attr('data-page') != 'medical_appointments_new') {
      if (appointment.formname.search(/New Patient/) == 0 || appointment.formname.search(/New_Medical/) == 0) {
        $('#radio_buttons_New_Medical_Patient').attr('checked', 'checked');
      } else {
        $('#radio_buttons_None').attr('checked', 'checked');
      }
    } else {
    }
  }
  /* End of for next appointment*/

  /* Date picker*/

  $(".appointments_date_selector").datepicker({
    changeMonth:true,
    changeYear:true,
    yearRange:'1940:' + new Date().getFullYear(),
    onSelect:function (dateText, inst) {
      window.location = '/medical_appointments' + '?appointment_date=' + set_default_date_format(dateText);
    }
  }).datepicker("option", "dateFormat", "mm-dd-yy").datepicker('setDate', appointment_date != '' ? appointment_date : today_date);

  /* End of Date picker*/
});
