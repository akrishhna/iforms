class BoyScoutsRoster < ActiveRecord::Base
  belongs_to :user
  has_many :boy_scouts_activity_consent_forms
end