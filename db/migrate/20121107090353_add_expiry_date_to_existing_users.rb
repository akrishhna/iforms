class AddExpiryDateToExistingUsers < ActiveRecord::Migration

  def up
    user_service_providers = UserServiceProvider.all
    user_service_providers.each do |user_service_provider|
      user_service_provider.expiry_date = Time.now + 90.days  if user_service_provider.expiry_date.nil?
      user_service_provider.save
    end
  end

  def down
  end
end
