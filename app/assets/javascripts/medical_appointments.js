$(function () {

  $(window).load(function(){
    if(params['appointment_date'] == undefined && params['action'] == 'index'){
      var date = new Date();
      var year = date.getFullYear();
      var month = (date.getMonth() + 1);
      var today_date = date.getDate();
      if (month <= 9){
        month = '0' + month
      }
      window.location = '/medical_appointments?appointment_date='+ year + '-' + month + '-' + today_date
    }
  });

  if ($('div[data-page-controller=medical_appointments][data-page-action=edit]').size()) {
    var date_time = appointment["appointment_date_time"];
    var date = date_time.split('T')[0];
    var time_split = date_time.split('T')[1];
    var time_h = time_split.split(':')[0];
    var time_m = time_split.split(':')[1];
    var app_date_time = date + ' ' + time_h + ':' + time_m + ' ';
    $(window).load(function () {
      $("#medical_appointment_appointment_date_time").datetimepicker().datetimepicker("option", "dateFormat", "yy-mm-dd").datetimepicker('setDate', app_date_time);
    });
  }

  $(".appointments_date_selector").datepicker({
    changeMonth: true,
    changeYear: true,
    yearRange:'1940:' + new Date().getFullYear(),
    onSelect:function (dateText, inst) {
      window.location = '/medical_appointments' + '?appointment_date=' + dateText;
    }
  }).datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : new Date());

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

});
