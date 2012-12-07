class BoyScoutsActivityConsentForm < ActiveRecord::Base
  belongs_to :user
  belongs_to :boy_scouts_roster
  belongs_to :boy_scouts_activity
  validates_uniqueness_of :boy_scout_activity_id, :scope => [:boy_scout_id]
end
