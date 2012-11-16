class AddServiceProviderIdToDoctors < ActiveRecord::Migration

  def up
    add_column :doctors, :service_provider_id, :integer
   Doctor.update_all(:service_provider_id => 1)
  end

  def down
    remove_column :doctors, :service_provider_id
  end
end
