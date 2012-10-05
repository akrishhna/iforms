class AddPreferredNameToAppointment < ActiveRecord::Migration
  def up
    add_column :appointments, :preferred_name, :string
  end

  def down
    remove_column :appointments, :preferred_name
  end
end
