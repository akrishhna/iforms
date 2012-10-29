class GirlScoutTroopLeaderProfile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :first_name,:last_name,:council_type,:user_id
end
