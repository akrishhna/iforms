// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function () {

  $(".appointments_date_selector").datepicker({
    onSelect:function (dateText, inst) {
      // window.location = '/patient/appointments' + '?appointment_date=' + dateText;
    }
  }).datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : '');

  $('.show_all').change(function(){console.log('aa')});
});
