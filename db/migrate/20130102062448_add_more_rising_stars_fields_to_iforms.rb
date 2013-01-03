class AddMoreRisingStarsFieldsToIforms < ActiveRecord::Migration

  def up
    add_column :iforms, :patient_guardian_father_address_type, :string, :limit => 10
    add_column :iforms, :patient_guardian_mother_address_type, :string, :limit => 10
    add_column :iforms, :social_history_patient_adopted_age_year_months, :string, :limit => 10
  end

  def down
    remove_column :iforms, :patient_guardian_father_address_type
    remove_column :iforms, :patient_guardian_mother_address_type
    #remove_column :iforms, :social_history_patient_adopted_age_years_months
    remove_column :iforms, :patient_insurance_claim_email
  end
end
