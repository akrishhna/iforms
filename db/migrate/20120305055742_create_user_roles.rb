class CreateUserRoles < ActiveRecord::Migration
  def up
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role_id
      t.boolean :deleted

      t.timestamps
    end

    User.all.each do |u|
      role = Role.find_by_role(u.role)
      UserRole.create({:user_id => u.id, :role_id => role.id})
    end
  end

  def down
    drop_table :user_roles
  end
end
