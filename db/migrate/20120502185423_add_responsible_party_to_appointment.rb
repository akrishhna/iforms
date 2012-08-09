class AddResponsiblePartyToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :responsible_party, :string
  end
end
