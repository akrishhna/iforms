class GirlsScout < ActiveRecord::Base
  belongs_to :user
  has_many :girl_scouts_activity_permission_forms

validates_uniqueness_of :email, :scope => :service_provider_id
end
