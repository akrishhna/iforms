class AddSomeRisingStarsFieldsToIforms < ActiveRecord::Migration
  def up
    add_column :iforms, :social_history_patient_is, :string, :limit => 20
    add_column :iforms, :insurance_second_insurance_company_name, :string, :limit => 50
    add_column :iforms, :dental_history_oral_habits_other_description, :string, :limit => 50
    add_column :iforms, :patient_guardian_mother_other_description, :string, :limit => 50
    add_column :iforms, :patient_guardian_father_other_description, :string, :limit => 50
  end

  def down
    remove_column :iforms, :social_history_patient_is
    remove_column :iforms, :insurance_second_insurance_company_name
    remove_column :iforms, :dental_history_oral_habits_other_description
    remove_column :iforms, :patient_guardian_mother_other_description
    remove_column :iforms, :patient_guardian_father_other_description
  end
end
