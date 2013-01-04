class AddCentralSouthernFieldsToGirlScoutsActivity < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities, :troop_leader_certified_first_aider_not_needed, :boolean
    add_column :girl_scouts_activities, :troop_leader_certified_first_aider_provided, :boolean
    add_column :girl_scouts_activities, :troop_leader_first_aider_attending_first_name, :string, :limit => 50
    add_column :girl_scouts_activities, :troop_leader_first_aider_attending_last_name, :string, :limit => 50
    add_column :girl_scouts_activities, :troop_leader_certification_expiration_checked, :boolean
  end

  def down
    remove_column :girl_scouts_activities, :troop_leader_certified_first_aider_not_needed
    remove_column :girl_scouts_activities, :troop_leader_certified_first_aider_provided
    remove_column :girl_scouts_activities, :troop_leader_first_aider_attending_name
    remove_column :girl_scouts_activities, :troop_leader_certification_expiration_checked
  end
end
