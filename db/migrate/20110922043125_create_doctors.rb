class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.string :doctorname
      t.string :firstname
      t.string :lastname
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :doctors
  end
end
