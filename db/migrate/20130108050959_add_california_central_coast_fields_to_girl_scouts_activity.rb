class AddCaliforniaCentralCoastFieldsToGirlScoutsActivity < ActiveRecord::Migration

  def up

    add_column :girl_scouts_activities, :activity_chaperone_1_name, :string, :limit => 50
    add_column :girl_scouts_activities, :activity_chaperone_1_driver, :string, :limit => 10
    add_column :girl_scouts_activities, :activity_chaperone_1_registered, :string, :limit => 10

    add_column :girl_scouts_activities, :activity_chaperone_2_name, :string, :limit => 50
    add_column :girl_scouts_activities, :activity_chaperone_2_driver, :string, :limit => 10
    add_column :girl_scouts_activities, :activity_chaperone_2_registered, :string, :limit => 10

    add_column :girl_scouts_activities, :activity_chaperone_3_name, :string, :limit => 50
    add_column :girl_scouts_activities, :activity_chaperone_3_driver, :string, :limit => 10
    add_column :girl_scouts_activities, :activity_chaperone_3_registered, :string, :limit => 10

    add_column :girl_scouts_activities, :activity_chaperone_4_name, :string, :limit => 50
    add_column :girl_scouts_activities, :activity_chaperone_4_driver, :string, :limit => 10
    add_column :girl_scouts_activities, :activity_chaperone_4_registered, :string, :limit => 10
  end

  def down
      remove_column :girl_scouts_activities, :activity_allergies

      remove_column :girl_scouts_activities, :activity_chaperone_1_first_name
      remove_column :girl_scouts_activities, :activity_chaperone_1_last_name
      remove_column :girl_scouts_activities, :activity_chaperone_1_driver
      remove_column :girl_scouts_activities, :activity_chaperone_1_registered

      remove_column :girl_scouts_activities, :activity_chaperone_2_first_name
      remove_column :girl_scouts_activities, :activity_chaperone_2_last_name
      remove_column :girl_scouts_activities, :activity_chaperone_2_driver
      remove_column :girl_scouts_activities, :activity_chaperone_2_registered

      remove_column :girl_scouts_activities, :activity_chaperone_3_first_name
      remove_column :girl_scouts_activities, :activity_chaperone_3_last_name
      remove_column :girl_scouts_activities, :activity_chaperone_3_driver
      remove_column :girl_scouts_activities, :activity_chaperone_3_registered

      remove_column :girl_scouts_activities, :activity_chaperone_4_first_name
      remove_column :girl_scouts_activities, :activity_chaperone_4_last_name
      remove_column :girl_scouts_activities, :activity_chaperone_4_driver
      remove_column :girl_scouts_activities, :activity_chaperone_4_registered
  end
end
