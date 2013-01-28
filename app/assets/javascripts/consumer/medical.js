$(function () {

  $('form.edit_medical_patient_form input, form.edit_medical_patient_form select').live('change', function () {
    var id = $('#medical_patient_form_id').val();
    if (id == '' || id == undefined) {
      return false;
    }
    $('input[name=_method]').val('post');
    var field = $(this).attr('name');
    var field_val = $(this).val();
    if(field.search(/displaying_date/) ==  0){
      field = $(this).next().attr('name');
      field_val = $(this).next().val();
    }
    var params = {'id':id};
    params[field] = field_val;
    $.post('/consumer/medical/medical_patient_form_field_update', params);
    $('input[name=_method]').val('put');
  });


  $(".medical_Patient_form_date_selector").datepicker({
    changeMonth:true,
    changeYear:true,
    dateFormat:'mm-dd-yy',
    yearRange:'1940:' + new Date().getFullYear()
  });
  /* changing display date format*/

  var birth_date = $('#displaying_date_birth_date').attr('data-value');
  var primary_insurance_birth_date = $('#displaying_date_primary_insurance_birth_date').attr('data-value');
  var secondary_insurance_birth_date = $('#displaying_date_secondary_insurance_birth_date').attr('data-value');
  var medical_history_operations_1 = $('#displaying_date_medical_history_operations_1').attr('data-value');
  var medical_history_operations_2 = $('#displaying_date_medical_history_operations_2').attr('data-value');
  var medical_history_operations_3 = $('#displaying_date_medical_history_operations_3').attr('data-value');
  var medical_history_operations_4 = $('#displaying_date_medical_history_operations_4').attr('data-value');
  var medical_history_operations_5 = $('#displaying_date_medical_history_operations_5').attr('data-value');
  var medical_history_operations_6 = $('#displaying_date_medical_history_operations_6').attr('data-value');
  var medical_history_previous_illnesses_1 = $('#displaying_date_medical_history_previous_illnesses_1').attr('data-value');
  var medical_history_previous_illnesses_2 = $('#displaying_date_medical_history_previous_illnesses_2').attr('data-value');
  var medical_history_previous_illnesses_3 = $('#displaying_date_medical_history_previous_illnesses_3').attr('data-value');
  var medical_history_previous_illnesses_4 = $('#displaying_date_medical_history_previous_illnesses_4').attr('data-value');
  var medical_history_previous_illnesses_5 = $('#displaying_date_medical_history_previous_illnesses_5').attr('data-value');
  var medical_history_previous_illnesses_6 = $('#displaying_date_medical_history_previous_illnesses_6').attr('data-value');
  var medical_history_previous_illnesses_7 = $('#displaying_date_medical_history_previous_illnesses_7').attr('data-value');
  var medical_history_previous_illnesses_8 = $('#displaying_date_medical_history_previous_illnesses_8').attr('data-value');
  var medical_history_previous_illnesses_9 = $('#displaying_date_medical_history_previous_illnesses_9').attr('data-value');
  var medical_history_previous_illnesses_10 = $('#displaying_date_medical_history_previous_illnesses_10').attr('data-value');
  var health_maintenance_bone_density_test = $('#displaying_date_health_maintenance_bone_density_test').attr('data-value');
  var health_maintenance_skin_cancer_screening = $('#displaying_date_health_maintenance_skin_cancer_screening').attr('data-value');
  var health_maintenance_test_date = $('#displaying_date_health_maintenance_test_date').attr('data-value');
  var health_maintenance_most_recent_tetanus_vaccine_booster = $('#displaying_date_health_maintenance_most_recent_tetanus_vaccine_booster').attr('data-value');
  var health_maintenance_shingles_vaccine = $('#displaying_date_health_maintenance_shingles_vaccine').attr('data-value');
  var health_maintenance_pneumovax = $('#displaying_date_health_maintenance_pneumovax').attr('data-value');
  var health_maintenance_flu_vaccine = $('#displaying_date_health_maintenance_flu_vaccine').attr('data-value');
  var health_maintenance_colonoscopy = $('#displaying_date_health_maintenance_colonoscopy').attr('data-value');

  $('#displaying_date_birth_date').datepicker("setDate", birth_date ? change_date_format(birth_date) : '');
  $('#displaying_date_primary_insurance_birth_date').datepicker("setDate", primary_insurance_birth_date ? change_date_format(primary_insurance_birth_date) : '');
  $('#displaying_date_secondary_insurance_birth_date').datepicker("setDate", secondary_insurance_birth_date ? change_date_format(secondary_insurance_birth_date) : '');
  $('#displaying_date_medical_history_operations_1').datepicker("setDate", medical_history_operations_1 ? change_date_format(medical_history_operations_1) : '');
  $('#displaying_date_medical_history_operations_2').datepicker("setDate", medical_history_operations_2 ? change_date_format(medical_history_operations_2) : '');
  $('#displaying_date_medical_history_operations_3').datepicker("setDate", medical_history_operations_3 ? change_date_format(medical_history_operations_3) : '');
  $('#displaying_date_medical_history_operations_4').datepicker("setDate", medical_history_operations_4 ? change_date_format(medical_history_operations_4) : '');
  $('#displaying_date_medical_history_operations_5').datepicker("setDate", medical_history_operations_5 ? change_date_format(medical_history_operations_5) : '');
  $('#displaying_date_medical_history_operations_6').datepicker("setDate", medical_history_operations_6 ? change_date_format(medical_history_operations_6) : '');
  $('#displaying_date_medical_history_previous_illnesses_1').datepicker("setDate", medical_history_previous_illnesses_1 ? change_date_format(medical_history_previous_illnesses_1) : '');
  $('#displaying_date_medical_history_previous_illnesses_2').datepicker("setDate", medical_history_previous_illnesses_2 ? change_date_format(medical_history_previous_illnesses_2) : '');
  $('#displaying_date_medical_history_previous_illnesses_3').datepicker("setDate", medical_history_previous_illnesses_3 ? change_date_format(medical_history_previous_illnesses_3) : '');
  $('#displaying_date_medical_history_previous_illnesses_4').datepicker("setDate", medical_history_previous_illnesses_4 ? change_date_format(medical_history_previous_illnesses_4) : '');
  $('#displaying_date_medical_history_previous_illnesses_5').datepicker("setDate", medical_history_previous_illnesses_5 ? change_date_format(medical_history_previous_illnesses_5) : '');
  $('#displaying_date_medical_history_previous_illnesses_6').datepicker("setDate", medical_history_previous_illnesses_6 ? change_date_format(medical_history_previous_illnesses_6) : '');
  $('#displaying_date_medical_history_previous_illnesses_7').datepicker("setDate", medical_history_previous_illnesses_7 ? change_date_format(medical_history_previous_illnesses_7) : '');
  $('#displaying_date_medical_history_previous_illnesses_8').datepicker("setDate", medical_history_previous_illnesses_8 ? change_date_format(medical_history_previous_illnesses_8) : '');
  $('#displaying_date_medical_history_previous_illnesses_9').datepicker("setDate", medical_history_previous_illnesses_9 ? change_date_format(medical_history_previous_illnesses_9) : '');
  $('#displaying_date_medical_history_previous_illnesses_10').datepicker("setDate", medical_history_previous_illnesses_10 ? change_date_format(medical_history_previous_illnesses_10) : '');
  $('#displaying_date_health_maintenance_bone_density_test').datepicker("setDate", health_maintenance_bone_density_test ? change_date_format(health_maintenance_bone_density_test) : '');
  $('#displaying_date_health_maintenance_skin_cancer_screening').datepicker("setDate", health_maintenance_skin_cancer_screening ? change_date_format(health_maintenance_skin_cancer_screening) : '');
  $('#displaying_date_health_maintenance_test_date').datepicker("setDate", health_maintenance_colonoscopy ? change_date_format(health_maintenance_colonoscopy) : '');
  $('#displaying_date_health_maintenance_most_recent_tetanus_vaccine_booster').datepicker("setDate", health_maintenance_most_recent_tetanus_vaccine_booster ? change_date_format(health_maintenance_most_recent_tetanus_vaccine_booster) : '');
  $('#displaying_date_health_maintenance_shingles_vaccine').datepicker("setDate", health_maintenance_shingles_vaccine ? change_date_format(health_maintenance_shingles_vaccine) : '');
  $('#displaying_date_health_maintenance_pneumovax').datepicker("setDate", health_maintenance_pneumovax ? change_date_format(health_maintenance_pneumovax) : '');
  $('#displaying_date_health_maintenance_flu_vaccine').datepicker("setDate", health_maintenance_flu_vaccine ? change_date_format(health_maintenance_flu_vaccine) : '');
  $('#displaying_date_health_maintenance_colonoscopy').datepicker("setDate", health_maintenance_test_date ? change_date_format(health_maintenance_test_date) : '');

  /* End of changing display date format*/


  $('.medical_patient_form_nav_link').live('click', function () {
    var tab_index = parseInt($(this).attr('data_tab_index'));
    $("#medical_patient_form_tab_links a:eq(" + tab_index + ")").tab('show');
    // return false;
  });

  $('#medical_patient_form_social_history_no_of_children').live('blur', function () {
    if ($(this).val() < 1) {
      $('#medical_patient_form_social_history_age_of_children').val('');
      $('#medical_patient_form_social_history_age_of_children').attr('readonly', true);
    } else {
      $('#medical_patient_form_social_history_age_of_children').attr('readonly', false);
    }
  });

  $('#medical_patient_form_social_history_exercise_approximately').live('blur', function () {
    if ($(this).val() < 1) {
      $('#medical_patient_form_social_history_ex_minutes_per_day').val('');
      $('#medical_patient_form_social_history_exercise_type').val('');
      $('#medical_patient_form_social_history_ex_minutes_per_day').attr('readonly', true);
      $('#medical_patient_form_social_history_exercise_type').attr('readonly', true);
    } else {
      $('#medical_patient_form_social_history_ex_minutes_per_day').attr('readonly', false);
      $('#medical_patient_form_social_history_exercise_type').attr('readonly', false);
    }
  });

  $('.medical_patient_form_smoking').live('change', function () {
    if ($('.medical_patient_form_smoking:checked').val() == "Never") {
      $('#medical_patient_form_social_history_smoking_packs_per_day').val('');
      $('#medical_patient_form_social_history_smoking_no_of_years').val('');
      $('#medical_patient_form_social_history_smoking_quit_years').val('');
      $('#medical_patient_form_social_history_smoking_packs_per_day').attr('readonly', true);
      $('#medical_patient_form_social_history_smoking_no_of_years').attr('readonly', true);
      $('#medical_patient_form_social_history_smoking_quit_years').attr('readonly', true);
    } else if ($('.medical_patient_form_smoking:checked').val() == "I smoke now") {
      $('#medical_patient_form_social_history_smoking_quit_years').val('');
      $('#medical_patient_form_social_history_smoking_packs_per_day').attr('readonly', false);
      $('#medical_patient_form_social_history_smoking_no_of_years').attr('readonly', false);
      $('#medical_patient_form_social_history_smoking_quit_years').attr('readonly', true);
    }
    else if ($('.medical_patient_form_smoking:checked').val() == "I did, but I quit") {
      $('#medical_patient_form_social_history_smoking_packs_per_day').val('');
      $('#medical_patient_form_social_history_smoking_no_of_years').val('');
      $('#medical_patient_form_social_history_smoking_packs_per_day').attr('readonly', false);
      $('#medical_patient_form_social_history_smoking_no_of_years').attr('readonly', false);
      $('#medical_patient_form_social_history_smoking_quit_years').attr('readonly', false);
    } else {
    }
  });

  $('.medical_patient_form_recreational_drug').live('change', function () {
    if ($('.medical_patient_form_recreational_drug:checked').val() == "Yes") {
      $('#medical_patient_form_social_history_yes_i_have_used_recreational_drugs').attr('readonly', false);
    } else {
      $('#medical_patient_form_social_history_yes_i_have_used_recreational_drugs').val('');
      $('#medical_patient_form_social_history_yes_i_have_used_recreational_drugs').attr('readonly', true);
    }
  });

  $('.medical_patient_form_recently_traveled').live('change', function () {
    if ($('.medical_patient_form_recently_traveled:checked').val() == "Yes") {
      $('#medical_patient_form_social_history_yes_i_recently_traveled').attr('readonly', false);
    } else {
      $('#medical_patient_form_social_history_yes_i_recently_traveled').val('');
      $('#medical_patient_form_social_history_yes_i_recently_traveled').attr('readonly', true);
    }
  });

  $('.review_of_sym_sexual_difficulty').hide();
  $('.only_for_male').hide();
  $('.only_for_female').hide();

  $('.medical_patient_form_gender').live('change', function () {
    if ($('.medical_patient_form_gender:checked').val() == "Male") {
      $('.review_of_sym_sexual_difficulty').show();
      $('.only_for_male').show();
      $('.only_for_female').hide();
    } else {
      $('#medical_patient_form_review_of_sym_sexual_difficulty_achieving_and_maintaining').attr('checked', false);
      $('.review_of_sym_sexual_difficulty').hide();
      $('.only_for_male').hide();
      $('.only_for_female').show();
    }
  });

  $('#medical_patient_form_review_of_sym_musculoskeletal_joint_pain_or_stiffness').live('click', function () {
    if ($(this).is(':checked')) {
      $('#medical_patient_form_review_of_sym_joints_that_are_painful_or_stiff').attr('readonly', false);
    } else {
      $('#medical_patient_form_review_of_sym_joints_that_are_painful_or_stiff').val('');
      $('#medical_patient_form_review_of_sym_joints_that_are_painful_or_stiff').attr('readonly', true);
    }
  });

  $('#medical_patient_form_review_of_sym_musculoskeletal_joint_swelling_or_redness').live('click', function () {
    if ($(this).is(':checked')) {
      $('#medical_patient_form_review_of_sym_joints_that_are_swelling_or_have_redness').attr('readonly', false);
    } else {
      $('#medical_patient_form_review_of_sym_joints_that_are_swelling_or_have_redness').val('');
      $('#medical_patient_form_review_of_sym_joints_that_are_swelling_or_have_redness').attr('readonly', true);
    }
  });

  $('#medical_patient_form_review_of_sym_neurological_weakness').live('click', function () {
    if ($(this).is(':checked')) {
      $('#medical_patient_form_review_of_sym_neurological_weakness_which_part_of_body').attr('readonly', false);
    } else {
      $('#medical_patient_form_review_of_sym_neurological_weakness_which_part_of_body').val('');
      $('#medical_patient_form_review_of_sym_neurological_weakness_which_part_of_body').attr('readonly', true);
    }
  });

  $('.medical_patient_form_colonoscopy_test').live('change', function () {
    if ($('.medical_patient_form_colonoscopy_test:checked').val() == "Abnormal") {
      $('#medical_patient_form_health_maintenance_description_of_abnormal_test_results').attr('readonly', false);
    } else {
      $('#medical_patient_form_health_maintenance_description_of_abnormal_test_results').val('');
      $('#medical_patient_form_health_maintenance_description_of_abnormal_test_results').attr('readonly', true);
    }
  });

  $('#medical_patient_form_health_maintenance_hysterectomy').live('change', function () {
    if ($('#medical_patient_form_health_maintenance_hysterectomy').val() == "") {
      $('#medical_patient_form_health_maintenance_why_was_hysterectomy_performed').val('');
      $('#medical_patient_form_health_maintenance_why_was_hysterectomy_performed').attr('readonly', true);
    } else {
      $('#medical_patient_form_health_maintenance_why_was_hysterectomy_performed').attr('readonly', false);
    }
  });

  $('.medical_patient_form_social_history_live').live('change', function () {
    if ($('.medical_patient_form_social_history_live:checked').val() == "Alone") {
      $('#medical_patient_form_social_history_live_with_whom').val('');
      $('#medical_patient_form_social_history_live_with_whom').attr('readonly', true);
    } else {
      $('#medical_patient_form_social_history_live_with_whom').attr('readonly', false);
    }
  });

  // pre populating fields

  $('#insurance_primary_tab').live('click', function () {
    primary_insurance_details_info();
    update_all_fields();
  });

  $('#insurance_secondary_tab').live('click', function () {
    secondary_insurance_details_info();
    update_all_fields();
  });

  $('.medical_patient_primary_insurance_policy').live('change', function () {
    if ($('.medical_patient_primary_insurance_policy:checked').val() == 'Self') {
      primary_insurance_details_info();
    }
    else {
      $('.medical_patient_primary_insurance_policy_details').attr('readonly', false);
      $('#medical_patient_form_primary_insurance_policy_holder_first_name').val('');
      $('#medical_patient_form_primary_insurance_policy_holder_last_name').val('');
      $('#medical_patient_form_primary_insurance_relationship').val('');
      $('#medical_patient_form_primary_insurance_birth_date').val('').attr('disabled', false);
      $('#medical_patient_form_primary_insurance_ssn_1').val('');
      $('#medical_patient_form_primary_insurance_ssn_2').val('');
      $('#medical_patient_form_primary_insurance_ssn_3').val('');
      $('#medical_patient_form_primary_insurance_policy_holder_employer').val('');
    }
    update_all_fields();
  });

  function primary_insurance_details_info() {
    if ($('.medical_patient_primary_insurance_policy:checked').val() == 'Self') {
      $('.medical_patient_primary_insurance_policy_details').attr('readonly', true);
      $('#medical_patient_form_primary_insurance_policy_holder_first_name').val($('#medical_patient_form_first_name').val());
      $('#medical_patient_form_primary_insurance_policy_holder_last_name').val($('#medical_patient_form_last_name').val());
      $('#medical_patient_form_primary_insurance_relationship').val('Self');
      $('#medical_patient_form_primary_insurance_birth_date').val($('#medical_patient_form_birth_date').val()).attr('disabled', true);
      $('#medical_patient_form_primary_insurance_ssn_1').val($('#medical_patient_form_ssn_1').val());
      $('#medical_patient_form_primary_insurance_ssn_2').val($('#medical_patient_form_ssn_2').val());
      $('#medical_patient_form_primary_insurance_ssn_3').val($('#medical_patient_form_ssn_3').val());
      $('#medical_patient_form_primary_insurance_policy_holder_employer').val($('#medical_patient_form_employer').val());
    }
  }

  $('.medical_patient_secondary_insurance_policy').live('change', function () {
    if ($('.medical_patient_secondary_insurance_policy:checked').val() == 'Self') {
      secondary_insurance_details_info();
    }
    else {
      $('.medical_patient_secondary_insurance_policy_details').attr('readonly', false);
      $('#medical_patient_form_secondary_insurance_policy_holder_first_name').val('');
      $('#medical_patient_form_secondary_insurance_policy_holder_last_name').val('');
      $('#medical_patient_form_secondary_insurance_birth_date').val('').attr('disabled', false);
      $('#medical_patient_form_secondary_insurance_ssn_1').val('');
      $('#medical_patient_form_secondary_insurance_ssn_2').val('');
      $('#medical_patient_form_secondary_insurance_ssn_3').val('');
      $('#medical_patient_form_secondary_insurance_policy_holder_employer').val('');
    }
    update_all_fields();
  });

  function secondary_insurance_details_info() {
    if ($('.medical_patient_secondary_insurance_policy:checked').val() == 'Self') {
      $('.medical_patient_secondary_insurance_policy_details').attr('readonly', true);
      $('#medical_patient_form_secondary_insurance_policy_holder_first_name').val($('#medical_patient_form_first_name').val());
      $('#medical_patient_form_secondary_insurance_policy_holder_last_name').val($('#medical_patient_form_last_name').val());
      $('#medical_patient_form_secondary_insurance_relationship').val('Self');
      $('#medical_patient_form_secondary_insurance_birth_date').val($('#medical_patient_form_birth_date').val()).attr('disabled', true);
      $('#medical_patient_form_secondary_insurance_ssn_1').val($('#medical_patient_form_ssn_1').val());
      $('#medical_patient_form_secondary_insurance_ssn_2').val($('#medical_patient_form_ssn_2').val());
      $('#medical_patient_form_secondary_insurance_ssn_3').val($('#medical_patient_form_ssn_3').val());
      $('#medical_patient_form_secondary_insurance_policy_holder_employer').val($('#medical_patient_form_employer').val());
    }
  }

  function update_all_fields() {
    $('input[name=_method]').val('post');
    var params = $('.edit_medical_patient_form').serializeArray();
    $.post('/consumer/medical/medical_patient_form_all_fields_update', params, function () {
    });
    $('input[name=_method]').val('put');
  }


  // auto tab js
  // adding filter numeric
  $('#medical_patient_form_address_zip,#medical_patient_form_home_phone_1, #medical_patient_form_home_phone_2, #medical_patient_form_home_phone_3,' +
    '#medical_patient_form_work_phone_1, #medical_patient_form_work_phone_2, #medical_patient_form_work_phone_3,' +
    '#medical_patient_form_cell_phone_1, #medical_patient_form_cell_phone_2, #medical_patient_form_cell_phone_3,' +
    '#medical_patient_form_ssn_1, #medical_patient_form_ssn_2, #medical_patient_form_ssn_3,#medical_patient_form_employer_address_zip, #medical_patient_form_spouse_home_phone_1,' +
    '#medical_patient_form_spouse_home_phone_2, #medical_patient_form_spouse_home_phone_3, #medical_patient_form_spouse_work_phone_1,' +
    '#medical_patient_form_spouse_work_phone_2, #medical_patient_form_spouse_work_phone_3, #medical_patient_form_emergency_contact_phone_1,' +
    '#medical_patient_form_emergency_contact_phone_2, #medical_patient_form_emergency_contact_phone_3, #medical_patient_form_primary_insurance_address_zip, #medical_patient_form_primary_insurance_phone_1,' +
    '#medical_patient_form_primary_insurance_phone_2, #medical_patient_form_primary_insurance_phone_3, #medical_patient_form_primary_insurance_ssn_1,' +
    '#medical_patient_form_primary_insurance_ssn_2, #medical_patient_form_primary_insurance_ssn_3, #medical_patient_form_secondary_insurance_address_zip, #medical_patient_form_secondary_insurance_phone_1,' +
    '#medical_patient_form_secondary_insurance_phone_2, #medical_patient_form_secondary_insurance_phone_3, #medical_patient_form_secondary_insurance_ssn_1,' +
    '#medical_patient_form_secondary_insurance_ssn_2, #medical_patient_form_secondary_insurance_ssn_3, #medical_patient_form_social_history_no_of_children,' +
    '#medical_patient_form_family_history_illnesses_mother_age_at_diagnosis_1, #medical_patient_form_family_history_illnesses_mother_age_at_diagnosis_2, #medical_patient_form_family_history_illnesses_mother_age_at_diagnosis_3,' +
    '#medical_patient_form_family_history_illnesses_father_age_at_diagnosis_1, #medical_patient_form_family_history_illnesses_father_age_at_diagnosis_2, #medical_patient_form_family_history_illnesses_father_age_at_diagnosis_3,' +
    '#medical_patient_form_family_history_siblings_age_1, #medical_patient_form_family_history_siblings_age_2, #medical_patient_form_family_history_siblings_age_3,' +
    '#medical_patient_form_social_history_ex_minutes_per_day, #medical_patient_form_social_history_smoking_packs_per_day, #medical_patient_form_social_history_smoking_no_of_years,' +
    '#medical_patient_form_social_history_smoking_quit_years, #medical_patient_form_social_history_drink,#medical_patient_form_review_of_sym_i_have_many_pounds,#medical_patient_form_health_maintenance_total_cholesterol,' +
    '#medical_patient_form_health_maintenance_LDL, #medical_patient_form_health_maintenance_HDL, #medical_patient_form_health_maintenance_triglycerides').autotab_filter('numeric');

  // adding autotab magic

  $('#medical_patient_form_home_phone_1, #medical_patient_form_home_phone_2, #medical_patient_form_home_phone_3,' +
    '#medical_patient_form_work_phone_1, #medical_patient_form_work_phone_2, #medical_patient_form_work_phone_3,' +
    '#medical_patient_form_cell_phone_1, #medical_patient_form_cell_phone_2, #medical_patient_form_cell_phone_3, #medical_patient_form_sex_f').autotab_magic();

  $('#medical_patient_form_ssn_1, #medical_patient_form_ssn_2, #medical_patient_form_ssn_3').autotab_magic();

  $('#medical_patient_form_spouse_home_phone_1, #medical_patient_form_spouse_home_phone_2, #medical_patient_form_spouse_home_phone_3,' +
    '#medical_patient_form_spouse_work_phone_1, #medical_patient_form_spouse_work_phone_2, #medical_patient_form_spouse_work_phone_3').autotab_magic();

  $('#medical_patient_form_emergency_contact_phone_1, #medical_patient_form_emergency_contact_phone_2, #medical_patient_form_emergency_contact_phone_3').autotab_magic();

  $('#medical_patient_form_primary_insurance_phone_1, #medical_patient_form_primary_insurance_phone_2, #medical_patient_form_primary_insurance_phone_3, #medical_patient_form_primary_insurance_id').autotab_magic();

  $('#medical_patient_form_primary_insurance_ssn_1, #medical_patient_form_primary_insurance_ssn_2, #medical_patient_form_primary_insurance_ssn_3, #medical_patient_form_primary_insurance_policy_holder_employer').autotab_magic();

  $('#medical_patient_form_secondary_insurance_phone_1, #medical_patient_form_secondary_insurance_phone_2, #medical_patient_form_secondary_insurance_phone_3, #medical_patient_form_secondary_insurance_id').autotab_magic();

  $('#medical_patient_form_secondary_insurance_ssn_1, #medical_patient_form_secondary_insurance_ssn_2, #medical_patient_form_secondary_insurance_ssn_3, #medical_patient_form_secondary_insurance_policy_holder_employer').autotab_magic();


});