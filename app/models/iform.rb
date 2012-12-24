class Iform < ActiveRecord::Base
  belongs_to :appointment


  def self.new_patient_form_generator(iform)

    pdftkpath = PDFTK_PATH
    pdffilepath = PDFFILES_PATH
    path = pdffilepath + "#{iform.path}.pdf"
    @pdftk = PdftkForms::Wrapper.new(pdftkpath)
    @pdf_form = iform.formname.gsub(' ', '_')
    if iform.Self_Birthdate
      @You_Age = Date.today.strftime('%Y%m%d').to_i - iform.Self_Birthdate.strftime('%Y%m%d').to_i
      @You_Age = @You_Age.to_s.split('')
    end
    @pdftk.fill_form(pdffilepath+"#{@pdf_form}.pdf", path, {
      "Date" => iform.updated_at.strftime('%m') + '-' + iform.updated_at.strftime('%d') + '-' + iform.updated_at.strftime('%Y'),
      "PatientName" => iform.Self_Name_First.to_s + ' ' + iform.Self_Name_Last,
      "PatientGender" => iform.Self_Sex == 'f' ? "Female" : 'Male',
      "PatientBirthDateDay" => iform.Self_Birthdate ? iform.Self_Birthdate.strftime('%d') : '',
      "PatientBirthDateYear" => iform.Self_Birthdate ? iform.Self_Birthdate.strftime('%y') : '',
      "PatientBirthDateMonth" => iform.Self_Birthdate ? iform.Self_Birthdate.strftime('%m') : '',
      "PatientAge" => @You_Age ? @You_Age[0] + @You_Age[1] + 'Y' + ' ' + @You_Age[2] + @You_Age[3] + 'M' : '',
      "PatientMaritalStatus" => iform.Self_Marital_Status,
      "PatientSocialSecurityNumber" => iform.ssn_1.to_s + '-' + iform.ssn_2.to_s + '-' + iform.ssn_3.to_s,
      "PatientDriversLicenseStateAndNumber" => iform.Self_Driver_License_State.to_s + ' ' + iform.Self_Driver_License_Number.to_s,
      "PatientDriversLicense" => iform.Self_Driver_License_Number,
      "PatientAddress" => (iform.Self_Home_Address1.empty? ? ' ' : (iform.Self_Home_Address1.to_s + ',')) + (iform.Self_Home_Address2.empty? ? ' ' : (iform.Self_Home_Address2.to_s + ', ')) + iform.Self_Home_City.to_s + ' ' + iform.Self_Home_State.to_s + ' ' + iform.Self_Home_Postal_Code.to_s,
      "PatientHomePhone" => iform.home_phone_1.to_s + '-' + iform.home_phone_2.to_s + '-' + iform.home_phone_3.to_s,
      "PatientWorkPhone" => iform.work_phone_1.to_s + '-' + iform.work_phone_2.to_s + '-' + iform.work_phone_3.to_s,
      "PatientCellPhone" => iform.cell_phone_1.to_s + '-' + iform.cell_phone_2.to_s + '-' + iform.cell_phone_3.to_s,
      "BestPhoneNumberDuringDay" => iform.best_number_to_reach,
      "PatientEmployer" => iform.Self_Employer_Name,
      "PatientEmployerAddressAndPhone" => (iform.Self_Employer_Address1.empty? ? ' ' : (iform.Self_Employer_Address1.to_s + ',')) + (iform.Self_Employer_Address2.empty? ? ' ' : (iform.Self_Employer_Address2.to_s + ','+ ' ')) + iform.Self_Employer_City.to_s + ' ' + iform.Self_Employer_State.to_s + ' ' + iform.Self_Employer_Postal_Code.to_s + '  ' + iform.employer_phone_1.to_s + '-'+ iform.employer_phone_2.to_s + '-'+ iform.employer_phone_3.to_s,
      "PatientSpouseName" => iform.Spouse_Name_First.to_s + ' ' + iform.Spouse_Name_Last.to_s,
      "PatientSpouseEmployer" => iform.Spouse_Employer_Name,
      "PatientEmergencyContactNameAndPhone" => iform.Emergency_Contact_Name_First.to_s + ' ' + iform.Emergency_Contact_Name_Last.to_s + '  ' + iform.emergency_contact_phone_1.to_s + '-' + iform.emergency_contact_phone_2.to_s + '-' + iform.emergency_contact_phone_3.to_s,
      "PersonResponsibleForAccountRelationToPatient" => iform.person_responsible_for_ac == 'Other' ? iform.relationship_to_patient : 'Self',
      "PersonResponsibleForAccountName" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_first_name.to_s + ' ' + iform.billing_details_last_name.to_s) : ' ',
      "PersonResponsibleForAccountAddress" => iform.person_responsible_for_ac == 'Other' ? ((iform.billing_details_address1.empty? ? ' ' : (iform.billing_details_address1.to_s + ',')) + (iform.billing_details_address2.empty? ? ' ' : (iform.billing_details_address2.to_s + ',' + ' ')) + iform.billing_details_address_city.to_s + ' ' + iform.billing_details_address_state.to_s + ' ' + iform.billing_details_address_postal_code.to_s) : '',
      "PersonResponsibleForAccountHomePhone" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_home_phone_1.to_s + ' ' + iform.billing_details_home_phone_2.to_s + ' ' + iform.billing_details_home_phone_3.to_s) : ' ',
      "PersonResponsibleForAccountWorkPhone" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_work_phone_1.to_s + ' ' + iform.billing_details_work_phone_2.to_s + ' ' + iform.billing_details_work_phone_3.to_s) : ' ',
      "PersonResponsibleForAccountCellPhone" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_cell_phone_1.to_s + ' ' + iform.billing_details_cell_phone_2.to_s + ' ' + iform.billing_details_cell_phone_3.to_s) : ' ',
      "PersonResponsibleForAccountSocialSecurityNumber" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_ssn_1.to_s + '-' + iform.billing_details_ssn_2.to_s + '-' + iform.billing_details_ssn_3.to_s) : ' ',
      "PersonResponsibleForAccountDriversLicenseStateAndNumber" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_driving_licence_state.to_s + ' ' + iform.billing_details_driving_licence_number.to_s) : ' ',
      "PersonResponsibleForAccountBirthDate" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_birth_date ? iform.billing_birth_date.strftime('%m-%d-%Y') : '') : ' ',
      "PersonResponsibleForAccountEmployer" => iform.person_responsible_for_ac == 'Other' ? (iform.billing_details_employer_name) : ' ',
      "PersonResponsibleForAccountEmployerAddressAndPhone" => iform.person_responsible_for_ac == 'Other' ? ((iform.billing_details_employer_address1.empty? ? ' ' : (iform.billing_details_employer_address1.to_s + ',')) + (iform.billing_details_employer_address2.empty? ? ' ' : (iform.billing_details_employer_address2.to_s + ','+ ' ')) + iform.billing_details_employer_address_city.to_s + ' ' + iform.billing_details_employer_address_state.to_s + ' ' + iform.billing_details_employer_address_postal_code.to_s) : ' ',
      "HowDidYouHearAboutOurOffice" => iform.how_did_you_hear_about_office,
      "SmileWhiteness" => iform.smile_evaluation_whiteness,
      "SmileStainingDiscoloration" => iform.smile_evaluation_staining,
      "SmileAlignmentOfTeeth" => iform.smile_evaluation_alignment_of_test,
      "SmileChippingCracking" => iform.smile_evaluation_chipping,
      "SmileExistingDentalWork" => iform.smile_evaluation_existing_dental_work,
      "SmileGumHealthAppearance" => iform.smile_evaluation_gum_health,
      "SmileSmileLine" => iform.smile_evaluation_smile_line,
      "IsThereAnythingElse" => iform.anything_else_about_smile,

    })
    #form_pdf_path = "#{PDFFILES_PATH}Karen_Naples_1.pdf"
    #raise @pdftk.fields(form_pdf_path).to_yaml
    iform_file = File.new(path, 'rb')
    iform.pdffile_path = iform_file.read()
    iform.save

    File.delete(path)
  end

  def self.rising_stars_pediatric_form_generator(iform)
    pdftkpath = PDFTK_PATH
    pdffilepath = PDFFILES_PATH
    path = pdffilepath + "#{iform.path}.pdf"
    @pdftk = PdftkForms::Wrapper.new(pdftkpath)
    @pdf_form = iform.formname.gsub(' ', '_')
    if iform.Self_Birthdate
      @You_Age = Date.today.strftime('%Y%m%d').to_i - iform.Self_Birthdate.strftime('%Y%m%d').to_i
      @You_Age = @You_Age.to_s.split('')
    end
    @pdftk.fill_form(pdffilepath+"#{@pdf_form}.pdf", path, {

      # Patient Tab
      "Name" => iform.Self_Name_First.to_s + ' ' + iform.Self_Name_Last,
      "Address" => (iform.Self_Home_Address1.empty? ? ' ' : (iform.Self_Home_Address1.to_s + ',')) + (iform.Self_Home_Address2.empty? ? ' ' : iform.Self_Home_Address2.to_s),
      "Age" => @You_Age ? @You_Age[0] + @You_Age[1] + 'Y' + ' ' + @You_Age[2] + @You_Age[3] + 'M' : '',
      "BirthDate" => iform.Self_Birthdate ? iform.Self_Birthdate.strftime('%m-%d-%Y') : '',
      "City" => iform.Self_Home_City,
      "Female" => iform.Self_Sex == 'f' ? 'Yes' : '',
      "Male" => iform.Self_Sex == 'm' ? 'Yes' : '',
      "HomeTelephone" => iform.home_phone_1.to_s + '-' + iform.home_phone_2.to_s + '-' + iform.home_phone_3.to_s,
      "OtherTelephoneNumber" => iform.patient_other_phone_1.to_s + '-' + iform.patient_other_phone_2.to_s + '-' + iform.patient_other_phone_3.to_s,
      "ReferredBy" => iform.how_did_you_hear_about_office,
      "PreviouslySeenSiblingsNo" => iform.patient_previously_siblings_list == '' ? 'Yes' : '',
      "PreviouslySeenSiblingsYes" => iform.patient_previously_siblings_list == '' ? '' : 'Yes',
      "SiblingsNames" => iform.patient_previously_siblings_list,
      "State" => iform.Self_Home_State,
      "Zip" => iform.Self_Home_Postal_Code,

      # Father Tab
      "FatherName" => iform.patient_guardian_father_first_name.to_s + ' ' + iform.patient_guardian_father_last_name.to_s,
      "FatherAddress" => (iform.patient_guardian_father_address_1.empty? ? ' ' : (iform.patient_guardian_father_address_1.to_s + ',')) + (iform.patient_guardian_father_address_2.empty? ? ' ' : (iform.patient_guardian_father_address_2.to_s + ', ')) + iform.patient_guardian_father_address_city.to_s + ' ' + iform.patient_guardian_father_address_state.to_s + ' ' + iform.patient_guardian_father_address_zip.to_s,
      "FatherBirthDate" => iform.patient_guardian_father_birth_date ? iform.patient_guardian_father_birth_date.strftime('%m-%d-%Y') : '',
      "FatherCellTelephoneNumber" => iform.patient_guardian_father_cell_phone_1.to_s + '-' + iform.patient_guardian_father_cell_phone_2.to_s + '-' + iform.patient_guardian_father_cell_phone_3.to_s,
      "FatherEmail" => iform.patient_guardian_father_email,
      "FatherEmployer" => iform.patient_guardian_father_employer,
      "Father" => iform.patient_guardian_father == 'Father' ? 'Yes' : '',
      "FatherGuardian" => iform.patient_guardian_father == 'Guardian' ? 'Yes' : '',
      "FatherOther" => iform.patient_guardian_father == 'Other' ? 'Yes' : '',
      "Stepfather" => iform.patient_guardian_father == 'Stepfather' ? 'Yes' : '',
      "FatherHomeTelephoneNumber" => iform.patient_guardian_father_home_phone_1.to_s + '-' + iform.patient_guardian_father_home_phone_2.to_s + '-' + iform.patient_guardian_father_home_phone_3.to_s,
      "FatherSSN" => iform.patient_guardian_father_ssn_1.to_s + '-' + iform.patient_guardian_father_ssn_2.to_s + '-' + iform.patient_guardian_father_ssn_3.to_s,
      "FatherWorkTelephoneNumber" => iform.patient_guardian_father_work_phone_1.to_s + '-' + iform.patient_guardian_father_work_phone_2.to_s + '-' + iform.patient_guardian_father_work_phone_3.to_s,
      "FatherOtherDescription" => iform.patient_guardian_father_other_description,

      # Mother Tab
      "MotherAddress" => (iform.patient_guardian_mother_address_1.empty? ? ' ' : (iform.patient_guardian_mother_address_1.to_s + ',')) + (iform.patient_guardian_mother_address_2.empty? ? ' ' : (iform.patient_guardian_mother_address_2.to_s + ', ')) + iform.patient_guardian_mother_address_city.to_s + ' ' + iform.patient_guardian_mother_address_state.to_s + ' ' + iform.patient_guardian_mother_address_zip.to_s,
      "MotherBirthDate" => iform.patient_guardian_mother_birth_date ? iform.patient_guardian_mother_birth_date.strftime('%m-%d-%Y') : '',
      "MotherCellTelephoneNumber" => iform.patient_guardian_mother_cell_phone_1.to_s + '-' + iform.patient_guardian_mother_cell_phone_2.to_s + '-' + iform.patient_guardian_mother_cell_phone_3.to_s,
      "MotherEmail" => iform.patient_guardian_mother_email,
      "MotherEmployer" => iform.patient_guardian_mother_employer,
      "Mother" => iform.patient_guardian_mother == 'Mother' ? 'Yes' : '',
      "MotherGuardian" => iform.patient_guardian_mother == 'Guardian' ? 'Yes' : '',
      "Stepmother" => iform.patient_guardian_father == 'Stepmother' ? 'Yes' : '',
      "MotherOther" => iform.patient_guardian_mother == 'Other' ? 'Yes' : '',
      "MotherHomeTelephoneNumber" => iform.patient_guardian_mother_home_phone_1.to_s + '-' + iform.patient_guardian_mother_home_phone_2.to_s + '-' + iform.patient_guardian_mother_home_phone_3.to_s,
      "MotherName" => iform.patient_guardian_mother_first_name.to_s + ' ' + iform.patient_guardian_mother_last_name.to_s,
      "MotherSSN" => iform.patient_guardian_mother_ssn_1.to_s + '-' + iform.patient_guardian_mother_ssn_2.to_s + '-' + iform.patient_guardian_mother_ssn_3.to_s,
      "MotherWorkTelephoneNumber" => iform.patient_guardian_mother_work_phone_1.to_s + '-' + iform.patient_guardian_mother_work_phone_2.to_s + '-' + iform.patient_guardian_mother_work_phone_3.to_s,
      "MotherOtherDescription" => iform.patient_guardian_mother_other_description,

      # Insurance
      "InsuranceClaimsMailingAddress" => iform.insurance_insured == 'Father' ? iform.patient_guardian_father_email : (iform.insurance_insured == 'Mother' ? iform.patient_guardian_mother_email : ''),
      "DentalInsuranceNo" => iform.insurance_company_name == '' ? 'Yes' : '',
      "DentalInsuranceYes" => iform.insurance_company_name == '' ? '' : 'Yes',
      "InsuranceCompany" => iform.insurance_company_name,
      "InsuranceGroupNumber" => iform.insurance_group,
      "InsuranceMemberID" => iform.insurance_member_id,
      "InsuranceTelephoneNumber" => iform.insurance_phone_1.to_s + '-' + iform.insurance_phone_2.to_s + '-' + iform.insurance_phone_3.to_s,
      "InsuredEmployer" => iform.insurance_employer,
      "InsuredName" => iform.insurance_person_first_name.to_s + ' ' + iform.insurance_person_last_name,
      "InsuredRelationshipToPatient" => iform.insurance_relation_ship_to_patient,
      "SecondaryInsuranceCompany" => iform.insurance_second_insurance_company_name,

      # Social History Tab
      "AdoptedAge" => iform.social_history_patient_adopted_age,
      "AdoptedNo" => iform.social_history_patient_adopted == 'No' ? 'Yes' : '',
      "AdoptedYes" => iform.social_history_patient_adopted == 'Yes' ? 'Yes' : '',
      "AdvancedLearning" => iform.social_history_patient_is == 'Advanced in learning' ? 'Yes' : '',
      "LearningProgressingNormally" => iform.social_history_patient_is == 'Progressing normally' ? 'Yes' : '',
      "SlowLearner" => iform.social_history_patient_is == 'A slow learner' ? 'Yes' : '',
      "Favorites" => iform.social_history_patient_favorites,
      "FirstLanguage" => iform.social_history_patient_first_lang,
      "SecondLanguage" => iform.social_history_patient_second_lang,
      "HearingProblems" => iform.social_history_patient_have_problems_hearing ? 'Yes' : '',
      "HowWellToleratesCare" => iform.social_history_patient_tolerate,
      "SleepProblems" => iform.social_history_patient_have_problems_sleep ? 'Yes' : '',
      "SpeechProbelms" => iform.social_history_patient_have_problems_speech ? 'Yes' : '',
      "VisionProblems" => iform.social_history_patient_have_problems_vision ? 'Yes' : '',

      # Dental History tab
      "LipBiting" => iform.dental_history_lip_biting ? 'Yes' : '',
      "TeethGrinding" => iform.dental_history_teeth_grinding ? 'Yes' : '',
      "Afraid" => iform.dental_history_patient_behave_today_afraid ? 'Yes' : '',
      "GaveUpBottle" => iform.dental_history_age_at_stop_bottle == '' ? '' : 'Yes',
      "AgeGaveUpBottle" => iform.dental_history_age_at_stop_bottle,
      "AgeGaveUpSippyCup" => iform.dental_history_age_at_stop_bottle_sippy_cup,
      "BadBreath" => iform.dental_history_bad_breath ? 'Yes' : '',
      "BleedingGums" => iform.dental_history_patient_bleeding_gums ? 'Yes' : '',
      "BrushTeethDaily" => iform.dental_history_does_child_flosh_teeth == 'Daily' ? 'Yes' : '',
      "BrushTeethSometimes" => iform.dental_history_does_child_flosh_teeth == 'Sometimes' ? 'Yes' : '',
      "BrushTeethNever" => iform.dental_history_does_child_flosh_teeth == 'Never' ? 'Yes' : '',
      "Cavities" => iform.dental_history_cavities ? 'Yes' : '',
      "CrookedTeeth" => iform.dental_history_crooked_teeth ? 'Yes' : '',
      "DateOfLastVisit" => iform.dental_history_patient_last_visiting_date,
      "MoreThanOneDentalInsuranceNo" => iform.insurance_do_you_have_more_than_one_dental_insurance == 'No' ? 'Yes' : '',
      "MoreThanOneDentalInsuranceYes" => iform.insurance_do_you_have_more_than_one_dental_insurance == 'Yes' ? 'Yes' : '',
      "DiscoloredTeeth" => iform.dental_history_discolored_teeth ? 'Yes' : '',
      "ElectricToothbrushNo" => iform.dental_history_does_child_brush_teeth_electric_tooth_brush == 'No' ? 'Yes' : '',
      "ElectricToothbrushYes" => iform.dental_history_does_child_brush_teeth_electric_tooth_brush == 'Yes' ? 'Yes' : '',
      "FirstVisitToDentistNo" => iform.dental_history_patient_first_time_to_visit == 'No' ? 'Yes' : '',
      "FirstVisitToDentistYes" => iform.dental_history_patient_first_time_to_visit == 'Yes' ? 'Yes' : '',
      "FluorideNo" => iform.dental_history_patient_receive_fluoride_in_any_form == 'No' ? 'Yes' : '',
      "FluorideYes" => iform.dental_history_patient_receive_fluoride_in_any_form == 'Yes' ? 'Yes' : '',
      "FrequentHeadaches" => iform.dental_history_frequent_headaches ? 'Yes' : '',
      "Friendly" => iform.dental_history_patient_behave_today_friendly ? 'Yes' : '',
      "Happy" => iform.dental_history_patient_behave_today_happy ? 'Yes' : '',
      "HabitsOther" => iform.dental_history_other ? 'Yes' : '',
      "HowOftenTeethBrushing" => iform.dental_history_does_child_brush_teeth ? 'Yes' : '',
      "InheritedDentalCharacteristics" => iform.dental_history_patient_inherited_any_dental_characteristics,
      "InjuriesToTeeth" => iform.dental_history_patient_have_any_injuries ? 'Yes' : '',
      "JawPainFromJoint" => iform.dental_history_jaw_pain_from_joint ? 'Yes' : '',
      "KidneyDiseaseNo" => iform.medical_history_kidney_disease == 'No' ? 'Yes' : '',
      "KidneyDiseaseYes" => iform.medical_history_kidney_disease == 'Yes' ? 'Yes' : '',
      "LastSeizureDate" => iform.medical_history_date_of_last_seizure,
      "LiverDiseaseNo" => iform.medical_history_liver_disease == 'No' ? 'Yes' : '',
      "LiverDiseaseYes" => iform.medical_history_liver_disease == 'Yes' ? 'Yes' : '',
      "LooseTeeth" => iform.dental_history_loose_teeth ? 'Yes' : '',
      "MoreThanOneDentalInsuranceNo" => iform.medical_history_liver_disease == 'No' ? 'Yes' : '',
      "MoreThanOneDentalInsuranceYes" => iform.medical_history_liver_disease == 'Yes' ? 'Yes' : '',
      "Pacifier" => iform.dental_history_pacifier_use ? 'Yes' : '',
      "ReasonForVisit" => iform.dental_history_why_patient_here_today,
      "ReceiveFluorideDescription" => iform.dental_history_patient_receive_fluoride_in_any_form_description,
      "Resistant" => iform.dental_history_patient_behave_today_resistance ? 'Yes' : '',
      "RheumaticHeartDiseaseOrFeverNo" => iform.medical_history_liver_disease == 'No' ? 'Yes' : '',
      "RheumaticHeartDiseaseOrFeverYes" => iform.medical_history_liver_disease == 'Yes' ? 'Yes' : '',
      "ScarletFeverOrHighFeverNo" => iform.medical_history_scarlet_fever_or_high_fever == 'No' ? 'Yes' : '',
      "ScarletFeverOrHighFeverYes" => iform.medical_history_scarlet_fever_or_high_fever == 'Yes' ? 'Yes' : '',
      "SensitiveToHotCold" => iform.dental_history_sensitive_to_hot_or_cold ? 'Yes' : '',
      "SensitiveToSweets" => iform.dental_history_sensitive_to_sweets ? 'Yes' : '',
      "TeethBumped" => iform.dental_history_teeth_bumped ? 'Yes' : '',
      "ThumbSucking" => iform.dental_history_thumb_sucking ? 'Yes' : '',
      "Timid" => iform.dental_history_patient_behave_today_timid ? 'Yes' : '',
      "TMMJPoppingOrClicking" => iform.dental_history_tmj_popping_or_clicking ? 'Yes' : '',
      "Toothache" => iform.dental_history_toothache ? 'Yes' : '',
      "OralHabitsOtherDescription" => iform.dental_history_oral_habits_other_description,

      # Medical History tab
      "AbnormalBleedingOrBruisingNo" => iform.medical_history_abnormal_bleeding_or_bruising == 'No' ? 'Yes' : '',
      "AbnormalBleedingOrBruisingYes" => iform.medical_history_abnormal_bleeding_or_bruising == 'Yes' ? 'Yes' : '',
      "ADDADHDNo" => iform.medical_history_add_or_adhd == 'No' ? 'Yes' : '',
      "ADDADHDYes" => iform.medical_history_add_or_adhd == 'Yes' ? 'Yes' : '',
      "AIDSVirusNo" => iform.medical_history_aids_virus == 'No' ? 'Yes' : '',
      "AIDSVirusYes" => iform.medical_history_aids_virus == 'Yes' ? 'Yes' : '',
      "AsthmaBreathingProblemsDescription" => iform.medical_history_asthama_or_breathing_prob_description,
      "AsthmaMedicationDesciption" => iform.medical_history_asthma_medication,
      "AutismSpectrumNo" => iform.medical_history_autism_spectrum == 'No' ? 'Yes' : '',
      "AutismSpectrumYes" => iform.medical_history_autism_spectrum == 'Yes' ? 'Yes' : '',
      "BirthDefectsNo" => iform.medical_history_birth_defects == 'No' ? 'Yes' : '',
      "BirthDefectsYes" => iform.medical_history_birth_defects == 'Yes' ? 'Yes' : '',
      "BloodDiseasesOrAnemiaNo" => iform.medical_history_blood_diseases_or_anemia == 'No' ? 'Yes' : '',
      "BloodDiseasesOrAnemiaYes" => iform.medical_history_blood_diseases_or_anemia == 'Yes' ? 'Yes' : '',
      "CancerTumorsGrowthsOrCystsNo" => iform.medical_history_cancer_tumors_growths_or_cysts == 'No' ? 'Yes' : '',
      "CancerTumorsGrowthsOrCystsYes" => iform.medical_history_cancer_tumors_growths_or_cysts == 'Yes' ? 'Yes' : '',
      "CleftLipOrPalateNo" => iform.medical_history_cancer_tumors_growths_or_cysts == 'No' ? 'Yes' : '',
      "CleftLipOrPalateYes" => iform.medical_history_cancer_tumors_growths_or_cysts == 'Yes' ? 'Yes' : '',
      "ConvulsionsOrSeizuresNo" => iform.medical_history_Convulsions_or_seizures == 'No' ? 'Yes' : '',
      "ConvulsionsOrSeizuresYes" => iform.medical_history_Convulsions_or_seizures == 'Yes' ? 'Yes' : '',
      "DiabetesNo" => iform.medical_history_diabetes == 'No' ? 'Yes' : '',
      "DiabetesYes" => iform.medical_history_diabetes == 'Yes' ? 'Yes' : '',
      "DisabilitiesOrDevelopmentalDelaysNo" => iform.medical_history_patient_physical_disabilities == 'No' ? 'Yes' : '',
      "DisabilitiesOrDevelopmentalDelaysYes" => iform.medical_history_patient_physical_disabilities == 'Yes' ? 'Yes' : '',
      "DrugAllergiesDescription" => iform.medical_history_drug_allergies_description,
      "EarEyeNoseOrThroatTroubleNo" => iform.medical_history_ear_eye_nose_or_throat_trouble == 'No' ? 'Yes' : '',
      "EarEyeNoseOrThroatTroubleYes" => iform.medical_history_ear_eye_nose_or_throat_trouble == 'Yes' ? 'Yes' : '',
      "EatingDisordersNo" => iform.medical_history_eating_disorders == 'No' ? 'Yes' : '',
      "EatingDisordersYes" => iform.medical_history_eating_disorders == 'Yes' ? 'Yes' : '',
      "ERForAsthmaAttackDescription" => iform.medical_history_er_for_asthma_attack_description,
      "EverHospitalizedNo" => iform.medical_history_patient_ever_been_hospitalized == 'No' ? 'Yes' : '',
      "EverHospitalizedYes" => iform.medical_history_patient_ever_been_hospitalized == 'Yes' ? 'Yes' : '',
      "FoodAllergiesDescription" => iform.medical_history_food_allergies_description,
      "FrequentDiarrheaOrVomitingNo" => iform.medical_history_frequent_diarrhea_or_vomiting == 'No' ? 'Yes' : '',
      "FrequentDiarrheaOrVomitingYes" => iform.medical_history_frequent_diarrhea_or_vomiting == 'Yes' ? 'Yes' : '',
      "GoodGeneralHealthNo" => iform.medical_history_patient_good_general_health == 'No' ? 'Yes' : '',
      "GoodGeneralHealthYes" => iform.medical_history_patient_good_general_health == 'Yes' ? 'Yes' : '',
      "HearingVisionImpairmentNo" => iform.medical_history_hearing_or_vision_impairment == 'No' ? 'Yes' : '',
      "HearingVisionImpairmentYes" => iform.medical_history_hearing_or_vision_impairment == 'Yes' ? 'Yes' : '',
      "HeartTroubleOrHeartMurmurNo" => iform.medical_history_heart_trouble_or_heart_murmur == 'No' ? 'Yes' : '',
      "HeartTroubleOrHeartMurmurYes" => iform.medical_history_heart_trouble_or_heart_murmur == 'Yes' ? 'Yes' : '',
      "HerpesVirusOrShinglesNo" => iform.medical_history_herpes_virus_or_shingles == 'No' ? 'Yes' : '',
      "HerpesVirusOrShinglesYes" => iform.medical_history_herpes_virus_or_shingles == 'Yes' ? 'Yes' : '',
      "HighOrLowBloodPressureNo" => iform.medical_history_high_or_low_blood_pressure == 'No' ? 'Yes' : '',
      "HighOrLowBloodPressureYes" => iform.medical_history_high_or_low_blood_pressure == 'Yes' ? 'Yes' : '',
      "HospitalizationDescription" => iform.medical_history_patient_ever_been_hospitalized_description,
      "ImmunizationsAndBoosterShotsUpToDateNo" => iform.medical_history_patient_booster_shoot_up_to_date == 'No' ? 'Yes' : '',
      "ImmunizationsAndBoosterShotsUpToDateYes" => iform.medical_history_patient_booster_shoot_up_to_date == 'Yes' ? 'Yes' : '',
      "JaundiceOrHepatitisNo" => iform.medical_history_patient_booster_shoot_up_to_date == 'No' ? 'Yes' : '',
      "JaundiceOrHepatitisYes" => iform.medical_history_patient_booster_shoot_up_to_date == 'Yes' ? 'Yes' : '',
      "Medication1" => iform.medical_history_current_medication_name_1,
      "Medication1HowOften" => iform.medical_history_current_medication_how_often_1,
      "Medication1Reason" => iform.medical_history_current_medication_reason_1,
      "Medication2" => iform.medical_history_current_medication_name_2,
      "Medication2HowOften" => iform.medical_history_current_medication_how_often_2,
      "Medication2Reason" => iform.medical_history_current_medication_reason_2,
      "Medication3" => iform.medical_history_current_medication_name_3,
      "Medication3HowOften" => iform.medical_history_current_medication_how_often_3,
      "Medication3Reason" => iform.medical_history_current_medication_reason_3,
      "Medication4" => iform.medical_history_current_medication_name_4,
      "Medication4HowOften" => iform.medical_history_current_medication_how_often_4,
      "Medication4Reason" => iform.medical_history_current_medication_reason_4,
      "MumpsMeaslesOrChickenpoxNo" => iform.medical_history_patient_booster_shoot_up_to_date == 'No' ? 'Yes' : '',
      "MumpsMeaslesOrChickenpoxYes" => iform.medical_history_patient_booster_shoot_up_to_date == 'Yes' ? 'Yes' : '',
      "NervousOrEmotionalDisordersNo" => iform.medical_history_patient_booster_shoot_up_to_date == 'No' ? 'Yes' : '',
      "NervousOrEmotionalDisordersYes" => iform.medical_history_patient_booster_shoot_up_to_date == 'Yes' ? 'Yes' : '',
      "NotInGoodHealthDescription" => iform.medical_history_patient_good_general_health_description,
      "OperationsDescription" => iform.medical_history_patient_surgical_operations_description,
      "PhysicalDisabilitiesAndDevelopmentalDelaysDescription" => iform.medical_history_patient_physical_disabilities_description,
      "Physician" => iform.medical_history_physician,
      "PhysicianAddress" => (iform.medical_history_address_1.empty? ? ' ' : (iform.medical_history_address_1.to_s + ',')) + (iform.medical_history_address_2.empty? ? ' ' : (iform.medical_history_address_2.to_s + ', ')) + iform.medical_history_address_city.to_s + ' ' + iform.medical_history_address_state.to_s + ' ' + iform.medical_history_address_zip.to_s,
      "PhysicianTelephoneNumber" => iform.medical_history_home_phone_1.to_s + '-' + iform.medical_history_home_phone_2.to_s + '-' + iform.medical_history_home_phone_3.to_s,
      "ProblemsWithAnesthesiaNo" => iform.medical_history_problems_with_anesthesia == 'No' ? 'Yes' : '',
      "ProblemsWithAnesthesiaYes" => iform.medical_history_problems_with_anesthesia == 'Yes' ? 'Yes' : '',
      "ProlongedBleedingTransfusionsNo" => iform.medical_history_problems_with_anesthesia == 'No' ? 'Yes' : '',
      "ProlongedBleedingTransfusionsYes" => iform.medical_history_problems_with_anesthesia == 'Yes' ? 'Yes' : '',
      "SeasonalAllergiesNo" => iform.medical_history_seasonal_allergies ? '' : 'Yes',
      "SeasonalAllergiesYes" => iform.medical_history_seasonal_allergies ? 'Yes' : '',
      "LatexAllergiesNo" => iform.medical_history_latex_allergies ? '' : 'Yes',
      "LatexAllergiesYes" => iform.medical_history_latex_allergies ? 'Yes' : '',
      "SensoryIntegrationIssuesNo" => iform.medical_history_sensory_integration_issues == 'No' ? 'Yes' : '',
      "SensoryIntegrationIssuesYes" => iform.medical_history_sensory_integration_issues == 'Yes' ? 'Yes' : '',
      "SinusProblemsOrDrainageNo" => iform.medical_history_sinus_problems_or_drainage == 'No' ? 'Yes' : '',
      "SinusProblemsOrDrainageYes" => iform.medical_history_sinus_problems_or_drainage == 'Yes' ? 'Yes' : '',
      "SteroidsTherapyOrChemotherapyNo" => iform.medical_history_steroids_therapy_or_chemotherapy == 'No' ? 'Yes' : '',
      "SteroidsTherapyOrChemotherapyYes" => iform.medical_history_steroids_therapy_or_chemotherapy == 'Yes' ? 'Yes' : '',
      "StomachUlcersNo" => iform.medical_history_stomach_ulcers == 'No' ? 'Yes' : '',
      "StomachUlcersYes" => iform.medical_history_stomach_ulcers == 'Yes' ? 'Yes' : '',
      "SurgicalOperationsNo" => iform.medical_history_patient_surgical_operations == 'No' ? 'Yes' : '',
      "SurgicalOperationsYes" => iform.medical_history_patient_surgical_operations == 'Yes' ? 'Yes' : '',
      "ThyroidDiseaseNo" => iform.medical_history_patient_surgical_operations == 'No' ? 'Yes' : '',
      "ThyroidDiseaseYes" => iform.medical_history_patient_surgical_operations == 'Yes' ? 'Yes' : '',
      "TuberculosisOrTBExposureNo" => iform.medical_history_tuberculosis_or_tb_exposure == 'No' ? 'Yes' : '',
      "TuberculosisOrTBExposureYes" => iform.medical_history_tuberculosis_or_tb_exposure == 'Yes' ? 'Yes' : '',
      "WhatInducesBreathingProblemsDescription" => iform.medical_history_induces_breathing_prob,

    })
    #form_pdf_path = "#{PDFFILES_PATH}Karen_Naples_1.pdf"
    #raise @pdftk.fields(form_pdf_path).to_yaml
    iform_file = File.new(path, 'rb')
    iform.pdffile_path = iform_file.read()
    iform.save

    File.delete(path)
  end

  #def self_social_security_number
  #  self.Self_Social_Security_Number
  #end

  # after_save :update_appformjoin
  #
  # def self.update_appformjoin(appformjoin)
  #  @appformjoin = appformjoin
  # end
  #
  # def update_appformjoin
  # if @appformjoin.status == "pending"
  #    @appformjoin.status = ""
  #    @appformjoin.save
  # end
  # end
  #attr_writer :current_step

  #validates_presence_of :Self_Name_First, :Self_Name_Last #:if => lambda { |o| o.current_step == "aboutyou" }
  #validates_presence_of :spousename, :spouse_employer, :if => lambda { |o| o.current_step == "spouseinformation" }


  # def current_step
  #      @current_step || steps.first
  #  end
  #
  #    def steps
  #      %w[aboutyou spouceinformation orthodonticinsurance medicalhistory dentalhistory]
  #    end
  #    def next_step
  #     self.current_step = steps[steps.index(current_step)+1]
  #    end
  #
  #    def previous_step
  #      self.current_step = steps[steps.index(current_step)-1]
  #    end
  #    def first_step?
  #      current_step == steps.first
  #    end
  #
  #    def last_step?
  #      current_step == steps.last
  #    end
  #
  #    def all_valid?
  #      steps.all? do |step|
  #        self.current_step = step
  #        valid?
  #      end
  #
  #    end


  # validates_presence_of :email, :firstname, :lastname, :middlename, :prefix, :sex, :ssn, :homeadd, :state, :zip, :birthdate
  #   validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  #  validates_format_of :firstname, :lastname, :middlename, :preferredname, :city, :state, :occupation, :referal, :familyvisited, :with => /^[a-zA-Z]+$/
  # validates_format_of :zip, :with => /^\d{5}(-?\d{4})?$/
  # validates_format_of :homeph, :workph, :with => /^\d{10}(-?\d{9})?$/
  # validates_format_of :workext, :with => /^\d{4}(-?\d{3})?$/
  #validate :Self_Birthdate
  # validate :validate_lastvisitdate
  # validate :validate_todaydate
  # validate :validate_age
  #
  # def validate_age
  #   age = Date.today.year - birthdate.year
  #   age -= 1 if Date.today < birthdate + age.years # birthdate.month > now.month and birthdate.day > now.day
  #   self.age = age
  # end
  # def validate_todaydate
  # if !todaydate == Date.today
  #   errors.add(:todaydate, "please enter valid date")
  # end
  # end
  # def validate_lastvisitdate
  #   if lastvisitdate >= Date.today
  #     errors.add(:lastvisitdate, "please enter valid date")
  #   end
  # end
  # def selfbirthdate
  #       if selfbirthdate >= Date.today
  #         errors.add(:Self_Birthdate, "please enter valid date")
  #       end
  #   end
  #
  #validates_presence_of :Self_Name_First, :Self_Name_Honorific
  # validates_format_of :Self_Name_First, :Self_Name_Honorific, :with => /^[A-Za-z]+$/ , :unless => "Self_Name_First.blank? or Self_Name_Honorific.blank?"
  # validate :validate_Self_Birthdate
  #     def validate_Self_Birthdate
  #       if !Self_Birthdate.blank? and Self_Birthdate >= Date.today
  #         errors.add(:Self_Birthdate)
  #       end
  #     end


end
