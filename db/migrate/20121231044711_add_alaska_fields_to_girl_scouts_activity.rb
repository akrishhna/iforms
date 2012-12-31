class AddAlaskaFieldsToGirlScoutsActivity < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities, :activity_time_hh, :integer
    add_column :girl_scouts_activities, :activity_time_mm, :integer
    add_column :girl_scouts_activities, :activity_time_am_pm, :string
    add_column :girl_scouts_activities, :adults_accompanying_girls, :string
    add_column :girl_scouts_activities, :activity_location_phone_1, :integer
    add_column :girl_scouts_activities, :activity_location_phone_2, :integer
    add_column :girl_scouts_activities, :activity_location_phone_3, :integer
    add_column :girl_scouts_activities, :troop_leader_phone_1, :integer
    add_column :girl_scouts_activities, :troop_leader_phone_2, :integer
    add_column :girl_scouts_activities, :troop_leader_phone_3, :integer
  end

  def down
    remove_column :girl_scouts_activities, :activity_time_hh
    remove_column :girl_scouts_activities, :activity_time_mm
    remove_column :girl_scouts_activities, :activity_time_am_pm
    remove_column :girl_scouts_activities, :adults_accompanying_girls
    remove_column :girl_scouts_activities, :activity_location_phone_1
    remove_column :girl_scouts_activities, :activity_location_phone_2
    remove_column :girl_scouts_activities, :activity_location_phone_3
    remove_column :girl_scouts_activities, :troop_leader_phone_1
    remove_column :girl_scouts_activities, :troop_leader_phone_2
    remove_column :girl_scouts_activities, :troop_leader_phone_3
  end
end
