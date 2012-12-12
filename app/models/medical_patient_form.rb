class MedicalPatientForm < ActiveRecord::Base
  belongs_to :medical_appointment

  def self.capital_medical_clinic_generate_pdf(medical_patient_form, appointment)
    @medical_patient_form = medical_patient_form
    @appointment = appointment
    form_pdf_path = "#{CAPITAL_MEDICAL_CLINIC_FORM_PATH}"
    file_name = "#{@medical_patient_form.first_name.gsub(' ', '-')}_#{@medical_patient_form.last_name.gsub(' ', '-')}_capital_medical_clinic.pdf"
    permission_form_path = "#{PDFFILES_PATH}#{file_name}"
    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)

    if @medical_patient_form.birth_date
      @You_Age = Date.today.strftime('%Y%m%d').to_i - @medical_patient_form.birth_date.strftime('%Y%m%d').to_i
      @You_Age = @You_Age.to_s.split('')
    end
    # raise  Date.today.strftime('%Y%m%d').to_i.to_yaml
    @pdftk.fill_form(form_pdf_path, permission_form_path, {
      #Patient tab
      "FirstName" => @medical_patient_form.first_name,
      "LastName" => @medical_patient_form.last_name,
      "MiddleName" => @medical_patient_form.middle_name,
      "Address" => @medical_patient_form.address_1,
      "Address2" => @medical_patient_form.address_2,
      "City" => @medical_patient_form.address_city,
      "State" => @medical_patient_form.address_state,
      "ZipCode" => @medical_patient_form.address_zip,
      "HomePhoneNumber" => (@medical_patient_form.home_phone_1 ? (@medical_patient_form.home_phone_1.to_s + '-') : '' ) + (@medical_patient_form.home_phone_2 ? (@medical_patient_form.home_phone_2.to_s + '-') : '') + @medical_patient_form.home_phone_3.to_s,
      "WorkPhoneNumber" => (@medical_patient_form.work_phone_1 ? (@medical_patient_form.work_phone_1.to_s + '-') : '' ) + (@medical_patient_form.work_phone_2 ? (@medical_patient_form.work_phone_2.to_s + '-') : '') + @medical_patient_form.work_phone_3.to_s,
      "CellPhoneNumber" => (@medical_patient_form.cell_phone_1 ? (@medical_patient_form.cell_phone_1.to_s + '-') : '' ) + (@medical_patient_form.cell_phone_2 ? (@medical_patient_form.cell_phone_2.to_s + '-') : '') + @medical_patient_form.cell_phone_3.to_s,
      "Male" => @medical_patient_form.sex == 'Male' ? 'Yes' : 'No',
      "Female" => @medical_patient_form.sex == 'Female' ? 'Yes' : 'No',
      "Date" => @medical_patient_form.birth_date ? @medical_patient_form.birth_date.strftime('%m-%d-%Y') : '',
      "Age" => @You_Age ? @You_Age[0].to_s + @You_Age[1].to_s + 'Y' + ' ' + @You_Age[2].to_s + @You_Age[3].to_s + 'M' : '',
      "MaritalStatus" => @medical_patient_form.marital_status,
      "SocialSecurityNumber" => (@medical_patient_form.ssn_1 ? (@medical_patient_form.ssn_1.to_s + '-') : '') + (@medical_patient_form.ssn_2 ? (@medical_patient_form.ssn_2.to_s + '-') : '') + @medical_patient_form.ssn_3.to_s,
      "FamilyReferral" => @medical_patient_form.referred_to_our_office_by == 'Family' ? 'Yes' : 'No',
      "FriendReferral" => @medical_patient_form.referred_to_our_office_by == 'Friend' ? 'Yes' : 'No',
      "PhysicianReferral" => @medical_patient_form.referred_to_our_office_by == 'Physician' ? 'Yes' : 'No',
      "AdvertisementReferral" => @medical_patient_form.referred_to_our_office_by == 'Advertisement' ? 'Yes' : 'No',
      "WebsiteReferral" => @medical_patient_form.referred_to_our_office_by == 'Website' ? 'Yes' : 'No',

      #Employer tab
      "EmployerName" => @medical_patient_form.employer,
      "Occupation" => @medical_patient_form.employer_occupation,
      "EmployerAddress" => (@medical_patient_form.employer_address_1.empty? ? '' : (@medical_patient_form.employer_address_1.to_s + ', ')) + @medical_patient_form.employer_address_2.to_s,
      "EmployerCity" => @medical_patient_form.employer_address_city,
      "EmployerState" => @medical_patient_form.employer_address_state,
      "EmployerZip" => @medical_patient_form.employer_address_zip,

      #Spouse tab
      "SpouseName" => @medical_patient_form.spouse_first_name.to_s + ' ' + @medical_patient_form.spouse_last_name.to_s,
      "SpouseHomePhoneNumber" => (@medical_patient_form.spouse_home_phone_1 ? (@medical_patient_form.spouse_home_phone_1.to_s + '-') : '') + (@medical_patient_form.spouse_home_phone_2 ? (@medical_patient_form.spouse_home_phone_2.to_s + '-') : '') + @medical_patient_form.spouse_home_phone_3.to_s,
      "SpouseWorkPhoneNumber" => (@medical_patient_form.spouse_work_phone_1 ? (@medical_patient_form.spouse_work_phone_1.to_s + '-') : '') + (@medical_patient_form.spouse_work_phone_2 ? (@medical_patient_form.spouse_work_phone_2.to_s + '-') : '') + @medical_patient_form.spouse_work_phone_3.to_s,

      #Emergency Contact tab
      "EmergencyContact" => @medical_patient_form.emergency_contact_first_name.to_s + ' ' + @medical_patient_form.emergency_contact_last_name.to_s,
      "EmergencyContactRelationship" => @medical_patient_form.emergency_contact_relationship,
      "EmergencyContactPhoneNumber" => (@medical_patient_form.emergency_contact_phone_1 ? (@medical_patient_form.emergency_contact_phone_1.to_s + '-') :'') + (@medical_patient_form.emergency_contact_phone_2 ? (@medical_patient_form.emergency_contact_phone_2.to_s + '-') : '') + @medical_patient_form.emergency_contact_phone_3.to_s,

      #Primary Insurance tab
      "PrimaryInsuranceName" => @medical_patient_form.primary_insurance_company_name,
      "PrimaryInsuranceAddress" => (@medical_patient_form.primary_insurance_address_1.empty? ? '' : (@medical_patient_form.primary_insurance_address_1.to_s + ', ')) + (@medical_patient_form.primary_insurance_address_2.empty? ? '' : (@medical_patient_form.primary_insurance_address_2.to_s + ', ')) + @medical_patient_form.primary_insurance_address_city.to_s ,
      "PrimaryInsuranceStateZip" => @medical_patient_formprimary_insurance_address_state.to_s + ' ' + @medical_patient_form.primary_insurance_address_zip.to_s,
      "PrimaryInsurancePhone" => (@medical_patient_form.primary_insurance_phone_1 ? (@medical_patient_form.primary_insurance_phone_1.to_s + '-') : '') + (@medical_patient_form.primary_insurance_phone_2 ? (@medical_patient_form.primary_insurance_phone_2.to_s + '-') : '') + @medical_patient_form.primary_insurance_phone_3.to_s,
      "PrimaryInsuranceID" => @medical_patient_form.primary_insurance_id,
      "PrimaryInsuranceGroup" => @medical_patient_form.primary_insurance_group,
      "PrimaryInsurancePolicyHolderEmployer" => @medical_patient_form.primary_insurance_policy_holder_employer,
      "PrimaryInsurancePolicyHolderDateofBirth" => @medical_patient_form.primary_insurance_birth_date.strftime('%m-%d-%Y'),
      "PrimaryInsurancePolicyHolderRelationship" => @medical_patient_form.primary_insurance_relationship,
      "PrimaryInsurancePolicyHolderName" => @medical_patient_form.primary_insurance_policy_holder_first_name.to_s + ' ' + @medical_patient_form.primary_insurance_policy_holder_last_name.to_s,
      "PrimaryInsurancePolicyHolderSocialSecurityNumber" => (@medical_patient_form.primary_insurance_ssn_1 ? (@medical_patient_form.primary_insurance_ssn_1.to_s + '-') : '') + (@medical_patient_form.primary_insurance_ssn_2 ? (@medical_patient_form.primary_insurance_ssn_2.to_s + '-') :'') + @medical_patient_form.primary_insurance_ssn_3.to_s,

      #Secondary Insurance tab
      "SecondaryInsuranceName" => @medical_patient_form.secondary_insurance_company_name,
      "SecondaryInsuranceAddress" => (@medical_patient_form.secondary_insurance_address_1.empty? ? '' : (@medical_patient_form.secondary_insurance_address_1.to_s + ', ')) + (@medical_patient_form.secondary_insurance_address_2.empty? ? '' : (@medical_patient_form.secondary_insurance_address_2.to_s + ', ')) + @medical_patient_form.secondary_insurance_address_city.to_s,
      "SecondaryInsuranceStateZip" => @medical_patient_form.secondary_insurance_address_state.to_s + ' ' + @medical_patient_form.secondary_insurance_address_zip.to_s,
      "SecondaryInsurancePhoneNumber" => (@medical_patient_form.secondary_insurance_phone_1 ? (@medical_patient_form.secondary_insurance_phone_1.to_s + '-') : '') + (@medical_patient_form.secondary_insurance_phone_2 ? (@medical_patient_form.secondary_insurance_phone_2.to_s + '-') : '') + @medical_patient_form.secondary_insurance_phone_3.to_s,
      "SecondaryInsuranceID" => @medical_patient_form.secondary_insurance_id,
      "SecondaryInsuranceGroup" => @medical_patient_form.secondary_insurance_group,
      "SecondaryInsurancePolicyHolderEmployer" => @medical_patient_form.secondary_insurance_policy_holder_employer,
      "SecondaryInsurancePolicyHolderDateofBirth" => @medical_patient_form.secondary_insurance_birth_date.strftime('%m-%d-%Y'),
      "SecondaryInsurancePolicyHolderRelationship" => @medical_patient_form.secondary_insurance_relationship,
      "SecondaryInsurancePolicyHolderName" => @medical_patient_form.secondary_insurance_policy_holder_first_name.to_s + ' ' + @medical_patient_form.secondary_insurance_policy_holder_last_name.to_s,
      "SecondaryInsurancePolicyHolderSocialSecurityNumber" => (@medical_patient_form.secondary_insurance_ssn_1 ? (@medical_patient_form.secondary_insurance_ssn_1.to_s + '-') : '') + (@medical_patient_form.secondary_insurance_ssn_2 ? (@medical_patient_form.secondary_insurance_ssn_2.to_s + '-') : '') + @medical_patient_form.secondary_insurance_ssn_3.to_s,

      #Patient Consent tab
      "ConsentToSharePersonalHealthInformationName1" => @medical_patient_form.patient_consent_first_name_1.to_s + ' ' + @medical_patient_form.patient_consent_last_name_1.to_s,
      "ConsentToSharePersonalHealthInformationName2" => @medical_patient_form.patient_consent_first_name_2.to_s + ' ' + @medical_patient_form.patient_consent_last_name_2.to_s,
      "ConsentToSharePersonalHealthInformationName3" => @medical_patient_form.patient_consent_first_name_3.to_s + ' ' + @medical_patient_form.patient_consent_last_name_3.to_s,
      "ConsentToSharePersonalHealthInformationName1RelationshiptoPatient" => @medical_patient_form.patient_consent_relation_ship_to_patient_1,
      "ConsentToSharePersonalHealthInformationName2RelationshiptoPatient" => @medical_patient_form.patient_consent_relation_ship_to_patient_2,
      "ConsentToSharePersonalHealthInformationName3RelationshiptoPatient" => @medical_patient_form.patient_consent_relation_ship_to_patient_3,
      "Name" => @medical_patient_form.first_name.to_s + ' ' + @medical_patient_form.last_name.to_s,
      "Referredby" => @medical_patient_form.referral_name,
      "DateofBirth" => @medical_patient_form.birth_date.strftime('%m-%d-%Y'),
      "DateofExam" => @appointment.appointment_date_time.strftime('%m-%d-%Y'),

      #medical History tab
      "ReasonForVisit" => @medical_patient_form.medical_history_reason_for_visit_1,
      "ReasonForVisit2" => @medical_patient_form.medical_history_reason_for_visit_2,
      "ReasonForVisit3" => @medical_patient_form.medical_history_reason_for_visit_2,

      "NameandTypeofSpecialist1" => @medical_patient_form.medical_history_specialist_1.to_s + ' ' + @medical_patient_form.medical_history_speciality_1.to_s,
      "NameandTypeofSpecialist2" => @medical_patient_form.medical_history_specialist_2.to_s + ' ' + @medical_patient_form.medical_history_speciality_2.to_s,
      "NameandTypeofSpecialist3" => @medical_patient_form.medical_history_specialist_3.to_s + ' ' + @medical_patient_form.medical_history_speciality_3.to_s,
      "NameandTypeofSpecialist4" => @medical_patient_form.medical_history_specialist_4.to_s + ' ' + @medical_patient_form.medical_history_speciality_4.to_s,

      "MedicationDosageTimesPerDaya" => @medical_patient_form.medical_history_medication_medication_1.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_1.to_s + ' ' + @medical_patient_form.medical_history_medication_times_per_day_1.to_s,
      "MedicationDosageTimesPerDayb" => @medical_patient_form.medical_history_medication_medication_2.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_2.to_s + ' ' + @medical_patient_form.medical_history_medication_times_per_day_2.to_s,
      "MedicationDosageTimesPerDayc" => @medical_patient_form.medical_history_medication_medication_3.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_3.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_3.to_s,
      "MedicationDosageTimesPerDayd" => @medical_patient_form.medical_history_medication_medication_4.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_4.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_4.to_s,
      "MedicationDosageTimesPerDaye" => @medical_patient_form.medical_history_medication_medication_5.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_5.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_5.to_s,
      "MedicationDosageTimesPerDayf" => @medical_patient_form.medical_history_medication_medication_6.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_6.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_6.to_s,
      "MedicationDosageTimesPerDayg" => @medical_patient_form.medical_history_medication_medication_7.to_s + ' ' + @medical_patient_form.medical_history_medication_dosage_7.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_7.to_s,

      "MedicationAllergyReactionA" => @medical_patient_form.medical_history_medication_allergies_medication_1.to_s + ' ' + @medical_patient_form.medical_history_medication_allergies_reaction_1.to_s,
      "MedicationAllergyReactionB" => @medical_patient_form.medical_history_medication_allergies_medication_2.to_s + ' ' + @medical_patient_form.medical_history_medication_allergies_reaction_2.to_s,
      "MedicationAllergyReactionC" => @medical_patient_form.medical_history_medication_allergies_medication_3.to_s + ' ' + @medical_patient_form.medical_history_medication_allergies_reaction_3.to_s,

      "OpeartionAndDateA" => @medical_patient_form.medical_history_operations_operation_1.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_1.strftime('%m-%d-%Y').to_s,
      "OpeartionAndDateB" => @medical_patient_form.medical_history_operations_operation_2.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_2.strftime('%m-%d-%Y').to_s,
      "OpeartionAndDateC" => @medical_patient_form.medical_history_operations_operation_3.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_3.strftime('%m-%d-%Y').to_s,
      "OpeartionAndDateD" => @medical_patient_form.medical_history_operations_operation_4.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_4.strftime('%m-%d-%Y').to_s,
      "OpeartionAndDateE" => @medical_patient_form.medical_history_operations_operation_5.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_5.strftime('%m-%d-%Y').to_s,
      "OpeartionAndDateF" => @medical_patient_form.medical_history_operations_operation_6.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_6.strftime('%m-%d-%Y').to_s,

      "IllnessAndDiagnosisDateA" => @medical_patient_form.medical_history_previous_illnesses_illness_1.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_1.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateB" => @medical_patient_form.medical_history_previous_illnesses_illness_2.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_2.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateC" => @medical_patient_form.medical_history_previous_illnesses_illness_3.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_3.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateD" => @medical_patient_form.medical_history_previous_illnesses_illness_4.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_4.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateE" => @medical_patient_form.medical_history_previous_illnesses_illness_5.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_5.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateF" => @medical_patient_form.medical_history_previous_illnesses_illness_6.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_6.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateG" => @medical_patient_form.medical_history_previous_illnesses_illness_7.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_7.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateH" => @medical_patient_form.medical_history_previous_illnesses_illness_8.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_8.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateI" => @medical_patient_form.medical_history_previous_illnesses_illness_9.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_9.strftime('%m-%d-%Y').to_s,
      "IllnessAndDiagnosisDateJ" => @medical_patient_form.medical_history_previous_illnesses_illness_10.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_10.strftime('%m-%d-%Y').to_s,

      #Family History Tab
      "MotherLiving" => @medical_patient_form.family_history_mother_living_or_deceased == 'Living' ? 'Yes' : 'No',
      "MotherDeceased" => @medical_patient_form.family_history_mother_living_or_deceased == 'Deceased' ? 'Yes' : 'No',
      "MotherAgeDeceased" => @medical_patient_form.family_history_mother_age,
      "MotherIllnessAgeAtDiagnosisA" => @medical_patient_form.family_history_illnesses_mother_illness_1.to_s + ' ' + @medical_patient_form.family_history_illnesses_mother_age_at_diagnosis_1.to_s,
      "MotherIllnessAgeAtDiagnosisB" => @medical_patient_form.family_history_illnesses_mother_illness_2.to_s + ' ' + @medical_patient_form.family_history_illnesses_mother_age_at_diagnosis_2.to_s,
      "MotherIllnessAgeAtDiagnosisC" => @medical_patient_form.family_history_illnesses_mother_illness_3.to_s + ' ' + @medical_patient_form.family_history_illnesses_mother_age_at_diagnosis_3.to_s,

      "FatherLiving" => @medical_patient_form.family_history_father_living_or_deceased == 'Living' ? 'Yes' : 'No',
      "FatherrDeceased" => @medical_patient_form.family_history_father_living_or_deceased == 'Deceased' ? 'Yes' : 'No',
      "FatherAgeDeceased" => @medical_patient_form.family_history_father_age,
      "FatherIllnessAgeAtDiagnosisA" => @medical_patient_form.family_history_illnesses_father_illness_1.to_s + ' ' + @medical_patient_form.family_history_illnesses_father_age_at_diagnosis_1.to_s,
      "FatherIllnessAgeAtDiagnosisB" => @medical_patient_form.family_history_illnesses_father_illness_2.to_s + ' ' + @medical_patient_form.family_history_illnesses_father_age_at_diagnosis_2.to_s,
      "FatherIllnessAgeAtDiagnosisC" => @medical_patient_form.family_history_illnesses_father_illness_3.to_s + ' ' + @medical_patient_form.family_history_illnesses_father_age_at_diagnosis_3.to_s,

      "Sibling1Sister" => @medical_patient_form.family_history_siblings_1 == 'Sister' ? 'Yes' : 'No',
      "Sibling1Brother" => @medical_patient_form.family_history_siblings_1 == 'Brother' ? 'Yes' : 'NO',
      "Sibling2Sister" => @medical_patient_form.family_history_siblings_2 == 'Sister' ? 'Yes' : 'No',
      "Sibling2Brother" => @medical_patient_form.family_history_siblings_2 == 'Brother' ? 'Yes' : 'No',
      "Sibling3Sister" => @medical_patient_form.family_history_siblings_3 == 'Sister' ? 'Yes' : 'No',
      "Sibling3Brother" => @medical_patient_form.family_history_siblings_3 == 'Brother' ? 'Yes' : 'No',
      "Sibling1Living" => @medical_patient_form.family_history_siblings_living_deceased_1 == 'Living' ? 'Yes' : 'No',
      "Sibling2Living" => @medical_patient_form.family_history_siblings_living_deceased_2 == 'Living' ? 'Yes' : 'No',
      "Sibling3Living" => @medical_patient_form.family_history_siblings_living_deceased_3 == 'Living' ? 'Yes' : 'No',

      "Sibling1Deceased" => @medical_patient_form.family_history_siblings_living_deceased_1 == 'Deceased' ? 'Yes' : 'No',
      "Sibling2Deceased" => @medical_patient_form.family_history_siblings_living_deceased_2 == 'Deceased' ? 'Yes' : 'No',
      "Sibling3Deceased" => @medical_patient_form.family_history_siblings_living_deceased_3 == 'Deceased' ? 'Yes' : 'No',
      "Sibling1AgeDeceased" => @medical_patient_form.family_history_siblings_age_1,
      "Sibling2AgeDeceased" => @medical_patient_form.family_history_siblings_age_2,
      "Sibling3AgeDeceased" => @medical_patient_form.family_history_siblings_age_3,

      "Sibling1IllnessAgeAtDiagnosisA" => @medical_patient_form.family_history_siblings_1_illness_1,
      "Sibling1IllnessAgeAtDiagnosisB" => @medical_patient_form.family_history_siblings_1_illness_2,
      "Sibling2IllnessAgeAtDiagnosisA" => @medical_patient_form.family_history_siblings_2_illness_1,
      "Sibling2IllnessAgeAtDiagnosisB" => @medical_patient_form.family_history_siblings_2_illness_2,
      "Sibling3IllnessAgeAtDiagnosisA" => @medical_patient_form.family_history_siblings_3_illness_1,
      "Sibling3IllnessAgeAtDiagnosisB" => @medical_patient_form.family_history_siblings_3_illness_2,

      #Social History Tab
      "Married" => @medical_patient_form.marital_status == 'Married' ? 'Yes' : 'No',
      "Partnered" => @medical_patient_form.marital_status == 'Partnered' ? 'Yes' : 'No',
      "Single" => @medical_patient_form.marital_status == 'Single' ? 'Yes' : 'No',
      "Widowed" => @medical_patient_form.marital_status == 'Widowed' ? 'Yes' : 'No',
      "LiveAlone" => @medical_patient_form.social_history_live == 'Alone' ? 'Yes' : '',
      "LiveWithOthers" => @medical_patient_form.social_history_live == 'With Other(s)' ? 'Yes' : 'No',
      "LiveWithWhom" => @medical_patient_form.social_history_live == 'With Other(s)' ? @medical_patient_form.social_history_live_with_whom : '',
      "ChildrenYes" => @medical_patient_form.social_history_no_of_children ? (@medical_patient_form.social_history_no_of_children > 0 ? 'Yes' : 'No') : '',
      "ChildrenNo" => @medical_patient_form.social_history_no_of_children ? (@medical_patient_form.social_history_no_of_children > 0 || !@medical_patient_form.social_history_no_of_children.nil? ? 'No' : 'Yes') : '',
      "NumberOfChildren" => @medical_patient_form.social_history_no_of_children ? (@medical_patient_form.social_history_no_of_children > 0 ? @medical_patient_form.social_history_no_of_children : '') : '',
      "AgesOfChildren" => @medical_patient_form.social_history_age_of_children,
      "ExerciseNumberOfDaysPerWeek" => @medical_patient_form.social_history_exercise_approximately,
      "ExerciseHowLongPerSession" => @medical_patient_form.social_history_ex_minutes_per_day,
      "ExerciseTypeOfExercise" => @medical_patient_form.social_history_exercise_type,
      "Hobbies" => @medical_patient_form.social_history_hobbies,
      "HaveYouEverSmokedTobaccoYes" => @medical_patient_form.social_history_smoking_tobacco ? (@medical_patient_form.social_history_smoking_tobacco != "Never" ? 'Yes' : 'No') : '',
      "HaveYouEverSmokedTobaccoNo" => @medical_patient_form.social_history_smoking_tobacco ? (@medical_patient_form.social_history_smoking_tobacco == "Never" ? 'Yes' : 'No') : '',
      "TobaccoPacksPerDayNow" => @medical_patient_form.social_history_smoking_tobacco == "I smoke now" ? @medical_patient_form.social_history_smoking_packs_per_day : '',
      "TobaccoNumberOfYearsNow" => @medical_patient_form.social_history_smoking_tobacco == "I smoke now" ? @medical_patient_form.social_history_smoking_no_of_years : '',
      "TobaccoPacksPerDayPreviously" => @medical_patient_form.social_history_smoking_tobacco == "I did, but I quit" ? @medical_patient_form.social_history_smoking_packs_per_day : '',
      "TobaccoNumberOfYearsPreviously" => @medical_patient_form.social_history_smoking_tobacco == "I did, but I quit" ? @medical_patient_form.social_history_smoking_no_of_years : '',
      "SmokeTobaccoNowYes" => @medical_patient_form.social_history_smoking_tobacco ? (@medical_patient_form.social_history_smoking_tobacco == "I smoke now" ? 'Yes' : 'No') : '',
      "SmokeTobaccoNowNo" => @medical_patient_form.social_history_smoking_tobacco ? (@medical_patient_form.social_history_smoking_tobacco != "I smoke now" ? 'Yes' : 'No') : '',
      "WhatYearDidYouQuitSmoking" => @medical_patient_form.social_history_smoking_quit_years,
      "DrinkAlcoholYes" => @medical_patient_form.social_history_drink ? (@medical_patient_form.social_history_drink > 0 ? 'Yes' : 'No') : '',
      "DrinkAlcoholNo" => @medical_patient_form.social_history_drink ? (@medical_patient_form.social_history_drink > 0 || !@medical_patient_form.social_history_drink.nil? ? '' : 'Yes') : 'No',
      "BeveragesPerDay" => @medical_patient_form.social_history_drink ? (@medical_patient_form.social_history_drink > 0 && @medical_patient_form.social_history_drink_alcoholic_beverage == 'Day' ? @medical_patient_form.social_history_drink : '') : '',
      "BeveragesPerWeek" => @medical_patient_form.social_history_drink ? (@medical_patient_form.social_history_drink > 0 && @medical_patient_form.social_history_drink_alcoholic_beverage == 'Week' ? @medical_patient_form.social_history_drink : '') : '',
      "HaveYouEverUsedRecreationalDrugsYes" => @medical_patient_form.social_history_have_used_recreational_drugs == 'Yes' ? 'Yes' : 'No',
      "HaveYouEverUsedRecreationalDrugsNo" => @medical_patient_form.social_history_have_used_recreational_drugs == 'No' ? 'Yes' : 'No',
      "RecreationalDrugsUsed" => @medical_patient_form.social_history_yes_i_have_used_recreational_drugs,
      "HaveYouRecentlyTraveledOutsideOfTheCountryYes" => @medical_patient_form.social_history_have_recently_traveled == 'Yes' ? 'Yes' : 'No',
      "HaveYouRecentlyTraveledOutsideOfTheCountryNo" => @medical_patient_form.social_history_have_recently_traveled == 'No' ? 'Yes' : 'No',
      "WhereHaveYouRecentlyTraveledOutsideOfTheCountry" => @medical_patient_form.social_history_yes_i_recently_traveled,

      #Review Of System

      "Fatigue" => @medical_patient_form.review_of_sym_general_fatigue ? 'Yes' : 'No',
      "Fever" => @medical_patient_form.review_of_sym_general_fever ? 'Yes' : 'No',
      "NightSweats" => @medical_patient_form.review_of_sym_general_night_sweats ? 'Yes' : 'No',
      "HeatOrColdIntolerance" => @medical_patient_form.review_of_sym_general_heat_or_cold ? 'Yes' : 'No',

      "WeightGainHowMuch" => @medical_patient_form.review_of_sym_i_have == 'Gained' ? @medical_patient_form.review_of_sym_i_have_many_pounds : '',
      "WeightGainOverHowLong" => @medical_patient_form.review_of_sym_i_have == 'Gained' ? @medical_patient_form.review_of_sym_i_have_time_periods : '',
      "WeightLossHowMuch" => @medical_patient_form.review_of_sym_i_have == 'Loss' ? @medical_patient_form.review_of_sym_i_have_many_pounds : '',
      "WeightLossOverHowLong" => @medical_patient_form.review_of_sym_i_have == 'Loss' ? @medical_patient_form.review_of_sym_i_have_time_periods : '',

      "Rash" => @medical_patient_form.review_of_sym_skin_rash ? 'Yes' : 'No',
      "HairLoss" => @medical_patient_form.review_of_sym_skin_hair_loss ? 'Yes' : 'No',
      "EasyBruising" => @medical_patient_form.review_of_sym_skin_easy_bruising ? 'Yes' : 'No',
      "ToenailInfection" => @medical_patient_form.review_of_sym_skin_toenail_inflection ? 'Yes' : 'No',

      "Redness" => @medical_patient_form.review_of_sym_eye_redness ? 'Yes' : 'No',
      "Pain" => @medical_patient_form.review_of_sym_eye_pain ? 'Yes' : 'No',
      "Discharge" => @medical_patient_form.review_of_sym_eye_discharge ? 'Yes' : 'No',
      "Dryness" => @medical_patient_form.review_of_sym_eye_dryness ? 'Yes' : 'No',
      "VisualChanges" => @medical_patient_form.review_of_sym_eye_visual_changes ? 'Yes' : 'No',

      "NoseBleed" => @medical_patient_form.review_of_sym_nose_bleed ? 'Yes' : 'No',
      "NasalDischargeOrDraining" => @medical_patient_form.review_of_sym_nose_nasal_discharge ? 'Yes' : 'No',
      "SinusPain" => @medical_patient_form.review_of_sym_nose_sinus_pain ? 'Yes' : 'No',
      "SinusCongestion" => @medical_patient_form.review_of_sym_nose_sinus_congestion ? 'Yes' : 'No',

      "OralLesions" => @medical_patient_form.review_of_sym_mouth_oral_lesions ? 'Yes' : 'No',
      "WhitePatches" => @medical_patient_form.review_of_sym_mouth_white_patches ? 'Yes' : 'No',
      "BleedingGums" => @medical_patient_form.review_of_sym_mouth_white_patches ? 'Yes' : 'No',
      "Toothache" => @medical_patient_form.review_of_sym_mouth_white_patches ? 'Yes' : 'No',

      "Hoarseness" => @medical_patient_form.review_of_sym_throat_hoarseness ? 'Yes' : 'No',
      "SoreThroat" => @medical_patient_form.review_of_sym_throat_sore_throat ? 'Yes' : 'No',
      "PainWithSwallowing" => @medical_patient_form.review_of_sym_throat_pain_with_swallowing ? 'Yes' : 'No',
      "DifficultySwallowing" => @medical_patient_form.review_of_sym_throat_difficultly_swallowing ? 'Yes' : 'No',

      "Cough" => @medical_patient_form.review_of_sym_respiratory_cough ? 'Yes' : 'No',
      "CoughingBlood" => @medical_patient_form.review_of_sym_respiratory_coughing_blood ? 'Yes' : 'No',
      "ShortnessOfBreathAtRest" => @medical_patient_form.review_of_sym_respiratory_shortness_of_breath_at_rest ? 'Yes' : 'No',
      "ShortnessOfBreathOnExertion" => @medical_patient_form.review_of_sym_respiratory_shortness_of_breath_on_exertion ? 'Yes' : 'No',
      "Wheezing" => @medical_patient_form.review_of_sym_respiratory_wheezing ? 'Yes' : 'No',

      "ChestDiscomfort" => @medical_patient_form.review_of_sym_cardiovascular_chest_discomfort ? 'Yes' : 'No',
      "Palpitations" => @medical_patient_form.review_of_sym_cardiovascular_palpitations ? 'Yes' : 'No',
      "AnkleSwelling" => @medical_patient_form.review_of_sym_cardiovascular_ankle_swelling ? 'Yes' : 'No',
      "FastHeartBeat" => @medical_patient_form.review_of_sym_cardiovascular_fast_heart_beat ? 'Yes' : 'No',
      "DifficultyBreathingWhenLyingDown" => @medical_patient_form.review_of_sym_cardiovascular_difficulty_breathing ? 'Yes' : 'No',
      "AwakeningShortOfBreath" => @medical_patient_form.review_of_sym_cardiovascular_awakening_short_of_breath ? 'Yes' : 'No',

      "PainWithUrination" => @medical_patient_form.review_of_sym_urinary_pain_with_urination ? 'Yes' : 'No',
      "UrinatingFrequently" => @medical_patient_form.review_of_sym_urinary_urinating_frequently ? 'Yes' : 'No',
      "Incontinence" => @medical_patient_form.review_of_sym_urinary_incontinence ? 'Yes' : 'No',
      "UrinatingBeforeYouCanGetToTheBathroom" => @medical_patient_form.review_of_sym_urinary_urinating_before_bathroom ? 'Yes' : 'No',
      "UrinationAtNight" => @medical_patient_form.review_of_sym_urinary_urination_at_night ? 'Yes' : 'No',
      "DifficultyStartingAUrineStream" => @medical_patient_form.review_of_sym_urinary_difficulty_starting_a_urine_stream ? 'Yes' : 'No',
      "BloodInUrine" => @medical_patient_form.review_of_sym_urinary_blood_in_urine ? 'Yes' : 'No',

      "NauseOrVomiting" => @medical_patient_form.review_of_sym_gastrointestinal_nausea ? 'Yes' : 'No',
      "Diarrhea" => @medical_patient_form.review_of_sym_gastrointestinal_diarrhea ? 'Yes' : 'No',
      "BloodInTheStool" => @medical_patient_form.review_of_sym_gastrointestinal_blood_in_the_stool ? 'Yes' : 'No',
      "BlackTarryStool" => @medical_patient_form.review_of_sym_gastrointestinal_black_tarry_stool ? 'Yes' : 'No',
      "HeartburnReflux" => @medical_patient_form.review_of_sym_gastrointestinal_heartburn ? 'Yes' : 'No',
      "Constipation" => @medical_patient_form.review_of_sym_gastrointestinal_constipation ? 'Yes' : 'No',

      "DecreasedLibido" => @medical_patient_form.review_of_sym_sexual_decreased_libido ? 'Yes' : 'No',
      "DifficultyAchievingAndMaintainingAnErection" => @medical_patient_form.review_of_sym_sexual_difficulty_achieving_and_maintaining ? 'Yes' : 'No',

      "JointPainOrStiffness" => @medical_patient_form.review_of_sym_musculoskeletal_joint_pain_or_stiffness ? 'Yes' : 'No',
      "JointPainOrStiffnessWhichJoints" => @medical_patient_form.review_of_sym_joints_that_are_painful_or_stiff,
      "JointSwellingOrRedness" => @medical_patient_form.review_of_sym_musculoskeletal_joint_swelling_or_redness ? 'Yes' : 'No',
      "JointSwellingOrRednessWhichJoints" => @medical_patient_form.review_of_sym_joints_that_are_swelling_or_have_redness,
      "BackPain" => @medical_patient_form.review_of_sym_musculoskeletal_back_pain ? 'Yes' : 'No',
      "MusclePain" => @medical_patient_form.review_of_sym_musculoskeletal_muscle_pain ? 'Yes' : 'No',

      "DifficultyWithMemory" => @medical_patient_form.review_of_sym_neurological_difficulty_with_memory ? 'Yes' : 'No',
      "FaintingLosingConsciousness" => @medical_patient_form.review_of_sym_neurological_fainting ? 'Yes' : 'No',
      "Weakness:" => @medical_patient_form.review_of_sym_neurological_weakness ? 'Yes' : 'No',
      "WeaknessWhichPartOfYourBody" => @medical_patient_form.review_of_sym_neurological_weakness_which_part_of_body,
      "Seizures" => @medical_patient_form.review_of_sym_neurological_muscle_painSeizures ? 'Yes' : 'No',
      "SevereOrFrequentHeadaches" => @medical_patient_form.review_of_sym_neurological_severe_or_frequent_headaches ? 'Yes' : 'No',
      "DifficultyWithBalance" => @medical_patient_form.review_of_sym_neurological_difficulty_with_balance ? 'Yes' : 'No',
      "DifficultyWalking" => @medical_patient_form.review_of_sym_neurological_difficulty_walking ? 'Yes' : 'No',
      "Lightheadedness" => @medical_patient_form.review_of_sym_neurological_lightheadedness ? 'Yes' : 'No',
      "Vertigo" => @medical_patient_form.review_of_sym_neurological_vertigo ? 'Yes' : 'No',

      "Depression" => @medical_patient_form.review_of_sym_psychological_depression ? 'Yes' : 'No',
      "LackOfInterest" => @medical_patient_form.review_of_sym_psychological_lack_of_interest ? 'Yes' : 'No',
      "DecreasedSenseOfSelfWorth" => @medical_patient_form.review_of_sym_psychological_decreased_sense_of_self_worth ? 'Yes' : 'No',
      "DifficultyFocusingAndConcentrating" => @medical_patient_form.review_of_sym_psychological_difficulty_focusing ? 'Yes' : 'No',
      "DesireToEndYourLife" => @medical_patient_form.review_of_sym_psychological_desire_to_end_your_life ? 'Yes' : 'No',
      "DisablingAnxiety" => @medical_patient_form.review_of_sym_psychological_disabling_anxiety ? 'Yes' : 'No',
      "PanicAttacks" => @medical_patient_form.review_of_sym_psychological_panic_attacks ? 'Yes' : 'No',


      "DifficultyGettingToSleep" => @medical_patient_form.review_of_sym_sleep_difficulty_getting_to_sleep ? 'Yes' : 'No',
      "DifficultyStayingAsleep" => @medical_patient_form.review_of_sym_sleep_difficulty_difficulty_staying_asleep ? 'Yes' : 'No',
      "Snoring" => @medical_patient_form.review_of_sym_sleep_difficulty_snoring ? 'Yes' : 'No',
      "CessationOfBreathingDuringSleep" => @medical_patient_form.review_of_sym_sleep_difficulty_cessation_of_breathing ? 'Yes' : 'No',

      #Helth Maintainance Tab
      "HaveYouHadABoneDensityTest" => @medical_patient_form.health_maintenance_bone_density_test ? (@medical_patient_form.health_maintenance_bone_density_test ? 'Yes' : 'No') : '',
      "LastBoneDensityTestDate" => @medical_patient_form.health_maintenance_bone_density_test.strftime('%m-%d-%Y'),
      "HaveYouHadASkinCancerScreeningCheckedByADermatologistNo" => @medical_patient_form.health_maintenance_skin_cancer_screening ? (@medical_patient_form.health_maintenance_skin_cancer_screening ? 'No' : 'Yes') : '',
      "HaveYouHadASkinCancerScreeningCheckedByADermatologistYes" => @medical_patient_form.health_maintenance_skin_cancer_screening ? (@medical_patient_form.health_maintenance_skin_cancer_screening ? 'Yes' : 'No') : '',
      "SkinCancerScreeningCheckDate" => @medical_patient_form.health_maintenance_skin_cancer_screening.strftime('%m-%d-%Y'),

      "CholesterolTestDate" => @medical_patient_form.health_maintenance_test_date.strftime('%m-%d-%Y'),
      "CholesterolTestTotalCholesterol" => @medical_patient_form.health_maintenance_total_cholesterol,
      "CholesterolTestLDL" => @medical_patient_form.health_maintenance_LDL,
      "CholesterolTestHDL" => @medical_patient_form.health_maintenance_HDL,
      "CholesterolTestTriglycerides" => @medical_patient_form.health_maintenance_triglycerides,

      "TetanusVaccineBoosterDate" => @medical_patient_form.health_maintenance_most_recent_tetanus_vaccine_booster.strftime('%m-%d-%Y'),
      "HaveYouReceivedShinglesVaccine" => @medical_patient_form.health_maintenance_shingles_vaccine ? (@medical_patient_form.health_maintenance_shingles_vaccine ? 'Yes' : 'No') : '',
      "PneumovaxVaccineDate" => @medical_patient_form.health_maintenance_pneumovax.strftime('%m-%d-%Y'),
      "HaveYouReceivedPneumovasVaccine" => @medical_patient_form.health_maintenance_pneumovax ? (@medical_patient_form.health_maintenance_pneumovax ? 'Yes' : 'No') : '',
      "HaveYouReceivedTheFluVaccine" => @medical_patient_form.health_maintenance_flu_vaccine ? 'Yes' : 'No',

      "HaveYouHadAColonoscopy" => @medical_patient_form.health_maintenance_colonoscopy ? 'Yes' : 'No',
      "LastColonoscopyDate" => @medical_patient_form.health_maintenance_colonoscopy.strftime('%m-%d-%Y'),
      "WasYourColonoscopyNormal" => @medical_patient_form.health_maintenance_colonoscopy_test_results ? (@medical_patient_form.health_maintenance_colonoscopy_test_results == "Normal" ? 'Yes' : 'No') : '',
      "IfColonoscopyWasAbnormalWhatWasFound" => @medical_patient_form.health_maintenance_colonoscopy_test_results == "Abnormal" ? @medical_patient_form.health_maintenance_description_of_abnormal_test_results : '',

      "WhenWasYourLastMammogram" => @medical_patient_form.health_maintenance_most_recent_mammogram,
      "WhenWasYourLastPapSmear" => @medical_patient_form.health_maintenance_most_recent_pap_smear,
      "HaveYouEverHadAnAbnormalPapSmearYes" => @medical_patient_form.health_maintenance_abnormal_pap_smear ? (@medical_patient_form.health_maintenance_abnormal_pap_smear ? 'Yes' : 'No') : '',
      "HaveYouEverHadAnAbnormalPapSmearNo" => @medical_patient_form.health_maintenance_abnormal_pap_smear ? (@medical_patient_form.health_maintenance_abnormal_pap_smear ? 'No' : 'Yes') : '',
      "AbnormalPapSmearDate" => @medical_patient_form.health_maintenance_abnormal_pap_smear.strftime('%m-%d-%Y'),
      "HaveYouHadAHysterectomyYes" => @medical_patient_form.health_maintenance_hysterectomy ? (@medical_patient_form.health_maintenance_hysterectomy ? 'Yes' : 'No') : '',
      "HaveYouHadAHysterectomyNo" => @medical_patient_form.health_maintenance_hysterectomy ? (@medical_patient_form.health_maintenance_hysterectomy ? 'No' : 'Yes') : '',
      "HysterectomyDate" => @medical_patient_form.health_maintenance_hysterectomy.strftime('%m-%d-%Y'),
      "HysterectomyReason" => @medical_patient_form.health_maintenance_why_was_hysterectomy_performed,

      "WhenDidYouHaveYourLastDigitalRectalExamAndPSAChecked" => @medical_patient_form.health_maintenance_digital_rectal_exam_and_psa_checked
    })
   # raise @pdftk.fields(form_pdf_path).to_yaml
  end

end
