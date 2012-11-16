class AddKarnelNaplesFieldsToIforms < ActiveRecord::Migration
  def up
    add_column :iforms, :ssn_1, :integer
    add_column :iforms, :ssn_2, :integer
    add_column :iforms, :ssn_3, :integer
    add_column :iforms, :best_number_to_reach, :string
    add_column :iforms, :person_responsible_for_ac, :string
    add_column :iforms, :smile_evaluation_whiteness , :string
    add_column :iforms, :smile_evaluation_staining , :string
    add_column :iforms, :smile_evaluation_alignment_of_test , :string
    add_column :iforms, :smile_evaluation_chipping , :string
    add_column :iforms, :smile_evaluation_existing_dental_work , :string
    add_column :iforms, :smile_evaluation_gum_health , :string
    add_column :iforms, :smile_evaluation_smile_line , :string
    add_column :iforms, :anything_else_about_smile, :string
    add_column :iforms, :home_phone_1, :integer
    add_column :iforms, :home_phone_2, :integer
    add_column :iforms, :home_phone_3, :integer
    add_column :iforms, :work_phone_1, :integer
    add_column :iforms, :work_phone_2, :integer
    add_column :iforms, :work_phone_3, :integer
    add_column :iforms, :cell_phone_1, :integer
    add_column :iforms, :cell_phone_2, :integer
    add_column :iforms, :cell_phone_3, :integer
    add_column :iforms, :employer_phone_1, :integer
    add_column :iforms, :employer_phone_2, :integer
    add_column :iforms, :employer_phone_3, :integer
    add_column :iforms, :emergency_contact_phone_1, :integer
    add_column :iforms, :emergency_contact_phone_2, :integer
    add_column :iforms, :emergency_contact_phone_3, :integer
    add_column :iforms, :how_did_you_hear_about_office, :string
    add_column :iforms, :relationship_to_patient, :string
    add_column :iforms, :billing_details_first_name, :string
    add_column :iforms, :billing_details_last_name, :string
    add_column :iforms, :billing_details_address1, :string
    add_column :iforms, :billing_details_address2, :string
    add_column :iforms, :billing_details_address_city, :string
    add_column :iforms, :billing_details_address_state, :string
    add_column :iforms, :billing_details_address_postal_code, :string
    add_column :iforms, :billing_details_home_phone_1, :integer
    add_column :iforms, :billing_details_home_phone_2, :integer
    add_column :iforms, :billing_details_home_phone_3, :integer
    add_column :iforms, :billing_details_work_phone_1, :integer
    add_column :iforms, :billing_details_work_phone_2, :integer
    add_column :iforms, :billing_details_work_phone_3, :integer
    add_column :iforms, :billing_details_cell_phone_1, :integer
    add_column :iforms, :billing_details_cell_phone_2, :integer
    add_column :iforms, :billing_details_cell_phone_3, :integer
    add_column :iforms, :billing_details_ssn, :integer
    add_column :iforms, :billing_details_driving_licence_number, :integer
    add_column :iforms, :billing_details_driving_licence_state, :string
    add_column :iforms, :billing_details_employer_name, :string
    add_column :iforms, :billing_details_employer_address1, :string
    add_column :iforms, :billing_details_employer_address2, :string
    add_column :iforms, :billing_details_employer_address_city, :string
    add_column :iforms, :billing_details_employer_address_state, :string
    add_column :iforms, :billing_details_employer_address_postal_code, :string
    add_column :iforms, :billing_details_employer_phone_1, :integer
    add_column :iforms, :billing_details_employer_phone_2, :integer
    add_column :iforms, :billing_details_employer_phone_3, :integer
  end

  def down
    remove_column :iforms, :ssn_1
    remove_column :iforms, :ssn_2
    remove_column :iforms, :ssn_3
    remove_column :iforms, :best_number_to_reach
    remove_column :iforms, :person_responsible_for_ac
    remove_column :iforms, :smile_evaluation_staining
    remove_column :iforms, :smile_evaluation_alignment_of_test
    remove_column :iforms, :smile_evaluation_chipping
    remove_column :iforms, :smile_evaluation_existing_dental_work
    remove_column :iforms, :smile_evaluation_gum_health
    remove_column :iforms, :smile_evaluation_smile_line
    remove_column :iforms, :anything_else_about_smile
    remove_column :iforms, :home_phone_1
    remove_column :iforms, :home_phone_2
    remove_column :iforms, :home_phone_3
    remove_column :iforms, :work_phone_1
    remove_column :iforms, :work_phone_2
    remove_column :iforms, :work_phone_3
    remove_column :iforms, :cell_phone_1
    remove_column :iforms, :cell_phone_2
    remove_column :iforms, :cell_phone_3
    remove_column :iforms, :employer_phone_1
    remove_column :iforms, :employer_phone_2
    remove_column :iforms, :employer_phone_3
    remove_column :iforms, :emergency_contact_phone_1
    remove_column :iforms, :emergency_contact_phone_2
    remove_column :iforms, :emergency_contact_phone_3
    remove_column :iforms, :smile_evaluation_whiteness
    remove_column :iforms, :how_did_you_hear_about_office
    remove_column :iforms, :relationship_to_patient
    remove_column :iforms, :billing_details_first_name
    remove_column :iforms, :billing_details_last_name
    remove_column :iforms, :billing_details_address1
    remove_column :iforms, :billing_details_address2
    remove_column :iforms, :billing_details_address_city
    remove_column :iforms, :billing_details_address_state
    remove_column :iforms, :billing_details_address_postal_code
    remove_column :iforms, :billing_details_home_phone_1
    remove_column :iforms, :billing_details_home_phone_2
    remove_column :iforms, :billing_details_home_phone_3
    remove_column :iforms, :billing_details_work_phone_1
    remove_column :iforms, :billing_details_work_phone_2
    remove_column :iforms, :billing_details_work_phone_3
    remove_column :iforms, :billing_details_cell_phone_1
    remove_column :iforms, :billing_details_cell_phone_2
    remove_column :iforms, :billing_details_cell_phone_3
    remove_column :iforms, :billing_details_ssn
    remove_column :iforms, :billing_details_driving_licence_number
    remove_column :iforms, :billing_details_driving_licence_state
    remove_column :iforms, :billing_details_employer_name
    remove_column :iforms, :billing_details_employer_address1
    remove_column :iforms, :billing_details_employer_address2
    remove_column :iforms, :billing_details_employer_address_city
    remove_column :iforms, :billing_details_employer_address_state
    remove_column :iforms, :billing_details_employer_address_postal_code
    remove_column :iforms, :billing_details_employer_phone_1
    remove_column :iforms, :billing_details_employer_phone_2
    remove_column :iforms, :billing_details_employer_phone_3
  end
end
