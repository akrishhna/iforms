$(function () {

  $(window).load(function () {
    if (params.appointment != undefined) {
      $('#appointment_date').datepicker('setDate', params.appointment["date"]);
    }
  });

  $(".appointments_date_selector").datepicker({
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
    if($('.page').attr('data-page') != 'medical_appointments_index' && $('.page').attr('data-page') != 'medical_appointments_new'){
     if(appointment.formname.search(/New_Medical/) == 0) {
      $('#radio_buttons_New_Medical_Patient').attr('checked', 'checked');
    }else{
      $('#radio_buttons_None').attr('checked', 'checked');
    }
    }else{}
  }


});
