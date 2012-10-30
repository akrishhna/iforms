class CreateGirlScoutDiamondActivities < ActiveRecord::Migration
  def change
    create_table :girl_scout_diamond_activities do |t|

      t.integer :user_id

      #Activity
      t.string :activity_name
      t.string :activity_location
      t.date :activity_date_begin
      t.date :activity_date_end
      t.date :activity_signed_permission_due_date
      t.string :activity_leave_from
      t.integer :activity_leave_time_hh
      t.integer :activity_leave_time_mm
      t.string :activity_leave_time_am_pm
      t.string :activity_return_to
      t.integer :activity_return_time_hh
      t.integer :activity_return_time_mm
      t.string :activity_return_time_am_pm
      t.integer :activity_cost_dollars
      t.integer :activity_cost_cents
      t.string :activity_mode_of_transportation
      t.string :activity_equipment

      # Troop Tab
      t.string :troop_number

      #Troop Leader Tab
      t.string :leader_first_name_1
      t.string :leader_last_name_1
      t.string :leader_first_name_2
      t.string :leader_last_name_2
      t.integer :leader_phone_1_1
      t.integer :leader_phone_1_2
      t.integer :leader_phone_1_3
      t.integer :leader_cell_1_1
      t.integer :leader_cell_1_2
      t.integer :leader_cell_1_3
      t.integer :leader_phone_2_1
      t.integer :leader_phone_2_2
      t.integer :leader_phone_2_3
      t.integer :leader_cell_2_1
      t.integer :leader_cell_2_2
      t.integer :leader_cell_2_3

      #Troop Emergency Contact Tab
      t.string :emergency_first_name
      t.string :emergency_last_name
      t.integer :emergency_phone_1
      t.integer :emergency_phone_2
      t.integer :emergency_phone_3
      t.integer :emergency_cell_1
      t.integer :emergency_cell_2
      t.integer :emergency_cell_3
      t.string :emergency_address_street
      t.string :emergency_address_line
      t.string :emergency_address_city
      t.string :emergency_address_state
      t.boolean :emergency_address_zip
      t.string :emergency_address_country


      t.text :email_notification

      t.boolean :status

      t.timestamps
    end
  end
end
