class MedicalPatientForm < ActiveRecord::Base
  belongs_to :medical_appointment

  def self.capital_medical_clinic_generate_pdf(medical_patient_form, appointment)
    @medical_patient_form = medical_patient_form
    @appointment = appointment
    form_pdf_path = "#{CAPITAL_MEDICAL_CLINIC_PATH}"
    file_name = "#{@medical_patient_form.first_name.gsub(' ', '-')}_#{@medical_patient_form.first_name.gsub(' ', '-')}_capital_medical_clinic"
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
      "Address" => (@medical_patient_form.address_1 ? (@medical_patient_form.address_1.to_s + ',') : '') + @medical_patient_form.address_2.to_s,
      "City" => @medical_patient_form.address_city,
      "State" => @medical_patient_form.address_state,
      "Age" => @You_Age ? @You_Age[0].to_s + @You_Age[1].to_s + 'Y' + ' ' + @You_Age[2].to_s + @You_Age[3].to_s + 'M' :'',
      "Date" => @medical_patient_form.birth_date ? @medical_patient_form.birth_date.strftime('%m-%d-%Y') : '',
      "HomePhoneNumber" => @medical_patient_form.home_phone_1.to_s + '-' + @medical_patient_form.home_phone_2.to_s + '-' + @medical_patient_form.home_phone_3.to_s,
      "WorkPhoneNumber" => @medical_patient_form.work_phone_1.to_s + '-' + @medical_patient_form.work_phone_2.to_s + '-' + @medical_patient_form.work_phone_3.to_s,
      "CellPhoneNumber" => @medical_patient_form.cell_phone_1.to_s + '-' + @medical_patient_form.cell_phone_2.to_s + '-' + @medical_patient_form.cell_phone_3.to_s,
      "MaritalStatus" => @medical_patient_form.marital_status,
      "SocialSecurityNumber" => @medical_patient_form.ssn_1.to_s + '-' + @medical_patient_form.ssn_2.to_s + '-' + @medical_patient_form.ssn_3.to_s,
      "FamilyReferral" => @medical_patient_form.referred_to_our_office_by == 'Family' ? 'Yes' : '',
      "FriendReferral" => @medical_patient_form.referred_to_our_office_by == 'Friend' ? 'Yes' : '',
      "PhysicianReferral" => @medical_patient_form.referred_to_our_office_by == 'Physician' ? 'Yes' : '',
      "AdvertisementReferral" => @medical_patient_form.referred_to_our_office_by == 'Advertisement' ? 'Yes' : '',
      "WebsiteReferral" => @medical_patient_form.referred_to_our_office_by == 'Website' ? 'Yes' : '',

      #Employer tab
      "EmployerName" => @medical_patient_form.employer,
      "EmployerAddress" => (@medical_patient_form.employer_address_1 ? (@medical_patient_form.employer_address_1.to_s + ',') : '') + @medical_patient_form.employer_address_2.to_s,
      "EmployerCity" => @medical_patient_form.employer_address_city,
      "EmployerState" => @medical_patient_form.employer_address_state,
      "EmployerZip" => @medical_patient_form.employer_address_zip,

      #Spouse tab
      "SpouseName" => @medical_patient_form.spouse_first_name.to_s + ' ' + @medical_patient_form.spouse_last_name.to_s,
      "SpouseHomePhoneNumber" => @medical_patient_form.spouse_home_phone_1.to_s + '-' + @medical_patient_form.spouse_home_phone_2.to_s + '-' + @medical_patient_form.spouse_home_phone_3.to_s,
      "SpouseWorkPhoneNumber" => @medical_patient_form.spouse_work_phone_1.to_s + '-' + @medical_patient_form.spouse_work_phone_2.to_s + '-' + @medical_patient_form.spouse_work_phone_3.to_s,

      #Emergency Contact tab
      "EmergencyContact" => @medical_patient_form.emergency_contact_first_name.to_s + ' ' + @medical_patient_form.emergency_contact_last_name.to_s,
      "EmergencyContactRelationship" => @medical_patient_form.emergency_contact_relationship,
      "EmergencyContactPhoneNumber" => @medical_patient_form.emergency_contact_phone_1.to_s + '-' + @medical_patient_form.emergency_contact_phone_2.to_s + '-' + @medical_patient_form.emergency_contact_phone_3.to_s,

      #Primary Insurance tab
      "PrimaryInsuranceName" => @medical_patient_form.primary_insurance_company_name,
      "PrimaryInsuranceAddress" => (@medical_patient_form.primary_insurance_address_1 ? (@medical_patient_form.primary_insurance_address_1.to_s + ',') : '') + (@medical_patient_form.primary_insurance_address_2 ? (@medical_patient_form.primary_insurance_address_2.to_s + ','): '') + @medical_patient_form.primary_insurance_address_city.to_s + @medical_patient_formprimary_insurance_address_state.to_s ,
      "PrimaryInsuranceStateZip" => @medical_patient_form.primary_insurance_address_zip,
      "PrimaryInsurancePhone" => @medical_patient_form.primary_insurance_phone_1.to_s + '-' + @medical_patient_form.primary_insurance_phone_2.to_s + '-' + @medical_patient_form.primary_insurance_phone_3.to_s,
      "PrimaryInsuranceID" => @medical_patient_form.primary_insurance_id,
      "PrimaryInsuranceGroup" => @medical_patient_form.primary_insurance_group,
      "PrimaryInsurancePolicyHolderEmployer" => @medical_patient_form.primary_insurance_policy_holder == 'Other' ? @medical_patient_form.primary_insurance_policy_holder_employer  : 'Self',
      "PrimaryInsurancePolicyHolderDateofBirth" => @medical_patient_form.primary_insurance_policy_holder == 'Other' ? primary_insurance_birth_date : ' ',
      "PrimaryInsurancePolicyHolderRelationship" => @medical_patient_form.primary_insurance_policy_holder == 'Other' ? primary_insurance_relationship : ' ',
      "PrimaryInsurancePolicyHolderName" => @medical_patient_form.primary_insurance_policy_holder == 'Other' ? @medical_patient_form.primary_insurance_policy_holder_first_name.to_s + '' + @medical_patient_form.primary_insurance_policy_holder_last_name.to_s : '',
      "PrimaryInsurancePolicyHolderSocialSecurityNumber" => @medical_patient_form.primary_insurance_policy_holder == 'Other' ? @medical_patient_form.primary_insurance_ssn_1.to_s + '-' + @medical_patient_form.primary_insurance_ssn_2.to_s + '-' + @medical_patient_form.primary_insurance_ssn_3.to_s : '',

      #Secondary Insurance tab
      "SecondaryInsuranceName" => @medical_patient_form.secondary_insurance_company_name,
      "SecondaryInsuranceAddress" => (@medical_patient_form.secondary_insurance_address_1 ? (@medical_patient_form.secondary_insurance_address_1.to_s + ',') : '') + (@medical_patient_form.secondary_insurance_address_2 ? (@medical_patient_form.secondary_insurance_address_2.to_s + ','): '') + @medical_patient_form.secondary_insurance_address_city.to_s + secondary_insurance_address_state.to_s ,
      "SecondaryInsuranceStateZip" => @medical_patient_form.secondary_insurance_address_zip,
      "SecondaryInsurancePhoneNumber" => @medical_patient_form.secondary_insurance_phone_1.to_s + '-' + @medical_patient_form.secondary_insurance_phone_2.to_s + '-' + @medical_patient_form.secondary_insurance_phone_3.to_s,
      "SecondaryInsuranceID" => @medical_patient_form.secondary_insurance_id,
      "SecondaryInsuranceGroup" => @medical_patient_form.secondary_insurance_group,
      "SecondaryInsurancePolicyHolderEmployer" => @medical_patient_form.secondary_insurance_policy_holder == 'Other' ? @medical_patient_form.secondary_insurance_policy_holder_employer  : 'Self',
      "SecondaryInsurancePolicyHolderDateofBirth" => @medical_patient_form.secondary_insurance_policy_holder == 'Other' ? secondary_insurance_birth_date : ' ',
      "SecondaryInsurancePolicyHolderRelationship" => @medical_patient_form.secondary_insurance_policy_holder == 'Other' ? secondary_insurance_relationship : ' ',
      "SecondaryInsurancePolicyHolderName" => @medical_patient_form.secondary_insurance_policy_holder == 'Other' ? @medical_patient_form.secondary_insurance_policy_holder_first_name.to_s + '' + @medical_patient_form.secondary_insurance_policy_holder_last_name.to_s : '',
      "SecondaryInsurancePolicyHolderSocialSecurityNumber" => @medical_patient_form.secondary_insurance_policy_holder == 'Other' ? @medical_patient_form.secondary_insurance_ssn_1.to_s + '-' + @medical_patient_form.secondary_insurance_ssn_2.to_s + '-' + @medical_patient_form.secondary_insurance_ssn_3.to_s : '',

      #Patient Consent tab
      "ConsentToSharePersonalHealthInformationName1" => @medical_patient_form.patient_consent_first_name_1.to_s + ' ' + @medical_patient_form.patient_consent_last_name_1.to_s,
      "ConsentToSharePersonalHealthInformationName2" => @medical_patient_form.patient_consent_first_name_2.to_s + ' ' + @medical_patient_form.patient_consent_last_name_2.to_s,
      "ConsentToSharePersonalHealthInformationName3" => @medical_patient_form.patient_consent_first_name_3.to_s + ' ' + @medical_patient_form.patient_consent_last_name_3.to_s,
      "ConsentToSharePersonalHealthInformationName1RelationshiptoPatient" => @medical_patient_form.patient_consent_relation_ship_to_patient_1,
      "ConsentToSharePersonalHealthInformationName2RelationshiptoPatient" => @medical_patient_form.patient_consent_relation_ship_to_patient_2,
      "ConsentToSharePersonalHealthInformationName3RelationshiptoPatient" => @medical_patient_form.patient_consent_relation_ship_to_patient_3,
      "Name" => @medical_patient_form.first_name.to_s + ' ' + @medical_patient_form.last_name.to_s,
      "Referredby" => @medical_patient_form.referral_name,
      "DateofBirth" => @medical_patient_form.birth_date,
      "DateofExam" =>  @appointment.appointment_date_time.strftime('%m-%d-%Y'),

      #medical History tab
      "ReasonForVisit" => @medical_patient_form.medical_history_reason_for_visit_1,
      "ReasonForVisit2" => @medical_patient_form.medical_history_reason_for_visit_2,
      "ReasonForVisit3" => @medical_patient_form.medical_history_reason_for_visit_2,
      "NameandTypeofSpecialist1" => @medical_patient_form.medical_history_specialist_1.to_s + ' ' + @medical_patient_form.medical_history_speciality_1.to_s,
      "NameandTypeofSpecialist2" => @medical_patient_form.medical_history_specialist_2.to_s + ' ' + @medical_patient_form.medical_history_speciality_2.to_s,
      "NameandTypeofSpecialist3" => @medical_patient_form.medical_history_specialist_3.to_s + ' ' + @medical_patient_form.medical_history_speciality_3.to_s,
      "NameandTypeofSpecialist4" => @medical_patient_form.medical_history_specialist_4.to_s + ' ' + @medical_patient_form.medical_history_speciality_4.to_s,
      "MedicationDosageTimesPerDaya" => @medical_patient_form.medical_history_medication_medication_1.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_1.to_s + ' ' + @medical_patient_form.medical_history_medication_times_per_day_1.to_s,
      "MedicationDosageTimesPerDayb" => @medical_patient_form.medical_history_medication_medication_2.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_2.to_s + ' ' + @medical_patient_form.medical_history_medication_times_per_day_2.to_s,
      "MedicationDosageTimesPerDayc" => @medical_patient_form.medical_history_medication_medication_3.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_3.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_3.to_s,
      "MedicationDosageTimesPerDayd" => @medical_patient_form.medical_history_medication_medication_4.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_4.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_4.to_s,
      "MedicationDosageTimesPerDaye" => @medical_patient_form.medical_history_medication_medication_5.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_5.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_5.to_s,
      "MedicationDosageTimesPerDayf" => @medical_patient_form.medical_history_medication_medication_6.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_6.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_6.to_s,
      "MedicationDosageTimesPerDayg" => @medical_patient_form.medical_history_medication_medication_7.to_s + ' ' +  @medical_patient_form.medical_history_medication_dosage_7.to_s + ' ' +@medical_patient_form.medical_history_medication_times_per_day_7.to_s,
      "MedicationAllergyReactionA" => @medical_patient_form.medical_history_medication_allergies_medication_1.to_s + ' ' + @medical_patient_form.medical_history_medication_allergies_reaction_1.to_s,
      "MedicationAllergyReactionB" => @medical_patient_form.medical_history_medication_allergies_medication_2.to_s + ' ' + @medical_patient_form.medical_history_medication_allergies_reaction_2.to_s,
      "MedicationAllergyReactionC" => @medical_patient_form.medical_history_medication_allergies_medication_3.to_s + ' ' + @medical_patient_form.medical_history_medication_allergies_reaction_3.to_s,
      "OpeartionAndDateA" => @medical_patient_form.medical_history_operations_operation_1.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_1.to_s,
      "OpeartionAndDateB" => @medical_patient_form.medical_history_operations_operation_2.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_2.to_s,
      "OpeartionAndDateC" => @medical_patient_form.medical_history_operations_operation_3.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_3.to_s,
      "OpeartionAndDateD" => @medical_patient_form.medical_history_operations_operation_4.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_4.to_s,
      "OpeartionAndDateE" => @medical_patient_form.medical_history_operations_operation_5.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_5.to_s,
      "OpeartionAndDateF" => @medical_patient_form.medical_history_operations_operation_6.to_s + ' ' + @medical_patient_form.medical_history_operations_operation_date_6.to_s,
      "IllnessAndDiagnosisDateA" => @medical_patient_form.medical_history_previous_illnesses_illness_1.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_1.to_s,
      "IllnessAndDiagnosisDateB" => @medical_patient_form.medical_history_previous_illnesses_illness_2.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_2.to_s,
      "IllnessAndDiagnosisDateC" => @medical_patient_form.medical_history_previous_illnesses_illness_3.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_3.to_s,
      "IllnessAndDiagnosisDateD" => @medical_patient_form.medical_history_previous_illnesses_illness_4.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_4.to_s,
      "IllnessAndDiagnosisDateE" => @medical_patient_form.medical_history_previous_illnesses_illness_5.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_5.to_s,
      "IllnessAndDiagnosisDateF" => @medical_patient_form.medical_history_previous_illnesses_illness_6.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_6.to_s,
      "IllnessAndDiagnosisDateG" => @medical_patient_form.medical_history_previous_illnesses_illness_7.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_7.to_s,
      "IllnessAndDiagnosisDateH" => @medical_patient_form.medical_history_previous_illnesses_illness_8.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_8.to_s,
      "IllnessAndDiagnosisDateI" => @medical_patient_form.medical_history_previous_illnesses_illness_9.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_9.to_s,
      "IllnessAndDiagnosisDateJ" => @medical_patient_form.medical_history_previous_illnesses_illness_10.to_s + ' ' + @medical_patient_form.medical_history_previous_illnesses_diagnosis_10.to_s,

      #Family History Tab
      "MotherLiving" => @medical_patient_form.family_history_mother_living_or_deceased == 'Living' ? 'Yes' : '' ,
      "MotherDeceased" => @medical_patient_form.family_history_mother_living_or_deceased == 'Deceased' ? 'Yes' : '' ,
      "MotherAgeDeceased" => @medical_patient_form.family_history_mother_age,
      "FatherLiving" => @medical_patient_form.family_history_father_living_or_deceased == 'Living' ? 'Yes' : '' ,
      "FatherrDeceased" => @medical_patient_form.family_history_father_living_or_deceased == 'Deceased' ? 'Yes' : '' ,
      "FatherAgeDeceased" => @medical_patient_form.family_history_father_age,
      "Sibling1AgeDeceased" => @medical_patient_form.family_history_siblings_age_1,
      "Sibling2AgeDeceased" => @medical_patient_form.family_history_siblings_age_2,
      "Sibling3AgeDeceased" => @medical_patient_form.family_history_siblings_age_3,
      "Sibling1Deceased" => @medical_patient_form.family_history_siblings_living_deceased_1 == 'Deceased' ? 'Yes' : '' ,
      "Sibling2Deceased" => @medical_patient_form.family_history_siblings_living_deceased_2 == 'Deceased' ? 'Yes' : '' ,
      "Sibling3Deceased" => @medical_patient_form.family_history_siblings_living_deceased_3 == 'Deceased' ? 'Yes' : '' ,
      "Sibling1Living" => @medical_patient_form.family_history_siblings_living_deceased_1 == 'Living' ? 'Yes' : '' ,
      "Sibling2Living" => @medical_patient_form.family_history_siblings_living_deceased_2 == 'Living' ? 'Yes' : '' ,
      "Sibling3Living" => @medical_patient_form.family_history_siblings_living_deceased_3 == 'Living' ? 'Yes' : '' ,
      "Sibling1IllnessAgeAtDiagnosisA" => @medical_patient_form.family_history_siblings_age_1,
    })
    #raise @pdftk.fields(form_pdf_path).to_yaml
  end

end
