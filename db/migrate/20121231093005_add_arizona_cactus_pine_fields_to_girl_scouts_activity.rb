class AddArizonaCactusPineFieldsToGirlScoutsActivity < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities, :activity_start_time_hh, :integer
    add_column :girl_scouts_activities, :activity_start_time_mm, :integer
    add_column :girl_scouts_activities, :activity_start_time_am_pm, :string
    add_column :girl_scouts_activities, :activity_end_time_hh, :integer
    add_column :girl_scouts_activities, :activity_end_time_mm, :integer
    add_column :girl_scouts_activities, :activity_end_time_am_pm, :string
    add_column :girl_scouts_activities, :activity_cost_used_for, :string
    add_column :girl_scouts_activities, :activity_will_involve_unusual_risk, :string
  end

  def down
    remove_column :girl_scouts_activities, :activity_start_time_hh
    remove_column :girl_scouts_activities, :activity_start_time_mm
    remove_column :girl_scouts_activities, :activity_start_time_am_pm
    remove_column :girl_scouts_activities, :activity_end_time_hh
    remove_column :girl_scouts_activities, :activity_end_time_mm
    remove_column :girl_scouts_activities, :activity_end_time_am_pm
    remove_column :girl_scouts_activities, :activity_cost_used_for
    remove_column :girl_scouts_activities, :activity_will_involve_unusual_risk
  end
end
