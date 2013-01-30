$(function () {

  $(window).load(function(){
    if(params['appointment_date'] == undefined){
      var date = new Date();
      var year = date.getFullYear();
      var month = (date.getMonth() + 1);
      var today_date = date.getDate();
      if (month <= 9){
        month = '0' + month
      }
      window.location = '/doctor/appointments?appointment_date='+ year + '-' + month + '-' + today_date
    }
  });

  $(".appointments_date_selector").datepicker({
    changeMonth: true,
    changeYear: true,
    onSelect:function (dateText, inst) {
      window.location = '/doctor/appointments' + '?appointment_date=' + dateText;
    }
  }).datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : new Date());

});


