class AddEditConfirmedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :edit_confirmed, :string
  end

  def self.down
    remove_column :users, :edit_confirmed
  end
end
