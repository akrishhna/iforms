class AddFormnameAndOtherFieldsToGirlScoutsActivities < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities, :form_name, :string, :limit => 50
    add_column :girl_scouts_activities, :date_received, :string, :limit => 50
    add_column :girl_scouts_activities, :date_submitted, :string, :limit => 50
    add_column :girl_scouts_activities, :attending, :string, :limit => 50
    add_column :girl_scouts_activities, :program_year, :string, :limit => 50
  end

  def down
    remove_column :girl_scouts_activities, :form_name
    remove_column :girl_scouts_activities, :date_received
    remove_column :girl_scouts_activities, :date_submitted
    remove_column :girl_scouts_activities, :attending
    remove_column :girl_scouts_activities, :program_year
  end
end
