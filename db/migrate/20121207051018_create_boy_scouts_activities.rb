class CreateBoyScoutsActivities < ActiveRecord::Migration
  def change
    create_table :boy_scouts_activities do |t|

      t.integer :user_id
      t.integer :service_provider_id

      #Activity
      t.string :activity_name
      t.date :activity_date_begin
      t.date :activity_date_end
      t.date :activity_signed_permission_due_date

      #Tour Leader Tab
      t.string :leader_first_name
      t.string :leader_last_name
      t.string :leader_email
      t.integer :leader_phone_1
      t.integer :leader_phone_2
      t.integer :leader_phone_3

      t.timestamps
    end
  end
end
