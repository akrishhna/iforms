class AddServiceProviderIdToAppointments < ActiveRecord::Migration

  def up
    add_column :appointments, :service_provider_id, :integer
   Appointment.update_all(:service_provider_id => 1)
  end

  def down
    remove_column :appointments, :service_provider_id
  end
end
