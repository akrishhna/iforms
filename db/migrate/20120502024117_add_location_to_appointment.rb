class AddLocationToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :location, :string
  end
end
