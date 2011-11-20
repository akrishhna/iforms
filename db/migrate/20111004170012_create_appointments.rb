class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.date :date
      t.string :time_hrs
      t.string :time_min
      t.string :AM_PM
      t.string :doctorname
      t.string :formname
      t.datetime :timesent
      t.datetime :timereceived
      t.string :status
      t.references :patient
      t.references :doctor
      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
