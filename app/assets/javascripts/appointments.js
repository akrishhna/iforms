$(function(){

  if(params['appointment_id'] != undefined) {
    $('#appointment_email').val(old_appointment['email']) ;
    $('#appointment_firstname').val(old_appointment['firstname']);
    $('#appointment_lastname').val(old_appointment['lastname']);
    $('#responsible_party').val(old_appointment['responsible_party']);
    $('[name="appointment[location]"][value="'+old_appointment['location']+'"]').attr('checked', 'checked');
   /* form checked in next appt
   for(id in ids){
      $('[name="form_ids[]"][value="'+ids[id]+'"]').attr('checked', 'checked');
    }*/
  }

    $(".appointments_date_selector").datepicker().datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : new Date());

});