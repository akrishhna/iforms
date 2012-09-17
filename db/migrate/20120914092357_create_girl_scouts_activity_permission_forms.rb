class CreateGirlScoutsActivityPermissionForms < ActiveRecord::Migration
  def change
    create_table :girl_scouts_activity_permission_forms do |t|
      t.integer :user_id
      t.integer :girls_scout_id
      t.integer :girl_scouts_activity_id
      t.boolean :attending
      t.string :status
      t.string :gapf_girl_scouts_first_name
      t.string :gapf_girl_scouts_last_name
      t.string :gapf_emergency_contact_1_first_name
      t.string :gapf_emergency_contact_1_last_name
      t.string :gapf_emergency_contact_1_phone_1_1
      t.string :gapf_emergency_contact_1_phone_1_2
      t.string :gapf_emergency_contact_1_phone_1_3
      t.string :gapf_emergency_contact_1_phone_2_1
      t.string :gapf_emergency_contact_1_phone_2_2
      t.string :gapf_emergency_contact_1_phone_2_3
      t.string :gapf_emergency_contact_2_first_name
      t.string :gapf_emergency_contact_2_last_name
      t.string :gapf_emergency_contact_2_phone_1_1
      t.string :gapf_emergency_contact_2_phone_1_2
      t.string :gapf_emergency_contact_2_phone_1_3
      t.string :gapf_emergency_contact_2_phone_2_1
      t.string :gapf_emergency_contact_2_phone_2_2
      t.string :gapf_emergency_contact_2_phone_2_3
      t.string :gapf_emergency_contact_3_first_name
      t.string :gapf_emergency_contact_3_last_name
      t.string :gapf_emergency_contact_3_phone_1_1
      t.string :gapf_emergency_contact_3_phone_1_2
      t.string :gapf_emergency_contact_3_phone_1_3
      t.string :gapf_emergency_contact_3_phone_2_1
      t.string :gapf_emergency_contact_3_phone_2_2
      t.string :gapf_emergency_contact_3_phone_2_3
      t.string :gapf_physician_first_name
      t.string :gapf_physician_last_name
      t.string :gapf_physician_phone_1
      t.string :gapf_physician_phone_2
      t.string :gapf_physician_phone_3
      t.string :gapf_my_insurance_carrier
      t.string :gapf_policy
      t.text :gapf_special_needs

      t.timestamps
    end
  end
end
