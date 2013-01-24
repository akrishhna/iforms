class AddAppointmentDateTimeFieldToAppointments < ActiveRecord::Migration

  def up
    add_column :appointments, :appointment_date_time, :datetime

    all_appointments = Appointment.all
    all_appointments.each do |appointment|
      app_date = appointment.date.strftime('%Y-%m-%d')
      hours = (appointment.AM_PM == 'PM') ? (appointment.time_hrs.to_i + 12).to_i : appointment.time_hrs.to_i
      hours = 12 if appointment.AM_PM == "PM" and hours == 24
      hours = 00 if appointment.AM_PM == "AM" and hours == 12
      mins = appointment.time_min
      date_time = app_date + ' ' + hours.to_s+ ':' + mins.to_s + ':' + '00'
      appointment.appointment_date_time = DateTime.parse(date_time)
      appointment.save(:validate => false)
    end
  end

  def down
    remove_column :appointments, :appointment_date_time
  end
end
