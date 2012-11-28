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
      t.boolean :patient_authorization_for_voice_mail

      t.timestamps
    end
  end
end
