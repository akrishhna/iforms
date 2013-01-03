class AddBlackDiamondFieldsToGirlScoutsActivityPermissionForm < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_relationship_to_participant, :string, :limit => 50
    add_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_phone_1, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_phone_2, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_phone_3, :integer
    add_column :girl_scouts_activity_permission_forms, :gapf_additional_remarks, :text
  end

  def down
    remove_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_relationship_to_participant
    remove_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_phone_1
    remove_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_phone_2
    remove_column :girl_scouts_activity_permission_forms, :gapf_activity_my_behalf_phone_3
    remove_column :girl_scouts_activity_permission_forms, :gapf_additional_remarks
  end
  end
