class CreateGirlScoutTroopLeaderProfiles < ActiveRecord::Migration
  def change
    create_table :girl_scout_troop_leader_profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :council_type

      t.timestamps
    end
  end
end
