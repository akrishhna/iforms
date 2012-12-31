class AddArizonaCactusPineFieldsToGirlScoutsActivityPermissionForm < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activity_permission_forms, :gapf_changes_to_general_permission_slip, :text
    add_column :girl_scouts_activity_permission_forms, :gapf_special_needs_yes_or_no, :string, :limit => 10
    add_column :girl_scouts_activity_permission_forms, :gapf_unusual_risk_acknowledgement, :string, :limit => 10
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_1, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_2, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_city, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_state, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_zip, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_home_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_home_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_home_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_work_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_work_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_work_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_mobile_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_mobile_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_mobile_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_other_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_other_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_other_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_1_email, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_1, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_2, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_city, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_state, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_zip, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_home_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_home_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_home_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_work_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_work_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_work_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_mobile_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_mobile_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_mobile_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_other_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_other_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_other_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_2_email, :string, :limit => 50

  end

  def down
    remove_column :girl_scouts_activity_permission_forms, :gapf_changes_to_general_permission_slip
    remove_column :girl_scouts_activity_permission_forms, :gapf_special_needs_yes_or_no
    remove_column :girl_scouts_activity_permission_forms, :gapf_special_needs_medication_comments
    remove_column :girl_scouts_activity_permission_forms, :gapf_unusual_risk_acknowledgement
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_city
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_state
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_address_zip
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_home_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_home_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_home_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_work_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_work_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_work_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_mobile_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_mobile_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_mobile_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_other_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_other_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_other_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_1_email
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_city
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_state
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_address_zip
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_home_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_home_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_home_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_work_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_work_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_work_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_mobile_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_mobile_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_mobile_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_other_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_other_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_other_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_2_email
  end
end
