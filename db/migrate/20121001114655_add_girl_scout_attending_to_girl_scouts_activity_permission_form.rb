class AddGirlScoutAttendingToGirlScoutsActivityPermissionForm < ActiveRecord::Migration
  def up
    add_column :girl_scouts_activity_permission_forms, :girl_scout_attending, :string
  end

  def down
    remove_column :girl_scouts_activity_permission_forms, :girl_scout_attending
    end
end
