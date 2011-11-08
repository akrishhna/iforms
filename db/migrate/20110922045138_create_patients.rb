class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :firstname
      t.string :lastname
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
