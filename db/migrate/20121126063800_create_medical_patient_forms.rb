class CreateMedicalPatientForms < ActiveRecord::Migration
  def change
    create_table :medical_patient_forms do |t|

      # Patient
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.string :middle_name, :limit => 50
      t.string :address_1, :limit => 50
      t.string :address_2, :limit => 50
      t.string :address_apt, :limit => 50
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
      t.integer :primary_insurance_id, :limit => 25
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
      t.integer :secondary_insurance_id, :limit => 25
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
      t.string :medical_history_previous_illness_illness_4, :limit => 50
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
      t.string :family_history_illnesses_illness_1, :limit => 50
      t.integer :family_history_age_at_diagnosis_1, :limit => 25
      t.string :family_history_illnesses_illness_2, :limit => 50
      t.integer :family_history_age_at_diagnosis_2, :limit => 25
      t.string :family_history_illnesses_illness_3, :limit => 50
      t.integer :family_history_age_at_diagnosis_3, :limit => 25
      t.string :family_history_siblings_1, :limit => 25
      t.integer :family_history_siblings_age_1, :limit => 25
      t.string :family_history_siblings_2, :limit => 25
      t.integer :family_history_siblings_age_2, :limit => 25
      t.string :family_history_siblings_3, :limit => 25
      t.integer :family_history_siblings_age_3, :limit => 25
      t.string :family_history_illnesses_illness_4, :limit => 50
      t.integer :family_history_age_at_diagnosis_4, :limit => 25
      t.string :family_history_illnesses_illness_5, :limit => 50
      t.integer :family_history_age_at_diagnosis_5, :limit => 25

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
      t.integer :social_history_drink, :limit =>10
      t.string :social_history_drink_alcoholic_beverage, :limit =>25


      t.timestamps
    end
  end
end
