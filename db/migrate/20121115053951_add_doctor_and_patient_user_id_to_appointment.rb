class AddDoctorAndPatientUserIdToAppointment < ActiveRecord::Migration

  def up
    add_column :appointments, :doctor_user_id, :integer
    add_column :appointments, :patient_user_id, :integer
    appointments = Appointment.all
    appointments.each do |appointment|
      doctor = Doctor.find(appointment.doctor_id)
      appointment.doctor_user_id = doctor.user_id
      patient = Patient.find(appointment.patient_id)
      appointment.patient_user_id = patient.user_id if patient
      appointment.save(:validate => false)
    end

  end

  def down
    remove_column :appointments, :doctor_user_id
    remove_column :appointments, :patient_user_id
  end
end
