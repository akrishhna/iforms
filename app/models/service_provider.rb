class ServiceProvider < ActiveRecord::Base
  has_many :user_service_providers
  has_many :users, :through => :user_service_providers
end
