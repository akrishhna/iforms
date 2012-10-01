class GirlScoutsActivity < ActiveRecord::Base
  belongs_to :user
  has_many :girl_scouts_activity_permission_forms, :dependent => :destroy

 # validates_presence_of :activity_name,:activity_location,:activity_date_begin,:activity_date_end,:activity_signed_permission_due_date,:activity_leave_from,:activity_leave_time_hh,:activity_leave_time_mm,:activity_leave_time_am_pm,:activity_return_to,:activity_return_time_hh,:activity_return_time_mm,:activity_return_time_am_pm,:activity_cost_dollars,:activity_cost_cents
 # validates_presence_of :troop_service_unit,:troop_pal,:troop_number
 # validates_presence_of :leader_first_name,:leader_last_name,:leader_day_phone_1,:leader_day_phone_2,:leader_day_phone_3
 # validates_presence_of :emergency_first_name,:emergency_last_name,:emergency_day_phone_1,:emergency_day_phone_2,:emergency_day_phone_3
  validates_presence_of :activity_name,:activity_signed_permission_due_date,:leader_first_name,:leader_last_name


  def self.activity_permission_form_pdf_generater(activity, permission_form_path)
    @activity = activity
    form_pdf_path = "#{PDFFILES_PATH}Parent_Permission_iForms.pdf"
    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
    @pdftk.fill_form(form_pdf_path, permission_form_path, {
      "ServiceUnit" => @activity.troop_service_unit,
      "ProgramYearFrom" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0] : @activity.activity_date_begin.to_s.split("-")[0].to_i - 1 : '',
      "ProgramYearTo" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0].to_i + 1 : @activity.activity_date_begin.to_s.split("-")[0] : '',
      "TroopLeaderName" => @activity.leader_first_name + " " + @activity.leader_last_name,
      "TroopLeaderEmailAddress" => @activity.leader_email,
      "TroopLeaderDayPhoneAreaCode" => @activity.leader_day_phone_1,
      "TroopLeaderDayPhoneLocalNumber" => @activity.leader_day_phone_2.to_s + '-' + @activity.leader_day_phone_3.to_s,
      "TroopLeaderEveningPhoneAreaCode" => @activity.leader_evening_phone_1,
      "TroopLeaderEveningPhoneLocalNumber" => @activity.leader_evening_phone_2.to_s + '-' + @activity.leader_evening_phone_3.to_s,
      "TroopLeaderEmergencyContactName" => @activity.emergency_first_name + ' ' + @activity.emergency_last_name,
      "TroopLeaderMobilePhoneAreaCode" => @activity.leader_cell_phone_1,
      "TroopLeaderMobilePhoneLocalNumber" => @activity.leader_cell_phone_2.to_s + '-' + @activity.leader_cell_phone_3.to_s,
      "TroopLeaderEmergencyContactDayPhoneAreaCode" => @activity.emergency_day_phone_1,
      "TroopLeaderEmergencyContactDayPhoneLocalNumber" => @activity.emergency_day_phone_2.to_s + '-' + @activity.emergency_day_phone_3.to_s,
      "TroopLeaderEmergencyContactEveningPhoneAreaCode" => @activity.emergency_evening_phone_1,
      "TroopLeaderEmergencyContactEveningPhoneLocalNumber" => @activity.emergency_evening_phone_2.to_s + '-' + @activity.emergency_evening_phone_3.to_s,
      "ActivityName" => @activity.activity_name,
      "ActivityLocation" => @activity.activity_location,
      "ActivityDateBeginMonth" => @activity.activity_date_begin.to_s.split("-")[1],
      "ActivityDateBeginDay" => @activity.activity_date_begin.to_s.split("-")[2],
      "ActivityDateBeginYear" => @activity.activity_date_begin.to_s.split("-")[0],
      "ActivityDateEndMonth" => @activity.activity_date_end.to_s.split("-")[1],
      "ActivityDateEndDay" => @activity.activity_date_end.to_s.split("-")[2],
      "ActivityDateEndYear" => @activity.activity_date_end.to_s.split("-")[0],
      "WeWillLeaveFrom" => @activity.activity_leave_from,
      "WeWillLeaveFromTime" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0'),
      "WeWillLeaveFromTimeAM" => @activity.activity_leave_time_am_pm == "AM" ? "Yes" : "Off",
      "WeWillLeaveFromTimePM" => @activity.activity_leave_time_am_pm == "PM" ? "Yes" : "Off",
      "WeWillReturnTo" => @activity.activity_return_to,
      "WeWillReturnToTime" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0'),
      "WeWillReturnToTimeAM" => @activity.activity_return_time_am_pm == "AM" ? "Yes" : "Off",
      "WeWillReturnToTimePM" => @activity.activity_return_time_am_pm == "PM" ? "Yes" : "Off",
      "Cost" => @activity.activity_cost_dollars ? @activity.activity_cost_dollars.to_s + '.' + @activity.activity_cost_cents.to_s : '',
      "GirlsShouldWearOther" => @activity.activity_girls_wear_others,
      "GirlsShouldWearUniforms" => @activity.girls_wear_checkbox ? "Yes" : "Off",
      "GirlsShouldBring" => @activity.activity_girls_bring,
      "EquipmentNeeded" => @activity.activity_equipment,
      "SignedPermissionFormDueDate" => @activity.activity_signed_permission_due_date ? @activity.activity_signed_permission_due_date.strftime("%m/%d/%Y") : '',
      "TroopNumber" => @activity.troop_number,
      "PAL" => @activity.troop_pal
    })
    # raise @pdftk.fields(form_pdf_path).to_yaml
  end

end
