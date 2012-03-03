//= require jquery
//= require jquery_ujs
//= require 'jquery.maskedinput'
//= require formToWizard
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
});

//Check if the function exists
if (typeof Element.insert !== "function") {
	//If not, hook it onto the $().append method.
	Element.insert = function (elem, ins) {
		$("#" + elem).append(ins.bottom);
	};
}