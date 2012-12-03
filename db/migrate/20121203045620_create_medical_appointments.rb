class CreateMedicalAppointments < ActiveRecord::Migration
  def change
    create_table :medical_appointments do |t|

      t.integer :doctor_id
      t.integer :service_provider_id
      t.integer :doctor_user_id
      t.integer :patient_user_id
      t.string :firstname
      t.string :preferred_name
      t.string :email
      t.string :lastname
      t.string :responsible_party
      t.string :doctorname
      t.string :location
      t.datetime :appointment_date_time
      t.string :formname
      t.string :timesent
      t.string :timereceived
      t.string :status

      t.timestamps
    end
  end
end
