class CreateGirlScoutsActivities < ActiveRecord::Migration
  def change
    create_table :girl_scouts_activities do |t|

      t.integer :user_id

      #Activity
      t.string :activity_name
      t.string :activity_location
      t.date :activity_date_begin
      t.date :activity_date_end
      t.date :activity_signed_permission_due_date
      t.string :activity_leave_from
      t.datetime :activity_leave_time
      t.string :activity_return_to
      t.datetime :activity_return_time
      t.decimal :activity_cost
      t.boolean :girls_were_checkbox
      t.string :activity_girls_wear_others
      t.string :activity_girls_bring
      t.string :activity_equipment

      # Troop Tab
      t.string :troop_service_unit
      t.string :troop_pal
      t.string :troop_number

      #Troop Leader Tab
      t.string :leader_first_name
      t.string :leader_last_name
      t.string :leader_email
      t.integer :leader_day_phone
      t.integer :leader_evening_phone
      t.integer :leader_cell_phone

      #Troop Emergency Contact Tab
      t.string :emergency_first_name
      t.string :emergency_last_name
      t.integer :emergency_day_phone
      t.integer :emergency_evening_phone


      t.text :email_notification

      t.timestamps
    end
  end
end
