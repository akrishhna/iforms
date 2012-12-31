class AddAlaskaFieldsToGirlScoutsActivityPermissionForm < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_1, :string
    add_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_2, :string
    add_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_city, :string
    add_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_state, :string
    add_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_zip, :string
  end

  def down
  remove_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_1
  remove_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_2
  remove_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_city
  remove_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_state
  remove_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_address_zip
  end
end
