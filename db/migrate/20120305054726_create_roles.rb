class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :role
      t.string :description
      t.boolean :disabled, :default => 0

      t.timestamps
    end

    puts "######## INSERT RECORDS ########"
    Role.create({:role => 'admin', :description => 'Administrations'})
    Role.create({:role => 'doctor', :description => 'Doctor'})
    Role.create({:role => 'patient', :description => 'Patient'})
  end

  def self.down
    drop_table :roles
  end
end
