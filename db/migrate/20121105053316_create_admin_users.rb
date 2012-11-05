class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users, :force => true do |t|

      t.integer :user_id
      t.boolean :status, :default => true

      t.timestamps
    end
  end
end
