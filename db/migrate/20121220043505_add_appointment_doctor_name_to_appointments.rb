class AddAppointmentDoctorNameToAppointments < ActiveRecord::Migration
  def up
    add_column :appointments, :appointment_doctor_name, :string, :limit => 50
  end

  def down
    remove_column :appointments, :appointment_doctor_name
  end
end
