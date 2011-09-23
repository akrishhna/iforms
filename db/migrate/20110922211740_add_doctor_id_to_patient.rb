class AddDoctorIdToPatient < ActiveRecord::Migration
  def self.up
    add_column :patients, :doctor_id, :integer
  end

  def self.down
    remove_column :patients, :doctor_id
  end
end
