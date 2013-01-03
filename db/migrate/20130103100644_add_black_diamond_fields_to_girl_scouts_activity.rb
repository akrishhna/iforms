class AddBlackDiamondFieldsToGirlScoutsActivity < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities, :activity_additional_expenses, :string, :limit => 100
    add_column :girl_scouts_activities, :troop_leader_accompanying_girls, :string, :limit => 100
  end

  def down
    remove_column :girl_scouts_activities, :activity_additional_expenses
    remove_column :girl_scouts_activities, :troop_leader_accompanying_girls
  end
end
