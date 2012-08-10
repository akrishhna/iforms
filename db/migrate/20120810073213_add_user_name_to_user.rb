class AddUserNameToUser < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
    users = User.all
    users.each do |user|
      user.username = user.email
      user.save
    end
  end

  def down
    remove_column :users, :username
  end
end
