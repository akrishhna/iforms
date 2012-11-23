//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require jquery.fancybox
//= require 'jquery.maskedinput'
//= require formToWizard
//= require jquery.autotab-1.1b
//= require_self

$(document).ready(function(){

	//for steps wizard
	$("#dd_dd").formToWizard({ submitButton: 'step_submit' });

	//auto saving the iform data changes
	$('form#dd_dd input, form#dd_dd select').change(function(){
		var iform_id = $('#iform_id').val();
		if(iform_id == '' || iform_id == undefined) {
			return false;
		}

		var field = $(this).attr('name');
		var field_val = $(this).val();
		var params = {'iform_id':iform_id};
		params[field] = field_val;

		$.post('/iforms/iform_field_update',
			params,
			function(data){

			},
			'json');
	});



  // User service provides selection
  $('select#user_service_provider_list').change(function() {
    if($(this).val() == 1){
      window.location = '/doctor/appointments?sp_id=1'
    }
    else if($(this).val() == 2){
      window.location = '/girl_scouts_troop_leaders?sp_id=2'
    }
    else if($(this).val() == 3){
      window.location = '/girl_scouts_troop_leaders?sp_id=3'
    }
    else if($(this).val() == 0){
      window.location = '/consumer'
    }
    else if($(this).val() == 4){
      window.location = '/doctor/appointments?sp_id=4'
    }
    else{
      window.location = '/'
    }
  });

});

//Check if the function exists
if (typeof Element.insert !== "function") {
	//If not, hook it onto the $().append method.
	Element.insert = function (elem, ins) {
		$("#" + elem).append(ins.bottom);
	};
}