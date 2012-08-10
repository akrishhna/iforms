class AddPasswordSaltToUser < ActiveRecord::Migration  
  def up
    add_column :users, :password_salt, :string
  end

  def down
    remove_column :users, :password_salt
  end
end
