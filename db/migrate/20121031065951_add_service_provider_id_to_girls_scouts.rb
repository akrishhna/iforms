class AddServiceProviderIdToGirlsScouts < ActiveRecord::Migration

  def up
    add_column :girls_scouts, :service_provider_id, :integer
    girls_scouts = GirlsScout.all
    girls_scouts.each do|girls_scout|
      girls_scout.service_provider_id = 2
      girls_scout.save
    end
  end

  def down
    remove_column :girls_scouts, :service_provider_id
  end

end
