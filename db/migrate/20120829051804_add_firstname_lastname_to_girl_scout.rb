class AddFirstnameLastnameToGirlScout < ActiveRecord::Migration
  def up
    add_column :girls_scouts, :first_name, :string
    add_column :girls_scouts, :last_name, :string
    add_column :girls_scouts, :parent_first_name, :string
    add_column :girls_scouts, :parent_last_name, :string
  end

  def down
    remove_column :girls_scouts, :first_name
    remove_column :girls_scouts, :last_name
    remove_column :girls_scouts, :parent_first_name
    remove_column :girls_scouts, :parent_last_name
  end
end
