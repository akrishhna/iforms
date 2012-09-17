class GirlsScout < ActiveRecord::Base
  belongs_to :user
  has_many :girl_scouts_activity_permission_forms
end
