class CreateBoyScoutsActivityConsentForms < ActiveRecord::Migration
  def change
    create_table :boy_scouts_activity_consent_forms do |t|

      t.integer :user_id
      t.integer :boy_scouts_roster_id
      t.integer :boy_scouts_activity_id
      t.string :attending
      t.string :status

      t.string :bacf_restriction
      t.string :bacf_spcl_considerations_for_restriction
      t.date :bacf_birthdate
      t.string :bacf_address_1
      t.string :bacf_address_2
      t.string :bacf_address_city
      t.string :bacf_address_state
      t.string :bacf_address_zip
      t.string :bacf_parent_first_name
      t.string :bacf_parent_last_name
      t.integer :bacf_parent_phone_1
      t.integer :bacf_parent_phone_2
      t.integer :bacf_parent_phone_3
      t.string :email

      t.timestamps
    end
  end
end
