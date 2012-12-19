class AddRisingStarsPediatricFieldsToIforms < ActiveRecord::Migration
  def up
    #Patient Information
    add_column :iforms, :patient_other_phone_1, :integer
    add_column :iforms, :patient_other_phone_2, :integer
    add_column :iforms, :patient_other_phone_3, :integer
    add_column :iforms, :patient_previously_siblings_list, :string, :limit => 100

    #Patient/Guardian Information
    add_column :iforms, :patient_guardian_father, :string, :limit => 25
    add_column :iforms, :patient_guardian_father_first_name, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_last_name, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_birth_date, :date
    add_column :iforms, :patient_guardian_father_ssn_1, :integer
    add_column :iforms, :patient_guardian_father_ssn_2, :integer
    add_column :iforms, :patient_guardian_father_ssn_3, :integer
    add_column :iforms, :patient_guardian_father_address_1, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_address_2, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_address_city, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_address_state, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_address_zip, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_employer, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_home_phone_1, :integer
    add_column :iforms, :patient_guardian_father_home_phone_2, :integer
    add_column :iforms, :patient_guardian_father_home_phone_3, :integer
    add_column :iforms, :patient_guardian_father_work_phone_1, :integer
    add_column :iforms, :patient_guardian_father_work_phone_2, :integer
    add_column :iforms, :patient_guardian_father_work_phone_3, :integer
    add_column :iforms, :patient_guardian_father_cell_phone_1, :integer
    add_column :iforms, :patient_guardian_father_cell_phone_2, :integer
    add_column :iforms, :patient_guardian_father_cell_phone_3, :integer
    add_column :iforms, :patient_guardian_father_email, :string, :limit => 50

    add_column :iforms, :patient_guardian_mother, :string, :limit => 25
    add_column :iforms, :patient_guardian_mother_first_name, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_last_name, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_birth_date, :date
    add_column :iforms, :patient_guardian_mother_ssn_1, :integer
    add_column :iforms, :patient_guardian_mother_ssn_2, :integer
    add_column :iforms, :patient_guardian_mother_ssn_3, :integer
    add_column :iforms, :patient_guardian_mother_address_1, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_address_2, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_address_city, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_address_state, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_address_zip, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_employer, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_home_phone_1, :integer
    add_column :iforms, :patient_guardian_mother_home_phone_2, :integer
    add_column :iforms, :patient_guardian_mother_home_phone_3, :integer
    add_column :iforms, :patient_guardian_mother_work_phone_1, :integer
    add_column :iforms, :patient_guardian_mother_work_phone_2, :integer
    add_column :iforms, :patient_guardian_mother_work_phone_3, :integer
    add_column :iforms, :patient_guardian_mother_cell_phone_1, :integer
    add_column :iforms, :patient_guardian_mother_cell_phone_2, :integer
    add_column :iforms, :patient_guardian_mother_cell_phone_3, :integer
    add_column :iforms, :patient_guardian_mother_email, :string, :limit => 50

    #Insurance
    add_column :iforms, :insurance_do_you_have_more_than_one_dental_insurance, :boolean
    add_column :iforms, :insurance_insured, :string, :limt => 20
    add_column :iforms, :insurance_person_first_name, :string, :limit => 50
    add_column :iforms, :insurance_person_last_name, :string, :limit => 50
    add_column :iforms, :insurance_relation_ship_to_patient, :string, :limit => 50
    add_column :iforms, :insurance_employer, :string, :limit => 50
    add_column :iforms, :insurance_company_name, :string, :limit => 50
    add_column :iforms, :insurance_member_id, :string, :limit => 50
    add_column :iforms, :insurance_group, :string, :limit => 50
    add_column :iforms, :insurance_phone_1, :integer
    add_column :iforms, :insurance_phone_2, :integer
    add_column :iforms, :insurance_phone_3, :integer
    add_column :iforms, :insurance_address_1, :string, :limit => 50
    add_column :iforms, :insurance_address_2, :string, :limit => 50
    add_column :iforms, :insurance_address_city, :string, :limit => 50
    add_column :iforms, :insurance_address_state, :string, :limit => 50
    add_column :iforms, :insurance_address_zip, :string, :limit => 50

    #Dental History
    add_column :iforms, :dental_history_why_patient_here_today, :string
    add_column :iforms, :dental_history_patient_first_time_to_visit, :string, :limit => 15
    add_column :iforms, :dental_history_patient_last_visiting_date, :date
    add_column :iforms, :dental_history_patient_behave_today_friendly, :boolean
    add_column :iforms, :dental_history_patient_behave_today_happy, :boolean
    add_column :iforms, :dental_history_patient_behave_today_timid, :boolean
    add_column :iforms, :dental_history_patient_behave_today_afraid, :boolean
    add_column :iforms, :dental_history_patient_behave_today_resistance, :boolean
    add_column :iforms, :dental_history_patient_receive_fluoride_in_any_form, :string, :limit => 15
    add_column :iforms, :dental_history_patient_receive_fluoride_in_any_form_description, :string, :limit => 15
    add_column :iforms, :dental_history_patient_inherited_any_dental_characteristics, :string, :limit => 50
    add_column :iforms, :dental_history_patient_have_any_injuries, :string, :limit => 50

    add_column :iforms, :dental_history_cavities, :boolean
    add_column :iforms, :dental_history_crooked_teeth, :boolean
    add_column :iforms, :dental_history_sensitive_to_hot_or_cold, :boolean
    add_column :iforms, :dental_history_loose_teeth, :boolean

    add_column :iforms, :dental_history_toothache, :boolean
    add_column :iforms, :dental_history_sensitive_to_sweets, :boolean
    add_column :iforms, :dental_history_frequent_headaches, :boolean
    add_column :iforms, :dental_history_teeth_bumped, :boolean

    add_column :iforms, :dental_history_bad_breath, :boolean
    add_column :iforms, :dental_history_patient_bleeding_gums, :boolean
    add_column :iforms, :dental_history_discolored_teeth, :boolean
    add_column :iforms, :dental_history_tmj_popping_or_clicking, :boolean
    add_column :iforms, :dental_history_jaw_pain_from_joint, :boolean

    add_column :iforms, :dental_history_thumb_sucking, :boolean
    add_column :iforms, :dental_history_pacifier_use, :boolean
    add_column :iforms, :dental_history_lip_biting, :boolean
    add_column :iforms, :dental_history_teeth_grinding, :boolean
    add_column :iforms, :dental_history_other, :boolean

    add_column :iforms, :dental_history_does_child_brush_teeth, :string, :limit => 50
    add_column :iforms, :dental_history_does_child_brush_teeth_electric_tooth_brush, :boolean
    add_column :iforms, :dental_history_does_child_flosh_teeth, :string, :limit => 25
    add_column :iforms, :dental_history_age_at_stop_bottle, :string, :limit => 25
    add_column :iforms, :dental_history_age_at_stop_bottle_sippy_cup, :string, :limit => 25

    #Medical History
    add_column :iforms, :medical_history_physician, :string, :limit => 50
    add_column :iforms, :medical_history_address_1, :string, :limit => 50
    add_column :iforms, :medical_history_address_2, :string, :limit => 50
    add_column :iforms, :medical_history_address_city, :string, :limit => 50
    add_column :iforms, :medical_history_address_state, :string, :limit => 50
    add_column :iforms, :medical_history_address_zip, :string, :limit => 50
    add_column :iforms, :medical_history_home_phone_1, :integer
    add_column :iforms, :medical_history_home_phone_2, :integer
    add_column :iforms, :medical_history_home_phone_3, :integer
    add_column :iforms, :medical_history_patient_good_general_health, :boolean
    add_column :iforms, :medical_history_patient_good_general_health_description, :string, :limit => 50
    add_column :iforms, :medical_history_patient_physical_disabilities, :boolean
    add_column :iforms, :medical_history_patient_physical_disabilities_description, :string, :limit => 50
    add_column :iforms, :medical_history_patient_booster_shoot_up_to_date, :boolean
    add_column :iforms, :medical_history_patient_surgical_operations, :boolean
    add_column :iforms, :medical_history_patient_surgical_operations_description, :string, :limit => 50
    add_column :iforms, :medical_history_patient_ever_been_hospitalized, :boolean
    add_column :iforms, :medical_history_patient_ever_been_hospitalized_description, :string, :limit => 50

    add_column :iforms, :medical_history_latex_allergies, :boolean
    add_column :iforms, :medical_history_seasonal_allergies, :boolean
    add_column :iforms, :medical_history_food_allergies, :boolean
    add_column :iforms, :medical_history_drug_allergies, :boolean
    add_column :iforms, :medical_history_food_allergies_description, :string, :limit => 50
    add_column :iforms, :medical_history_drug_allergies_description, :string, :limit => 50

    add_column :iforms, :medical_history_asthama_or_breathing_prob, :string, :limit => 25
    add_column :iforms, :medical_history_er_for_asthma_attack, :string, :limit => 25
    add_column :iforms, :medical_history_asthama_or_breathing_prob_description, :string, :limit => 50
    add_column :iforms, :medical_history_er_for_asthma_attack_description, :string, :limit => 50
    add_column :iforms, :medical_history_induces_breathing_prob, :string, :limit => 50
    add_column :iforms, :medical_history_asthma_medication, :string, :limit => 50

    add_column :iforms, :medical_history_autism_spectrum, :string, :limit => 10
    add_column :iforms, :medical_history_sensory_integration_issues, :string, :limit => 10
    add_column :iforms, :medical_history_add_or_adhd, :string, :limit => 10
    add_column :iforms, :medical_history_heart_trouble_or_heart_murmur, :string, :limit => 10
    add_column :iforms, :medical_history_rheumatic_heart_disease_or_fever, :string, :limit => 10
    add_column :iforms, :medical_history_blood_diseases_or_anemia, :string, :limit => 10
    add_column :iforms, :medical_history_aids_virus, :string, :limit => 10
    add_column :iforms, :medical_history_herpes_virus_or_shingles, :string, :limit => 10
    add_column :iforms, :medical_history_diabetes, :string, :limit => 10
    add_column :iforms, :medical_history_ear_eye_nose_or_throat_trouble, :string, :limit => 10
    add_column :iforms, :medical_history_stomach_ulcers, :string, :limit => 10

    add_column :iforms, :medical_history_hearing_or_vision_impairment, :string, :limit => 10
    add_column :iforms, :medical_history_eating_disorders, :string, :limit => 10
    add_column :iforms, :medical_history_abnormal_bleeding_or_bruising, :string, :limit => 10
    add_column :iforms, :medical_history_prolonged_bleeding_or_transfusions, :string, :limit => 10
    add_column :iforms, :medical_history_birth_defects, :string, :limit => 10
    add_column :iforms, :medical_history_kidney_disease, :string, :limit => 10
    add_column :iforms, :medical_history_cleft_lip_or_palate, :string, :limit => 10
    add_column :iforms, :medical_history_scarlet_fever_or_high_fever, :string, :limit => 10
    add_column :iforms, :medical_history_high_or_low_blood_pressure, :string, :limit => 10
    add_column :iforms, :medical_history_liver_disease, :string, :limit => 10
    add_column :iforms, :medical_history_Jaundice_or_hepatitis, :string, :limit => 10

    add_column :iforms, :medical_history_steroids_therapy_or_chemotherapy, :string, :limit => 10
    add_column :iforms, :medical_history_nervous_or_emotional_disorders, :string, :limit => 10
    add_column :iforms, :medical_history_Convulsions_or_seizures, :string, :limit => 10
    add_column :iforms, :medical_history_date_of_last_seizure, :date
    add_column :iforms, :medical_history_frequent_diarrhea_or_vomiting, :string, :limit => 10
    add_column :iforms, :medical_history_mumps_measles_or_chickenpox, :string, :limit => 10
    add_column :iforms, :medical_history_cancer_tumors_growths_or_cysts, :string, :limit => 10
    add_column :iforms, :medical_history_sinus_problems_or_drainage, :string, :limit => 10
    add_column :iforms, :medical_history_tuberculosis_or_tb_exposure, :string, :limit => 10
    add_column :iforms, :medical_history_problems_with_anesthesia, :string, :limit => 10
    add_column :iforms, :medical_history_thyroid_disease, :string, :limit => 10

    add_column :iforms, :medical_history_current_medication_name_1, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_how_often_1, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_reason_1, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_name_2, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_how_often_2, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_reason_2, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_name_3, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_how_often_3, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_reason_3, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_name_4, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_how_often_4, :string, :limit => 50
    add_column :iforms, :medical_history_current_medication_reason_4, :string, :limit => 50

    #Social History
    add_column :iforms, :social_history_patient_have_problems_speech, :boolean
    add_column :iforms, :social_history_patient_have_problems_hearing, :boolean
    add_column :iforms, :social_history_patient_have_problems_vision, :boolean
    add_column :iforms, :social_history_patient_have_problems_sleep, :boolean

    add_column :iforms, :social_history_patient_is_adv_in_learning, :boolean
    add_column :iforms, :social_history_patient_is_progressing_normally, :boolean
    add_column :iforms, :social_history_patient_is_slow_learner, :boolean

    add_column :iforms, :social_history_patient_first_lang, :string, :limit => 50
    add_column :iforms, :social_history_patient_second_lang, :string, :limit => 50

    add_column :iforms, :social_history_patient_adopted, :string, :limit => 5
    add_column :iforms, :social_history_patient_adopted_age, :string, :limit => 20
    add_column :iforms, :social_history_patient_tolerate, :string, :limit => 50
    add_column :iforms, :social_history_patient_favorites, :string, :limit => 50
  end

  def down
    #Patient
    remove_column :iforms, :patient_other_phone_1
    remove_column :iforms, :patient_other_phone_2
    remove_column :iforms, :patient_other_phone_3
    remove_column :iforms, :patient_previously_siblings_list

    #Patient/Guardian Information
    remove_column :iforms, :patient_guardian_father
    remove_column :iforms, :patient_guardian_father_first_name
    remove_column :iforms, :patient_guardian_father_last_name
    remove_column :iforms, :patient_guardian_father_birth_date
    remove_column :iforms, :patient_guardian_father_ssn_1
    remove_column :iforms, :patient_guardian_father_ssn_2
    remove_column :iforms, :patient_guardian_father_ssn_3
    remove_column :iforms, :patient_guardian_father_address_1
    remove_column :iforms, :patient_guardian_father_address_2
    remove_column :iforms, :patient_guardian_father_address_city
    remove_column :iforms, :patient_guardian_father_address_state
    remove_column :iforms, :patient_guardian_father_address_zip
    remove_column :iforms, :patient_guardian_father_employer
    remove_column :iforms, :patient_guardian_father_home_phone_1
    remove_column :iforms, :patient_guardian_father_home_phone_2
    remove_column :iforms, :patient_guardian_father_home_phone_3
    remove_column :iforms, :patient_guardian_father_work_phone_1
    remove_column :iforms, :patient_guardian_father_work_phone_2
    remove_column :iforms, :patient_guardian_father_work_phone_3
    remove_column :iforms, :patient_guardian_father_cell_phone_1
    remove_column :iforms, :patient_guardian_father_cell_phone_2
    remove_column :iforms, :patient_guardian_father_cell_phone_3
    remove_column :iforms, :patient_guardian_father_email

    remove_column :iforms, :patient_guardian_mother
    remove_column :iforms, :patient_guardian_mother_first_name
    remove_column :iforms, :patient_guardian_mother_last_name
    remove_column :iforms, :patient_guardian_mother_birth_date
    remove_column :iforms, :patient_guardian_mother_ssn_1
    remove_column :iforms, :patient_guardian_mother_ssn_2
    remove_column :iforms, :patient_guardian_mother_ssn_3
    remove_column :iforms, :patient_guardian_mother_address_1
    remove_column :iforms, :patient_guardian_mother_address_2
    remove_column :iforms, :patient_guardian_mother_address_city
    remove_column :iforms, :patient_guardian_mother_address_state
    remove_column :iforms, :patient_guardian_mother_address_zip
    remove_column :iforms, :patient_guardian_mother_employer
    remove_column :iforms, :patient_guardian_mother_home_phone_1
    remove_column :iforms, :patient_guardian_mother_home_phone_2
    remove_column :iforms, :patient_guardian_mother_home_phone_3
    remove_column :iforms, :patient_guardian_mother_work_phone_1
    remove_column :iforms, :patient_guardian_mother_work_phone_2
    remove_column :iforms, :patient_guardian_mother_work_phone_3
    remove_column :iforms, :patient_guardian_mother_cell_phone_1
    remove_column :iforms, :patient_guardian_mother_cell_phone_2
    remove_column :iforms, :patient_guardian_mother_cell_phone_3
    remove_column :iforms, :patient_guardian_mother_email

    #Insurance
    remove_column :iforms, :insurance_do_you_have_more_than_one_dental_insurance
    remove_column :iforms, :insurance_insured
    remove_column :iforms, :insurance_person_first_name
    remove_column :iforms, :insurance_person_last_name
    remove_column :iforms, :insurance_relation_ship_to_patient
    remove_column :iforms, :insurance_place_of_employer
    remove_column :iforms, :insurance_member_id
    remove_column :iforms, :insurance_company_name
    remove_column :iforms, :insurance_phone_1
    remove_column :iforms, :insurance_phone_2
    remove_column :iforms, :insurance_phone_3
    remove_column :iforms, :insurance_group
    remove_column :iforms, :insurance_address_1
    remove_column :iforms, :insurance_address_2
    remove_column :iforms, :insurance_address_city
    remove_column :iforms, :insurance_address_state
    remove_column :iforms, :insurance_address_zip

    #Dental History
    remove_column :iforms, :dental_history_why_patient_here_today
    remove_column :iforms, :dental_history_patient_first_time_to_visit
    remove_column :iforms, :dental_history_patient_last_visiting_date
    remove_column :iforms, :dental_history_patient_behave_today_friendly
    remove_column :iforms, :dental_history_patient_behave_today_happy
    remove_column :iforms, :dental_history_patient_behave_today_timid
    remove_column :iforms, :dental_history_patient_behave_today_afraid
    remove_column :iforms, :dental_history_patient_behave_today_resistance
    remove_column :iforms, :dental_history_patient_receive_fluoride_in_any_form
    remove_column :iforms, :dental_history_patient_receive_fluoride_in_any_form_description
    remove_column :iforms, :dental_history_patient_inherited_any_dental_characteristics
    remove_column :iforms, :dental_history_patient_have_any_injuries

    remove_column :iforms, :dental_history_cavities
    remove_column :iforms, :dental_history_crooked_teeth
    remove_column :iforms, :dental_history_sensitive_to_hot_or_cold
    remove_column :iforms, :dental_history_loose_teeth

    remove_column :iforms, :dental_history_toothache
    remove_column :iforms, :dental_history_sensitive_to_sweets
    remove_column :iforms, :dental_history_frequent_headaches
    remove_column :iforms, :dental_history_teeth_bumped

    remove_column :iforms, :dental_history_bad_breath
    remove_column :iforms, :dental_history_patient_bleeding_gums
    remove_column :iforms, :dental_history_discolored_teeth
    remove_column :iforms, :dental_history_tmj_popping_or_clicking
    remove_column :iforms, :dental_history_jaw_pain_from_joint

    remove_column :iforms, :dental_history_thumb_sucking
    remove_column :iforms, :dental_history_pacifier_use
    remove_column :iforms, :dental_history_lip_biting
    remove_column :iforms, :dental_history_teeth_grinding
    remove_column :iforms, :dental_history_other

    remove_column :iforms, :dental_history_does_child_brush_teeth
    remove_column :iforms, :dental_history_does_child_brush_teeth_electric_tooth_brush
    remove_column :iforms, :dental_history_does_child_flosh_teeth
    remove_column :iforms, :dental_history_age_at_stop_bottle
    remove_column :iforms, :dental_history_age_at_stop_bottle_sippy_cup

    #Medical History
    remove_column :iforms, :medical_history_physician
    remove_column :iforms, :medical_history_address_1
    remove_column :iforms, :medical_history_address_2
    remove_column :iforms, :medical_history_address_city
    remove_column :iforms, :medical_history_address_state
    remove_column :iforms, :medical_history_address_zip
    remove_column :iforms, :medical_history_home_phone_1
    remove_column :iforms, :medical_history_home_phone_2
    remove_column :iforms, :medical_history_home_phone_3
    remove_column :iforms, :medical_history_patient_good_general_health
    remove_column :iforms, :medical_history_patient_good_general_health_description
    remove_column :iforms, :medical_history_patient_physical_disabilities
    remove_column :iforms, :medical_history_patient_physical_disabilities_description
    remove_column :iforms, :medical_history_patient_booster_shoot_up_to_date
    remove_column :iforms, :medical_history_patient_surgical_operations
    remove_column :iforms, :medical_history_patient_surgical_operations_description
    remove_column :iforms, :medical_history_patient_ever_been_hospitalized
    remove_column :iforms, :medical_history_patient_ever_been_hospitalized_description

    remove_column :iforms, :medical_history_latex_allergies
    remove_column :iforms, :medical_history_seasonal_allergies
    remove_column :iforms, :medical_history_food_allergies
    remove_column :iforms, :medical_history_drug_allergies
    remove_column :iforms, :medical_history_food_allergies_description
    remove_column :iforms, :medical_history_drug_allergies_description

    remove_column :iforms, :medical_history_asthama_or_breathing_prob
    remove_column :iforms, :medical_history_er_for_asthma_attack, :string
    remove_column :iforms, :medical_history_asthama_or_breathing_prob_description
    remove_column :iforms, :medical_history_er_for_asthma_attack_description
    remove_column :iforms, :medical_history_induces_breathing_prob
    remove_column :iforms, :medical_history_asthma_medication

    remove_column :iforms, :medical_history_autism_spectrum
    remove_column :iforms, :medical_history_sensory_integration_issues
    remove_column :iforms, :medical_history_add_or_adhd
    remove_column :iforms, :medical_history_heart_trouble_or_heart_murmur
    remove_column :iforms, :medical_history_rheumatic_heart_disease_or_fever
    remove_column :iforms, :medical_history_blood_diseases_or_anemia
    remove_column :iforms, :medical_history_aids_virus
    remove_column :iforms, :medical_history_herpes_virus_or_shingles
    remove_column :iforms, :medical_history_diabetes
    remove_column :iforms, :medical_history_ear_eye_nose_or_throat_trouble
    remove_column :iforms, :medical_history_stomach_ulcers

    remove_column :iforms, :medical_history_hearing_or_vision_impairment
    remove_column :iforms, :medical_history_eating_disorders
    remove_column :iforms, :medical_history_abnormal_bleeding_or_bruising
    remove_column :iforms, :medical_history_prolonged_bleeding_or_transfusions
    remove_column :iforms, :medical_history_birth_defects
    remove_column :iforms, :medical_history_kidney_disease
    remove_column :iforms, :medical_history_cleft_lip_or_palate
    remove_column :iforms, :medical_history_scarlet_fever_or_high_fever
    remove_column :iforms, :medical_history_high_or_low_blood_pressure
    remove_column :iforms, :medical_history_liver_disease
    remove_column :iforms, :medical_history_Jaundice_or_hepatitis

    remove_column :iforms, :medical_history_steroids_therapy_or_chemotherapy
    remove_column :iforms, :medical_history_nervous_or_emotional_disorders
    remove_column :iforms, :medical_history_Convulsions_or_seizures
    remove_column :iforms, :medical_history_date_of_last_seizure, :date
    remove_column :iforms, :medical_history_frequent_diarrhea_or_vomiting
    remove_column :iforms, :medical_history_mumps_measles_or_chickenpox
    remove_column :iforms, :medical_history_cancer_tumors_growths_or_cysts
    remove_column :iforms, :medical_history_sinus_problems_or_drainage
    remove_column :iforms, :medical_history_tuberculosis_or_tb_exposure
    remove_column :iforms, :medical_history_problems_with_anesthesia
    remove_column :iforms, :medical_history_thyroid_disease

    remove_column :iforms, :medical_history_current_medication_name_1
    remove_column :iforms, :medical_history_current_medication_how_often_1
    remove_column :iforms, :medical_history_current_medication_reason_1
    remove_column :iforms, :medical_history_current_medication_name_2
    remove_column :iforms, :medical_history_current_medication_how_often_2
    remove_column :iforms, :medical_history_current_medication_reason_2
    remove_column :iforms, :medical_history_current_medication_name_3
    remove_column :iforms, :medical_history_current_medication_how_often_3
    remove_column :iforms, :medical_history_current_medication_reason_3
    remove_column :iforms, :medical_history_current_medication_name_4
    remove_column :iforms, :medical_history_current_medication_how_often_4
    remove_column :iforms, :medical_history_current_medication_reason_4

    # Social History
    remove_column :iforms, :social_history_patient_have_problems_speech
    remove_column :iforms, :social_history_patient_have_problems_hearing
    remove_column :iforms, :social_history_patient_have_problems_vision
    remove_column :iforms, :social_history_patient_have_problems_sleep

    remove_column :iforms, :social_history_patient_is_adv_in_learning
    remove_column :iforms, :social_history_patient_is_progressing_normally
    remove_column :iforms, :social_history_patient_is_slow_learner

    remove_column :iforms, :social_history_patient_first_lang
    remove_column :iforms, :social_history_patient_second_lang

    remove_column :iforms, :social_history_patient_adopted
    remove_column :iforms, :social_history_patient_adopted_age
    remove_column :iforms, :social_history_patient_tolerate
    remove_column :iforms, :social_history_patient_favorites

  end
end
