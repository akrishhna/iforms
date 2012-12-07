class CreateBoyScoutsRosters < ActiveRecord::Migration
  def change
    create_table :boy_scouts_rosters do |t|

      t.integer :user_id
      t.integer :service_provider_id
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :parent_first_name
      t.string :parent_first_name
      t.string :email

      t.timestamps
    end
  end
end
