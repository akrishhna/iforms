class AddServiceProviderIdToGirlScoutsActivity < ActiveRecord::Migration

  def up
    add_column :girl_scouts_activities, :service_provider_id, :integer
    activities = GirlScoutsActivity.all
    activities.each do|activity|
      activity.service_provider_id = 2
      activity.save
    end
  end

  def down
    remove_column :girl_scouts_activities, :service_provider_id
  end
end
