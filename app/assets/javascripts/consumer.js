// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//= require consumer

$(function () {

  if ($('.page').attr('data-page') == "consumer_index") {
    $(window).load(function () {
      if (consumer_tab_index != '' && consumer_tab_index != "0") {
        var tab_index = parseInt(consumer_tab_index);
        $("#consumer_tab_links a:eq(" + tab_index + ")").tab('show');
      } else {
        $("#boy_scouts").attr('data-is_loaded', 'true');
        $("#boy_scouts").load('/consumer/boy_scouts_list');
      }
    });

    $('#consumer_tab_links li a').on('shown', function (e) {
      if ($($(this).attr('href')).attr('data-is_loaded') == 'false') {
        $($(this).attr('href')).attr('data-is_loaded', 'true');
        if ($(this).attr('href') == '#dental'){
          $($(this).attr('href')).load('/patient/appointments');
        }else{
          $($(this).attr('href')).load('/consumer/' + $(this).attr('data-action'));
        }
      }
      return false;
    });
  }

  /* Girl Scout Tab */



  /* end Girl Scout Tab */

  /* Dental*/

//  $(".appointments_date_selector").datepicker({
//    onSelect:function (dateText, inst) {
//       window.location = '/patient/appointments' + '?appointment_date=' + dateText;
//    }
//  }).datepicker("option", "dateFormat", "yy-mm-dd").datepicker('setDate', params['appointment_date'] ? params['appointment_date'] : '');
//
//  $('.show_all').change(function(){console.log('aa')});

 /* end  Dental Tab */

});
