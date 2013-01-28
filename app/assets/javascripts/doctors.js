/* changing date format MM-DD-YYYY */

var appointment_date = '';
var month = parseInt(new Date().getMonth()) + 1 ;
var today_date = (month <10 ? '0' + month : month) + '-' + new Date().getDate() + '-' + new Date().getFullYear();

if (params['appointment_date'] != undefined){
   appointment_date = change_date_format(params['appointment_date']) ;
}
/* End of date format MM-DD-YYYY */

$(function () {


  /* redirecting url with today date */

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
  /* End of redirecting url with today date */

  /* Date Picker*/

  $(".appointments_date_selector").datepicker({
    changeMonth: true,
    changeYear: true,
    yearRange:'1940:' + new Date().getFullYear(),
    onSelect:function (dateText, inst) {
      window.location = '/doctor/appointments' + '?appointment_date=' + set_default_date_format(dateText);
    }

  }).datepicker("option", "dateFormat", "mm-dd-yy").datepicker('setDate', appointment_date !='' ? appointment_date : today_date);
  /* ENd of Date Picker*/
});


