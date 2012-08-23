class CreateUserServiceProviders < ActiveRecord::Migration
  def up
    create_table :user_service_providers do |t|
      t.integer :user_id
      t.integer :service_provider_id
      t.boolean :status, :default => true
      t.date :expiry_date

      t.timestamps
    end
    users = User.find_all_by_role("doctor")
    users.each do |user|
      UserServiceProvider.create({:user_id => user.id, :service_provider_id => 1})
    end
  end

  def down
    drop_table :user_service_providers
  end
end
