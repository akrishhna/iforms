$(function () {
  $(".appointments_date_selector").datepicker({
    changeMonth: true,
    changeYear: true
  }).datepicker({
    onSelect:function (dateText, inst) {
      window.location = '/doctor/appointments' + '?appointment_date=' + dateText;
    }
  }).datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : new Date());

});
