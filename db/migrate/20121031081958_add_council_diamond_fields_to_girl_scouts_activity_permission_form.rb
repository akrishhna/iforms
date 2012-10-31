class AddCouncilDiamondFieldsToGirlScoutsActivityPermissionForm < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activity_permission_forms,:daughter_name, :string
    add_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_name, :string
    add_column :girl_scouts_activity_permission_forms,:parent_phone_number_during_activity_1, :integer
    add_column :girl_scouts_activity_permission_forms,:parent_phone_number_during_activity_2, :integer
    add_column :girl_scouts_activity_permission_forms,:parent_phone_number_during_activity_3, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_name, :string
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_phone_number_1, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_phone_number_2, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_phone_number_3, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_cell_number_1, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_cell_number_2, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_cell_number_3, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_address_street, :string
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_address_line, :string
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_address_city, :string
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_address_state, :string
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_address_country, :string
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_address_zip, :integer
    add_column :girl_scouts_activity_permission_forms,:emergency_contact_relationship_to_participant, :string
    add_column :girl_scouts_activity_permission_forms,:medications, :text
  end

  def down
    remove_column :girl_scouts_activity_permission_forms,:daughter_name
    remove_column :girl_scouts_activity_permission_forms,:act_in_my_behalf_name
    remove_column :girl_scouts_activity_permission_forms,:parent_phone_number_during_activity_1
    remove_column :girl_scouts_activity_permission_forms,:parent_phone_number_during_activity_2
    remove_column :girl_scouts_activity_permission_forms,:parent_phone_number_during_activity_3
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_name
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_phone_number_1
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_phone_number_2
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_phone_number_3
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_cell_number_1
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_cell_number_2
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_cell_number_3
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_address_street
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_address_line
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_address_city
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_address_state
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_address_country
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_address_zip
    remove_column :girl_scouts_activity_permission_forms,:emergency_contact_relationship_to_participant
    remove_column :girl_scouts_activity_permission_forms,:medications
  end

end
