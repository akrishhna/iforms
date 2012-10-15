class CreateProfiles < ActiveRecord::Migration
  def up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    users = User.find_all_by_role("patient")
    users.each do |user|
      patient = Patient.find_by_user_id(user.id)
      Profile.create({:user_id => user.id, :first_name => patient.firstname, :last_name =>patient.lastname})
    end
  end

  def down
    drop_table :profiles
  end
end
