class GirlScoutDiamondActivityPermissionForm < ActiveRecord::Base
  belongs_to :user
  belongs_to :girl_scout_diamond_activity
  validates_uniqueness_of :girl_scout_diamond_activity_id, :scope => [:girls_scout_id]
end
