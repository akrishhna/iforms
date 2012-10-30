class GirlScoutDiamondActivity < ActiveRecord::Base
  belongs_to :user
  has_many :girl_scout_diamond_activity_permission_forms, :dependent => :destroy
end
