class GirlScoutsActivity < ActiveRecord::Base

 # validates_presence_of :activity_name,:activity_location,:activity_date_begin,:activity_date_end,:activity_signed_permission_due_date,:activity_leave_from,:activity_leave_time_hh,:activity_leave_time_mm,:activity_leave_time_am_pm,:activity_return_to,:activity_return_time_hh,:activity_return_time_mm,:activity_return_time_am_pm,:activity_cost_dollars,:activity_cost_cents
 # validates_presence_of :troop_service_unit,:troop_pal,:troop_number
 # validates_presence_of :leader_first_name,:leader_last_name,:leader_day_phone_1,:leader_day_phone_2,:leader_day_phone_3
 # validates_presence_of :emergency_first_name,:emergency_last_name,:emergency_day_phone_1,:emergency_day_phone_2,:emergency_day_phone_3
  validates_presence_of :activity_name,:activity_signed_permission_due_date,:leader_first_name,:leader_last_name
  belongs_to :user

end
