class AddCaliforniaCentralCoastFieldsToGirlScoutsActivityPermissionForm < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activity_permission_forms, :gapf_allergies, :string, :limit => 50

    add_column :girl_scouts_activity_permission_forms, :gapf_parent_first_name, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_last_name, :string, :limit => 50

    add_column :girl_scouts_activity_permission_forms, :gapf_parent_address_1, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_address_2, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_address_city, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_address_state, :string, :limit => 25
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_address_zip, :integer

    add_column :girl_scouts_activity_permission_forms, :gapf_parent_home_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_home_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_home_phone_3, :integer

    add_column :girl_scouts_activity_permission_forms, :gapf_parent_cell_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_cell_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_cell_phone_3, :integer

    add_column :girl_scouts_activity_permission_forms, :gapf_parent_other_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_other_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_parent_other_phone_3, :integer


    add_column :girl_scouts_activity_permission_forms, :gapf_emergency_medical_treatment, :string, :limit => 10
    add_column :girl_scouts_activity_permission_forms, :gapf_publicity_photos, :string, :limit => 10
  end

  def down
    remove_column :girl_scouts_activity_permission_forms, :gapf_allergies

    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_first_name
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_last_name

    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_address_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_address_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_address_city
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_address_state
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_address_zip

    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_home_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_home_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_home_phone_3

    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_cell_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_cell_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_cell_phone_3

    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_other_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_other_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_parent_other_phone_3

    remove_column :girl_scouts_activity_permission_forms, :gapf_emergency_medical_treatment
    remove_column :girl_scouts_activity_permission_forms, :gapf_publicity_photos
  end
end