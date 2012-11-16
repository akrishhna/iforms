$('.adult_iforms_nav_link').live('click', function () {
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#adult_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
  // return false;
});

$('.chaild_iforms_nav_link').live('click', function () {
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#chaild_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
  // return false;
});

$('.karen_naples_1_iforms_nav_link').live('click', function () {
  // console.log($(this).attr('data_tab_index'));
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#karen_naples_1_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
  // return false;
});

$('#billing_tab').live('click', function () {
  billing_details_info();
  update_all_fields();
});


$('.karnel_naples_1_billing').live('change', function () {
  if ($('.karnel_naples_1_billing:checked').val() == 'self') {
    billing_details_info();
  }
  else {
    $('.karnel_naples_1_billing_details_info').attr('readonly', false);
    $('#iform_billing_details_first_name').val('');
    $('#iform_billing_details_last_name').val('');
    $('#iform_relationship_to_patient').val('');
    $('#iform_billing_details_address1').val('');
    $('#iform_billing_details_address2').val('');
    $('#iform_billing_details_address_city').val('');
    $('#iform_billing_details_address_state').val('');
    $('#iform_billing_details_address_postal_code').val('');
    $('#iform_billing_details_home_phone_1').val('');
    $('#iform_billing_details_home_phone_2').val('');
    $('#iform_billing_details_home_phone_3').val('');
    $('#iform_billing_details_work_phone_1').val('');
    $('#iform_billing_details_work_phone_2').val('');
    $('#iform_billing_details_work_phone_3').val('');
    $('#iform_billing_details_cell_phone_1').val('');
    $('#iform_billing_details_cell_phone_2').val('');
    $('#iform_billing_details_cell_phone_3').val('');
    $('#iform_billing_details_ssn').val('');
    $('#iform_billing_details_driving_licence_state').val('');
    $('#iform_billing_details_driving_licence_number').val('');
    $('#iform_billing_details_employer_name').val('');
    $('#iform_billing_details_employer_address1').val('');
    $('#iform_billing_details_employer_address2').val('');
    $('#iform_billing_details_employer_address_city').val('');
    $('#iform_billing_details_employer_address_state').val('');
    $('#iform_billing_details_employer_address_postal_code').val('');
    $('#iform_billing_details_employer_phone_1').val('');
    $('#iform_billing_details_employer_phone_2').val('');
    $('#iform_billing_details_employer_phone_3').val('');
  }
  update_all_fields();
});


function update_all_fields() {
  $('input[name=_method]').val('post');
  var params = $('.edit_karen_naples_1_iform').serializeArray();
  if ($('.karnel_naples_1_billing:checked').val() == 'self') {
    $.post('/iforms/iform_all_fields_update', params, function () {
      $('.karnel_naples_1_billing_details_info').attr('readonly', true);
    });
  }
}

function billing_details_info() {
  if ($('.karnel_naples_1_billing:checked').val() == 'self') {
    $('.karnel_naples_1_billing_details_info').attr('readonly', true);
    $('#iform_billing_details_first_name').val($('#iform_Self_Name_First').val());
    $('#iform_billing_details_last_name').val($('#iform_Self_Name_Last').val());
    $('#iform_relationship_to_patient').val('Self');
    $('#iform_billing_details_address1').val($('#iform_Self_Home_Address1').val());
    $('#iform_billing_details_address2').val($('#iform_Self_Home_Address2').val());
    $('#iform_billing_details_address_city').val($('#iform_Self_Home_City').val());
    $('#iform_billing_details_address_state').val($('#iform_Self_Home_State').val());
    $('#iform_billing_details_address_postal_code').val($('#iform_Self_Home_Postal_Code').val());
    $('#iform_billing_details_home_phone_1').val($('#iform_home_phone_1').val());
    $('#iform_billing_details_home_phone_2').val($('#iform_home_phone_2').val());
    $('#iform_billing_details_home_phone_3').val($('#iform_home_phone_3').val());
    $('#iform_billing_details_work_phone_1').val($('#iform_work_phone_1').val());
    $('#iform_billing_details_work_phone_2').val($('#iform_work_phone_2').val());
    $('#iform_billing_details_work_phone_3').val($('#iform_work_phone_3').val());
    $('#iform_billing_details_cell_phone_1').val($('#iform_cell_phone_1').val());
    $('#iform_billing_details_cell_phone_2').val($('#iform_cell_phone_2').val());
    $('#iform_billing_details_cell_phone_3').val($('#iform_cell_phone_3').val());
    $('#iform_billing_details_ssn').val($('#iform_Self_Social_Security_Number').val());
    $('#iform_billing_details_driving_licence_state').val($('#iform_Self_Driver_License_State').val());
    $('#iform_billing_details_driving_licence_number').val($('#iform_Self_Driver_License_Number').val());
    $('#iform_billing_details_employer_name').val($('#iform_Self_Employer_Name').val());
    $('#iform_billing_details_employer_address1').val($('#iform_Self_Employer_Address1').val());
    $('#iform_billing_details_employer_address2').val($('#iform_Self_Employer_Address2').val());
    $('#iform_billing_details_employer_address_city').val($('#iform_Self_Employer_City').val());
    $('#iform_billing_details_employer_address_state').val($('#iform_Self_Employer_State').val());
    $('#iform_billing_details_employer_address_postal_code').val($('#iform_Self_Employer_Postal_Code').val());
    $('#iform_billing_details_employer_phone_1').val($('#iform_employer_phone_1').val());
    $('#iform_billing_details_employer_phone_2').val($('#iform_employer_phone_2').val());
    $('#iform_billing_details_employer_phone_3').val($('#iform_employer_phone_3').val());

  }
}

//$('#iform_Self_Social_Security_Number').live('keydown', function (e) {
//  if (e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 46 || e.keyCode == 17 || e.keyCode == 86) {
//  } else {
//    e.preventDefault();
//  }
//});
//
//$('#iform_Self_Social_Security_Number').live('blur', function () {
//  if ($(this).val().length < 9) {
//    $(this).val('');
//  } else {
//    $(this).mask('999-99-9999').unmask();
//  }
//});