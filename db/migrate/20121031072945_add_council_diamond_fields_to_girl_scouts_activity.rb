class AddCouncilDiamondFieldsToGirlScoutsActivity < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities,:mode_of_transportation, :string
    add_column :girl_scouts_activities,:leader_advisor_1_name, :string
    add_column :girl_scouts_activities,:leader_advisor_1_phone_1, :integer
    add_column :girl_scouts_activities,:leader_advisor_1_phone_2, :integer
    add_column :girl_scouts_activities,:leader_advisor_1_phone_3, :integer
    add_column :girl_scouts_activities,:leader_advisor_1_cell_1, :integer
    add_column :girl_scouts_activities,:leader_advisor_1_cell_2, :integer
    add_column :girl_scouts_activities,:leader_advisor_1_cell_3, :integer
    add_column :girl_scouts_activities,:leader_advisor_2_name, :string
    add_column :girl_scouts_activities,:leader_advisor_2_phone_1, :integer
    add_column :girl_scouts_activities,:leader_advisor_2_phone_2, :integer
    add_column :girl_scouts_activities,:leader_advisor_2_phone_3, :integer
    add_column :girl_scouts_activities,:leader_advisor_2_cell_1, :integer
    add_column :girl_scouts_activities,:leader_advisor_2_cell_2, :integer
    add_column :girl_scouts_activities,:leader_advisor_2_cell_3, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name, :string
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_phone_number_1, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_phone_number_2, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_phone_number_3, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_cell_number_1, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_cell_number_2, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_cell_number_3, :integer
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_street, :string
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_line, :string
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_city, :string
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_state, :string
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_country, :string
    add_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_zip, :string
  end

  def down
    remove_column :girl_scouts_activities,:mode_of_transportation
    remove_column :girl_scouts_activities,:leader_advisor_1_name
    remove_column :girl_scouts_activities,:leader_advisor_1_phone_1
    remove_column :girl_scouts_activities,:leader_advisor_1_phone_2
    remove_column :girl_scouts_activities,:leader_advisor_1_phone_2
    remove_column :girl_scouts_activities,:leader_advisor_1_cell_1
    remove_column :girl_scouts_activities,:leader_advisor_1_cell_2
    remove_column :girl_scouts_activities,:leader_advisor_1_cell_3
    remove_column :girl_scouts_activities,:leader_advisor_2_name
    remove_column :girl_scouts_activities,:leader_advisor_2_phone_1
    remove_column :girl_scouts_activities,:leader_advisor_2_phone_2
    remove_column :girl_scouts_activities,:leader_advisor_2_phone_3
    remove_column :girl_scouts_activities,:leader_advisor_2_cell_1
    remove_column :girl_scouts_activities,:leader_advisor_2_cell_2
    remove_column :girl_scouts_activities,:leader_advisor_2_cell_3
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_phone_number_1
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_phone_number_2
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_phone_number_3
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_cell_number_1
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_cell_number_2
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_cell_number_3
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_street
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_line
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_city
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_state
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_country
    remove_column :girl_scouts_activities,:troop_leader_emergency_contact_name_address_zip
   end
end
