class CreateMedicalPatientForms < ActiveRecord::Migration
  def change
    create_table :medical_patient_forms do |t|

      t.integer :service_provider_id
      t.integer :medical_appointment_id
      t.integer :doctor_user_id
      t.integer :patient_user_id
      # Patient
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.string :middle_name, :limit => 50
      t.string :address_1, :limit => 50
      t.string :address_2, :limit => 50
      t.string :address_city, :limit => 50
      t.string :address_state, :limit => 50
      t.integer :address_zip, :limit => 10
      t.integer :home_phone_1, :limit => 5
      t.integer :home_phone_2, :limit => 5
      t.integer :home_phone_3, :limit => 5
      t.integer :work_phone_1, :limit => 5
      t.integer :work_phone_2, :limit => 5
      t.integer :work_phone_3, :limit => 5
      t.integer :cell_phone_1, :limit => 5
      t.integer :cell_phone_2, :limit => 5
      t.integer :cell_phone_3, :limit => 5
      t.string :sex, :limit => 10
      t.date :birth_date
      t.string :marital_status, :limit => 15
      t.integer :ssn_1, :limit => 5
      t.integer :ssn_2, :limit => 5
      t.integer :ssn_3, :limit => 5
      t.string :referred_to_our_office_by,:limit => 25
      t.string :referral_name,:limit => 25

      #Employer
      t.string :employer, :limit => 50
      t.string :employer_occupation, :limit => 50
      t.string :employer_address_1, :limit => 50
      t.string :employer_address_2, :limit => 50
      t.string :employer_address_city, :limit => 50
      t.string :employer_address_state, :limit => 50
      t.integer :employer_address_zip, :limit => 10

      #spouse
      t.string :spouse_first_name, :limit => 50
      t.string :spouse_last_name, :limit => 50
      t.integer :spouse_home_phone_1, :limit => 5
      t.integer :spouse_home_phone_2, :limit => 5
      t.integer :spouse_home_phone_3, :limit => 5
      t.integer :spouse_work_phone_1, :limit => 5
      t.integer :spouse_work_phone_2, :limit => 5
      t.integer :spouse_work_phone_3, :limit => 5

      #emergency contact
      t.string :emergency_contact_first_name, :limit => 50
      t.string :emergency_contact_last_name, :limit => 50
      t.string :emergency_contact_relationship, :limit => 50
      t.integer :emergency_contact_phone_1, :limit => 5
      t.integer :emergency_contact_phone_2, :limit => 5
      t.integer :emergency_contact_phone_3, :limit => 5
      t.string :emergency_contact_who_referred_you, :limit => 50

      # Insurance-Primary
      t.string :primary_insurance_company_name, :limit => 50
      t.string :primary_insurance_address_1, :limit => 50
      t.string :primary_insurance_address_2, :limit => 50
      t.string :primary_insurance_address_city, :limit => 50
      t.string :primary_insurance_address_state, :limit => 50
      t.string :primary_insurance_address_zip, :limit => 50
      t.integer :primary_insurance_phone_1, :limit => 5
      t.integer :primary_insurance_phone_2, :limit => 5
      t.integer :primary_insurance_phone_3, :limit => 5
      t.string :primary_insurance_id, :limit => 25
      t.string :primary_insurance_group, :limit => 50
      t.string :primary_insurance_policy_holder, :limit => 10
      t.string :primary_insurance_policy_holder_first_name, :limit => 50
      t.string :primary_insurance_policy_holder_last_name, :limit => 50
      t.string :primary_insurance_relationship, :limit => 50
      t.date :primary_insurance_birth_date
      t.integer :primary_insurance_ssn_1, :limit => 5
      t.integer :primary_insurance_ssn_2, :limit => 5
      t.integer :primary_insurance_ssn_3, :limit => 5
      t.string :primary_insurance_policy_holder_employer, :limit => 50

      # Insurance-Secondary
      t.string :secondary_insurance_company_name, :limit => 50
      t.string :secondary_insurance_address_1, :limit => 50
      t.string :secondary_insurance_address_2, :limit => 50
      t.string :secondary_insurance_address_city, :limit => 50
      t.string :secondary_insurance_address_state, :limit => 50
      t.integer :secondary_insurance_address_zip, :limit => 15
      t.integer :secondary_insurance_phone_1, :limit => 5
      t.integer :secondary_insurance_phone_2, :limit => 5
      t.integer :secondary_insurance_phone_3, :limit => 5
      t.string :secondary_insurance_id, :limit => 25
      t.string :secondary_insurance_group, :limit => 50
      t.string :secondary_insurance_policy_holder, :limit => 10
      t.string :secondary_insurance_policy_holder_first_name, :limit => 50
      t.string :secondary_insurance_policy_holder_last_name, :limit => 50
      t.string :secondary_insurance_relationship, :limit => 50
      t.date :secondary_insurance_birth_date
      t.integer :secondary_insurance_ssn_1, :limit => 5
      t.integer :secondary_insurance_ssn_2, :limit => 5
      t.integer :secondary_insurance_ssn_3, :limit => 5
      t.string :secondary_insurance_policy_holder_employer, :limit => 50

      # Patient Consent
      t.string :patient_consent_first_name_1, :limit => 50
      t.string :patient_consent_last_name_1, :limit => 50
      t.string :patient_consent_relation_ship_to_patient_1, :limit => 50
      t.string :patient_consent_first_name_2, :limit => 50
      t.string :patient_consent_last_name_2, :limit => 50
      t.string :patient_consent_relation_ship_to_patient_2, :limit => 50
      t.string :patient_consent_first_name_3, :limit => 50
      t.string :patient_consent_last_name_3, :limit => 50
      t.string :patient_consent_relation_ship_to_patient_3, :limit => 50
      t.string :patient_authorization_for_voice_mail,:limit => 25

      #Medical History
      t.string :medical_history_reason_for_visit_1, :limit => 50
      t.string :medical_history_reason_for_visit_2, :limit => 50
      t.string :medical_history_reason_for_visit_3, :limit => 50
      t.string :medical_history_specialist_1, :limit => 50
      t.string :medical_history_speciality_1, :limit => 50
      t.string :medical_history_specialist_2, :limit => 50
      t.string :medical_history_speciality_2, :limit => 50
      t.string :medical_history_specialist_3, :limit => 50
      t.string :medical_history_speciality_3, :limit => 50
      t.string :medical_history_specialist_4, :limit => 50
      t.string :medical_history_speciality_4, :limit => 50
      t.string :medical_history_medication_medication_1, :limit => 50
      t.string :medical_history_medication_dosage_1, :limit => 50
      t.string :medical_history_medication_times_per_day_1, :limit => 50
      t.string :medical_history_medication_medication_2, :limit => 50
      t.string :medical_history_medication_dosage_2, :limit => 50
      t.string :medical_history_medication_times_per_day_2, :limit => 50
      t.string :medical_history_medication_medication_3, :limit => 50
      t.string :medical_history_medication_dosage_3, :limit => 50
      t.string :medical_history_medication_times_per_day_3, :limit => 50
      t.string :medical_history_medication_medication_4, :limit => 50
      t.string :medical_history_medication_dosage_4, :limit => 50
      t.string :medical_history_medication_times_per_day_4, :limit => 50
      t.string :medical_history_medication_medication_5, :limit => 50
      t.string :medical_history_medication_dosage_5, :limit => 50
      t.string :medical_history_medication_times_per_day_5, :limit => 50
      t.string :medical_history_medication_medication_6, :limit => 50
      t.string :medical_history_medication_dosage_6, :limit => 50
      t.string :medical_history_medication_times_per_day_6, :limit => 50
      t.string :medical_history_medication_medication_7, :limit => 50
      t.string :medical_history_medication_dosage_7, :limit => 50
      t.string :medical_history_medication_times_per_day_7, :limit => 50
      t.string :medical_history_medication_allergies_medication_1, :limit => 50
      t.string :medical_history_medication_allergies_reaction_1, :limit => 50
      t.string :medical_history_medication_allergies_medication_2, :limit => 50
      t.string :medical_history_medication_allergies_reaction_2, :limit => 50
      t.string :medical_history_medication_allergies_medication_3, :limit => 50
      t.string :medical_history_medication_allergies_reaction_3, :limit => 50
      t.string :medical_history_operations_operation_1, :limit => 50
      t.date :medical_history_operations_operation_date_1
      t.string :medical_history_operations_operation_2, :limit => 50
      t.date :medical_history_operations_operation_date_2
      t.string :medical_history_operations_operation_3, :limit => 50
      t.date :medical_history_operations_operation_date_3
      t.string :medical_history_operations_operation_4, :limit => 50
      t.date :medical_history_operations_operation_date_4
      t.string :medical_history_operations_operation_5, :limit => 50
      t.date :medical_history_operations_operation_date_5
      t.string :medical_history_operations_operation_6, :limit => 50
      t.date :medical_history_operations_operation_date_6
      t.string :medical_history_operations_operation_1, :limit => 50
      t.date :medical_history_operations_operation_date_1
      t.string :medical_history_operations_operation_2, :limit => 50
      t.date :medical_history_operations_operation_date_2
      t.string :medical_history_previous_illnesses_illness_1, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_1
      t.string :medical_history_previous_illnesses_illness_2, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_2
      t.string :medical_history_previous_illnesses_illness_3, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_3
      t.string :medical_history_previous_illnesses_illness_4, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_4
      t.string :medical_history_previous_illnesses_illness_5, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_5
      t.string :medical_history_previous_illnesses_illness_6, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_6
      t.string :medical_history_previous_illnesses_illness_7, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_7
      t.string :medical_history_previous_illnesses_illness_8, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_8
      t.string :medical_history_previous_illnesses_illness_9, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_9
      t.string :medical_history_previous_illnesses_illness_10, :limit => 50
      t.date :medical_history_previous_illnesses_diagnosis_10

      #Family History
      t.integer :family_history_mother_age, :limit => 25
      t.string :family_history_mother_living_or_deceased, :limit => 25
      t.integer :family_history_father_age, :limit => 25
      t.string :family_history_father_living_or_deceased, :limit => 25
      t.string :family_history_illnesses_mother_illness_1, :limit => 50
      t.integer :family_history_illnesses_mother_age_at_diagnosis_1, :limit => 25
      t.string :family_history_illnesses_mother_illness_2, :limit => 50
      t.integer :family_history_illnesses_mother_age_at_diagnosis_2, :limit => 25
      t.string :family_history_illnesses_mother_illness_3, :limit => 50
      t.integer :family_history_illnesses_mother_age_at_diagnosis_3, :limit => 25
      t.string :family_history_illnesses_father_illness_1, :limit => 50
      t.integer :family_history_illnesses_father_age_at_diagnosis_1, :limit => 25
      t.string :family_history_illnesses_father_illness_2, :limit => 50
      t.integer :family_history_illnesses_father_age_at_diagnosis_2, :limit => 25
      t.string :family_history_illnesses_father_illness_3, :limit => 50
      t.integer :family_history_illnesses_father_age_at_diagnosis_3, :limit => 25
      t.string :family_history_siblings_1, :limit => 25
      t.string :family_history_siblings_living_deceased_1, :limit => 25
      t.string :family_history_siblings_1_illness_1, :limit => 50
      t.string :family_history_siblings_1_illness_2, :limit => 50
      t.integer :family_history_siblings_age_1, :limit => 25
      t.string :family_history_siblings_2, :limit => 25
      t.string :family_history_siblings_living_deceased_2, :limit => 25
      t.string :family_history_siblings_2_illness_1, :limit => 50
      t.string :family_history_siblings_2_illness_2, :limit => 50
      t.integer :family_history_siblings_age_2, :limit => 25
      t.string :family_history_siblings_3, :limit => 25
      t.string :family_history_siblings_living_deceased_3, :limit => 25
      t.string :family_history_siblings_3_illness_1, :limit => 50
      t.string :family_history_siblings_3_illness_2, :limit => 50
      t.integer :family_history_siblings_age_3, :limit => 25

     #Social History
      t.string :social_history_live, :limit => 15
      t.string :social_history_live_with_whom, :limit => 50
      t.integer :social_history_no_of_children, :limit => 15
      t.string :social_history_age_of_children, :limit => 15
      t.string :social_history_exercise_approximately, :limit => 50
      t.integer :social_history_ex_minutes_per_day, :limit => 15
      t.string :social_history_exercise_type, :limit => 50
      t.string :social_history_hobbies, :limit => 50
      t.string :social_history_smoking_tobacco, :limit => 50
      t.integer :social_history_smoking_packs_per_day, :limit => 10
      t.string :social_history_smoking_no_of_years, :limit => 50
      t.string :social_history_smoking_quit_years, :limit => 50
      t.integer :social_history_drink, :limit =>10
      t.string :social_history_drink_alcoholic_beverage, :limit =>25
      t.string :social_history_have_used_recreational_drugs, :limit =>25
      t.string :social_history_yes_i_have_used_recreational_drugs, :limit =>50
      t.string :social_history_have_recently_traveled, :limit =>25
      t.string :social_history_yes_i_recently_traveled, :limit =>50

      #Review Of System
      t.boolean :review_of_sym_general_fatigue
      t.boolean :review_of_sym_general_fever
      t.boolean :review_of_sym_general_night_sweats
      t.boolean :review_of_sym_general_heat_or_cold
      t.string :review_of_sym_i_have, :limit =>25
      t.string :review_of_sym_i_have_many_pounds, :limit =>25
      t.string :review_of_sym_i_have_time_periods, :limit =>25
      t.boolean :review_of_sym_skin_rash
      t.boolean :review_of_sym_skin_hair_loss
      t.boolean :review_of_sym_skin_easy_bruising
      t.boolean :review_of_sym_skin_toenail_inflection
      t.boolean :review_of_sym_eye_redness
      t.boolean :review_of_sym_eye_pain
      t.boolean :review_of_sym_eye_discharge
      t.boolean :review_of_sym_eye_dryness
      t.boolean :review_of_sym_eye_visual_changes
      t.boolean :review_of_sym_nose_bleed
      t.boolean :review_of_sym_nose_nasal_discharge
      t.boolean :review_of_sym_nose_sinus_pain
      t.boolean :review_of_sym_nose_sinus_congestion
      t.boolean :review_of_sym_mouth_oral_lesions
      t.boolean :review_of_sym_mouth_white_patches
      t.boolean :review_of_sym_mouth_bleeding_gums
      t.boolean :review_of_sym_mouth_toothache
      t.boolean :review_of_sym_throat_hoarseness
      t.boolean :review_of_sym_throat_sore_throat
      t.boolean :review_of_sym_throat_pain_with_swallowing
      t.boolean :review_of_sym_throat_difficultly_swallowing
      t.boolean :review_of_sym_respiratory_cough
      t.boolean :review_of_sym_respiratory_coughing_blood
      t.boolean :review_of_sym_respiratory_shortness_of_breath_at_rest
      t.boolean :review_of_sym_respiratory_shortness_of_breath_on_exertion
      t.boolean :review_of_sym_respiratory_wheezing
      t.boolean :review_of_sym_cardiovascular_chest_discomfort
      t.boolean :review_of_sym_cardiovascular_palpitations
      t.boolean :review_of_sym_cardiovascular_ankle_swelling
      t.boolean :review_of_sym_cardiovascular_fast_heart_beat
      t.boolean :review_of_sym_cardiovascular_difficulty_breathing
      t.boolean :review_of_sym_cardiovascular_awakening_short_of_breath
      t.boolean :review_of_sym_urinary_pain_with_urination
      t.boolean :review_of_sym_urinary_urinating_frequently
      t.boolean :review_of_sym_urinary_incontinence
      t.boolean :review_of_sym_urinary_urinating_before_bathroom
      t.boolean :review_of_sym_urinary_urination_at_night
      t.boolean :review_of_sym_urinary_difficulty_starting_a_urine_stream
      t.boolean :review_of_sym_urinary_blood_in_urine
      t.boolean :review_of_sym_gastrointestinal_nausea
      t.boolean :review_of_sym_gastrointestinal_diarrhea
      t.boolean :review_of_sym_gastrointestinal_blood_in_the_stool
      t.boolean :review_of_sym_gastrointestinal_black_tarry_stool
      t.boolean :review_of_sym_gastrointestinal_heartburn
      t.boolean :review_of_sym_gastrointestinal_constipation
      t.boolean :review_of_sym_sexual_decreased_libido
      t.boolean :review_of_sym_sexual_difficulty_achieving_and_maintaining
      t.boolean :review_of_sym_musculoskeletal_joint_pain_or_stiffness
      t.boolean :review_of_sym_musculoskeletal_joint_swelling_or_redness
      t.boolean :review_of_sym_musculoskeletal_back_pain
      t.boolean :review_of_sym_musculoskeletal_muscle_pain
      t.string :review_of_sym_joints_that_are_painful_or_stiff, :limit => 50
      t.string :review_of_sym_joints_that_are_swelling_or_have_redness, :limit => 50
      t.boolean :review_of_sym_neurological_difficulty_with_memory
      t.boolean :review_of_sym_neurological_fainting
      t.boolean :review_of_sym_neurological_weakness
      t.string :review_of_sym_neurological_weakness_which_part_of_body, :limit => 50
      t.boolean :review_of_sym_neurological_muscle_painSeizures
      t.boolean :review_of_sym_neurological_severe_or_frequent_headaches
      t.boolean :review_of_sym_neurological_difficulty_with_balance
      t.boolean :review_of_sym_neurological_difficulty_walking
      t.boolean :review_of_sym_neurological_lightheadedness
      t.boolean :review_of_sym_neurological_vertigo
      t.boolean :review_of_sym_psychological_depression
      t.boolean :review_of_sym_psychological_lack_of_interest
      t.boolean :review_of_sym_psychological_decreased_sense_of_self_worth
      t.boolean :review_of_sym_psychological_difficulty_focusing
      t.boolean :review_of_sym_psychological_desire_to_end_your_life
      t.boolean :review_of_sym_psychological_disabling_anxiety
      t.boolean :review_of_sym_psychological_panic_attacks
      t.boolean :review_of_sym_sleep_difficulty_getting_to_sleep
      t.boolean :review_of_sym_sleep_difficulty_difficulty_staying_asleep
      t.boolean :review_of_sym_sleep_difficulty_snoring
      t.boolean :review_of_sym_sleep_difficulty_cessation_of_breathing

      #Health Maintenance
      t.date :health_maintenance_bone_density_test
      t.date :health_maintenance_skin_cancer_screening
      t.date :health_maintenance_test_date
      t.string :health_maintenance_total_cholesterol, :limit => 50
      t.string :health_maintenance_LDL, :limit => 50
      t.string :health_maintenance_HDL, :limit => 50
      t.string :health_maintenance_triglycerides, :limit => 50
      t.date :health_maintenance_most_recent_tetanus_vaccine_booster
      t.date :health_maintenance_shingles_vaccine
      t.date :health_maintenance_pneumovax
      t.date :health_maintenance_flu_vaccine
      t.date :health_maintenance_colonoscopy
      t.string :health_maintenance_colonoscopy_test_results, :limit => 25
      t.string :health_maintenance_description_of_abnormal_test_results, :limit => 50
      t.date :health_maintenance_most_recent_mammogram
      t.date :health_maintenance_most_recent_pap_smear
      t.date :health_maintenance_abnormal_pap_smear
      t.date :health_maintenance_hysterectomy
      t.string :health_maintenance_why_was_hysterectomy_performed, :limit => 50
      t.date :health_maintenance_digital_rectal_exam_and_psa_checked

      t.timestamps
    end
  end
end
