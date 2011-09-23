class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.string :formname
      t.references :doctor

      t.timestamps
    end
  end

  def self.down
    drop_table :forms
  end
end
