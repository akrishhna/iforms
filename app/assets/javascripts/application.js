//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require jquery.livequery
//= require jquery.fancybox
//= require 'jquery.maskedinput'
//= require formToWizard
//= require jquery.autotab-1.1b
//= require jquery-ui-timepicker-addon
//= require_self

$(document).ready(function () {

  //for steps wizard
  $("#dd_dd").formToWizard({ submitButton:'step_submit' });

  //auto saving the iform data changes
  $('form#dd_dd input, form#dd_dd select').live('change',function () {
    var iform_id = $('#iform_id').val();
    if (iform_id == '' || iform_id == undefined) {
      return false;
    }

    var field = $(this).attr('name');
    var field_val = $(this).val();
    if(field.search(/displaying_date/) ==  0){
      field = $(this).next().attr('name');
      field_val = $(this).next().val();
    }
    var params = {'iform_id':iform_id};
    params[field] = field_val;

    $.post('/iforms/iform_field_update',
      params,
      function (data) {

      },
      'json');
  });

  /* changing date format */

  $('.display_date').change(function () {
    var date = set_default_date_format($(this).val());
    $(this).next().val(date);
  });

  /* End of changing date format */


  // User service provides selection
  $('select#user_service_provider_list').change(function () {
    if ($(this).val() == 1) {
      window.location = '/doctor/appointments?sp_id=1'
    }
    else if ($(this).val() == 2) {
      window.location = '/girl_scouts_troop_leaders?sp_id=2'
    }
    else if ($(this).val() == 3) {
      window.location = '/girl_scouts_troop_leaders?sp_id=3'
    }
    else if ($(this).val() == 4) {
      window.location = '/doctor/appointments?sp_id=4'
    }
    else if ($(this).val() == 5) {
      window.location = '/medical_appointments?sp_id=5'
    }
    else if ($(this).val() == 0) {
      window.location = '/consumer'
    }
    else if ($(this).val() == 6) {
      window.location = '/boy_scouts_troop_leaders?sp_id=6'
    }
    else if ($(this).val() == 7) {
      window.location = '/doctor/appointments?sp_id=7'
    }
    else if ($(this).val() == 8) {
      window.location = '/girl_scouts_troop_leaders?sp_id=8'
    }
    else if ($(this).val() == 9) {
      window.location = '/girl_scouts_troop_leaders?sp_id=9'
    }
    else if ($(this).val() == 10) {
      window.location = '/girl_scouts_troop_leaders?sp_id=10'
    }
    else if ($(this).val() == 11) {
      window.location = '/girl_scouts_troop_leaders?sp_id=11'
    }
    else if ($(this).val() == 12) {
      window.location = '/girl_scouts_troop_leaders?sp_id=12'
    }
    else {
      window.location = '/'
    }
  });

});

/* changing date format */

function change_date_format(date) {
  var datePart = date.split(/[^0-9]+/);
  return (datePart[1] + "-" + datePart[2] + "-" + datePart[0])
}

function set_default_date_format(date) {
  var datePart = date.split(/[^0-9]+/);
  return (datePart[2] + "-" + datePart[0] + "-" + datePart[1])
}

/* End of changing date format */

//Check if the function exists
if (typeof Element.insert !== "function") {
  //If not, hook it onto the $().append method.
  Element.insert = function (elem, ins) {
    $("#" + elem).append(ins.bottom);
  };
}