$(function () {

  if (params['appointment_id'] != undefined) {
    $('#appointment_email').val(old_appointment['email']);
    $('#appointment_firstname').val(old_appointment['firstname']);
    $('#appointment_lastname').val(old_appointment['lastname']);
    $('#appointment_responsible_party').val(old_appointment['responsible_party']);
    $('[name="appointment[location]"][value="' + old_appointment['location'] + '"]').attr('checked', 'checked');



    /*if($('.appointment_forms').val(old_appointment.formname.split(' ')[0]) == 'Child'){
$('.child').attr('checked','checked')
    }else{
      $('.adult').attr('checked','checked')
    } */
    /* form checked in next appt
     for(id in ids){
     $('[name="form_ids[]"][value="'+ids[id]+'"]').attr('checked', 'checked');
     }*/
  } else {
    if(appointment.formname.search(/Child/) == 0) {
      $('#radio_buttons_child').attr('checked', 'checked');
    }else if(appointment.formname.search(/Adult/) == 0) {
      $('#radio_buttons_adult').attr('checked', 'checked');
    }else if(appointment.formname.search(/Karen/) == 0) {
      $('#radio_buttons_new_patient').attr('checked', 'checked');
    }else{
      $('#radio_buttons_none').attr('checked', 'checked');
    }
  }

  $(window).load(function () {
    if (params.appointment != undefined) {
      $('#appointment_date').datepicker('setDate', params.appointment["date"]);
    }
  });

  if (params.form_ids != undefined) {
    ids = params.form_ids
    $(ids).each(function (k, v) {
      $('.new_appointment input[value=' + v + ' ]').attr('checked', true);
    });
  }


  if ($('div[data-page-controller=appointments][data-page-action=edit]').size()) {
    $(".appointments_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', appointment["date"]);
  } else {
    $(".appointments_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : new Date());
  }


});