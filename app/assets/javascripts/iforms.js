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

$('.karen_naples_new_patient_iforms_nav_link').live('click', function () {
  // console.log($(this).attr('data_tab_index'));
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#karen_naples_new_patient_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
  // return false;
});

$('.rising_stars_pediatric_iforms_nav_link').live('click', function () {
  // console.log($(this).attr('data_tab_index'));
  var tab_index = parseInt($(this).attr('data_tab_index'));
  $("#rising_stars_pediatric_iforms_tab_links a:eq(" + tab_index + ")").tab('show');
  // return false;
});


/* Karen Naples */


$('#billing_tab').live('click', function () {
  billing_details_info();
  update_all_fields();
});


$('.karnel_naples_new_patient_billing').live('change', function () {
  if ($('.karnel_naples_new_patient_billing:checked').val() == 'Self') {
    billing_details_info();
  }
  else {
    $('.karen_naples_new_patient_billing_details_info').attr('readonly', false);
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
    $('#iform_billing_details_ssn_1').val('');
    $('#iform_billing_details_ssn_2').val('');
    $('#iform_billing_details_ssn_3').val('');
    $('#iform_billing_birth_date_1i').val('').attr('disabled', false);
    $('#iform_billing_birth_date_2i').val('').attr('disabled', false);
    $('#iform_billing_birth_date_3i').val('').attr('disabled', false);
  }
  update_all_fields();
});


function update_all_fields() {
  if ($('.karnel_naples_new_patient_billing:checked').val() == 'Self') {
    $('input[name=_method]').val('post');
    var params = $('.edit_karen_naples_new_patient_iform').serializeArray();
    $.post('/iforms/iform_all_fields_update', params, function () {
      $('.karen_naples_new_patient_billing_details_info').attr('readonly', true);
    });
  }
  $('input[name=_method]').val('put');
}

function billing_details_info() {
  if ($('.karnel_naples_new_patient_billing:checked').val() == 'Self') {
    $('.karen_naples_new_patient_billing_details_info').attr('readonly', true);
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
    $('#iform_billing_details_ssn_1').val($('#iform_ssn_1').val());
    $('#iform_billing_details_ssn_2').val($('#iform_ssn_2').val());
    $('#iform_billing_details_ssn_3').val($('#iform_ssn_3').val());
    $('#iform_billing_birth_date_1i').val($('#iform_Self_Birthdate_1i').val()).attr('disabled', true);
    $('#iform_billing_birth_date_2i').val($('#iform_Self_Birthdate_2i').val()).attr('disabled', true);
    $('#iform_billing_birth_date_3i').val($('#iform_Self_Birthdate_3i').val()).attr('disabled', true);
  }
}

/* End Karen Naples */

/* Rising stars */

$('.rising_stars_first_tim_visit').live('change',function(){
   if($('.rising_stars_first_tim_visit:checked').val() == 'Yes'){
     $('.rising_stars_last_visit').hide();
   }else{
     $('.rising_stars_last_visit').show();
   }
});


$('.rising_stars_more_than_1_insurance').live('change',function(){
  if($('.rising_stars_more_than_1_insurance:checked').val() == 'Yes'){
    $('.rising_stars_second_company').show();
  }else{
    $('.rising_stars_second_company').hide();
  }
});

$('.rising_stars_good_gen_health').live('change', function () {
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_patient_good_general_health_description').hide()
  }
  else {
    $('#iform_medical_history_patient_good_general_health_description').val('');
    $('#iform_medical_history_patient_good_general_health_description').show()
  }
});

$('.rising_stars_physical_dev').live('change', function () {
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_patient_physical_disabilities_description').val('');
    $('#iform_medical_history_patient_physical_disabilities_description').show()
  }
  else {
    $('#iform_medical_history_patient_physical_disabilities_description').hide()
  }
});

$('.rising_stars_surgical_operations').live('change', function () {
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_patient_surgical_operations_description').val('');
    $('#iform_medical_history_patient_surgical_operations_description').show()
  }
  else {
    $('#iform_medical_history_patient_surgical_operations_description').hide()
  }
});

$('.rising_stars_patient_hosp').live('change', function () {
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_patient_ever_been_hospitalized_description').val('');
    $('#iform_medical_history_patient_ever_been_hospitalized_description').show()
  }
  else {
    $('#iform_medical_history_patient_ever_been_hospitalized_description').hide()
  }
});

$('#iform_medical_history_food_allergies').live('change', function () {
  if ($(this).is(':checked')) {
    $('#iform_medical_history_food_allergies_description').val('');
    $('#iform_medical_history_food_allergies_description').show();
  } else {
    $('#iform_medical_history_food_allergies_description').hide();
  }
});


$('#iform_medical_history_drug_allergies').live('change', function () {
  if ($(this).is(':checked')) {
    $('#iform_medical_history_drug_allergies_description').val('');
    $('#iform_medical_history_drug_allergies_description').show();
  } else {
    $('#iform_medical_history_drug_allergies_description').hide();
  }
});

$('.rising_stars_asthama_or_breath').live('change',function(){
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_asthama_or_breathing_prob_description').val('');
    $('#iform_medical_history_asthama_or_breathing_prob_description').show();
    $('.rising_stars_asthama_yes').show()
  }else{
    $('#iform_medical_history_asthama_or_breathing_prob_description').hide();
    $('.rising_stars_asthama_yes').hide()
  }
});

$('.rising_stars_er_asthama').live('change',function(){
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_er_for_asthma_attack_description').val('');
    $('#iform_medical_history_er_for_asthma_attack_description').show();
  }else{
    $('#iform_medical_history_er_for_asthma_attack_description').hide();
  }
});

$('.rising_stars_seizures').live('change',function(){
  console.log($(this).val());
  if ($(this).val() == 'Yes') {
    $('#iform_medical_history_date_of_last_seizure').val('');
    $('.rising_stars_seizures_date').show();
  }else{
    $('.rising_stars_seizures_date').hide();
  }
});

$('#iform_dental_history_other').live('change', function () {
  if ($(this).is(':checked')) {
    $('#iform_dental_history_oral_habits_other_description').val('');
    $('#iform_dental_history_oral_habits_other_description').show();
  } else {
    $('#iform_dental_history_oral_habits_other_description').hide();
  }
});

$('.rising_stars_mother_type').live('change', function () {
  if ($(this).val() == 'Other') {
    $('#iform_patient_guardian_mother_other_description').val('');
    $('#iform_patient_guardian_mother_other_description').show()
  }
  else {
    $('#iform_patient_guardian_mother_other_description').hide()
  }
});

$('.rising_stars_father_type').live('change', function () {
  if ($(this).val() == 'Other') {
    $('#iform_patient_guardian_father_other_description').val('');
    $('#iform_patient_guardian_father_other_description').show()
  }
  else {
    $('#iform_patient_guardian_father_other_description').hide()
  }
});

/* ENd Rising stars */

