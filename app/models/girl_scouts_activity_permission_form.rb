class GirlScoutsActivityPermissionForm < ActiveRecord::Base
  belongs_to :user
  belongs_to :girls_scout
  belongs_to :girl_scouts_activity
  validates_uniqueness_of :girl_scouts_activity_id, :scope => [:girls_scout_id]
  #alidates_presence_of :gapf_emergency_contact_1_first_name,:gapf_emergency_contact_1_last_name,:gapf_emergency_contact_1_phone_1_1,:gapf_emergency_contact_1_phone_1_2,:gapf_emergency_contact_1_phone_1_3,:gapf_girl_scouts_first_name,:gapf_emergency_contact_3_last_name,:gapf_physician_first_name,:gapf_physician_last_name,:gapf_physician_phone_1,:gapf_physician_phone_2,:gapf_physician_phone_3,:gapf_policy,:gapf_my_insurance_carrier


  def self.activity_parent_permission_form_pdf_generater(activity,girl_scouts_permission_form, permission_form_path)
    @activity = activity
    @girl_scouts_permission_form = girl_scouts_permission_form
    #@girl_scouts_permission_form = girl_scouts_permission_form
    form_pdf_path = "#{PDFFILES_PATH}Parent_Permission_iForms.pdf"
    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
    @pdftk.fill_form(form_pdf_path, permission_form_path, {
      "ServiceUnit" => @activity.troop_service_unit,
      "ProgramYearFrom" => (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0] : @activity.activity_date_begin.to_s.split("-")[0].to_i - 1,
      "ProgramYearTo" => (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0].to_i + 1 : @activity.activity_date_begin.to_s.split("-")[0],
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
      "Cost" => @activity.activity_cost_dollars.to_s + '.' + @activity.activity_cost_cents.to_s,
      "GirlsShouldWearOther" => @activity.activity_girls_wear_others,
      "GirlsShouldWearUniforms" => @activity.girls_wear_checkbox ? "Yes" : "Off",
      "GirlsShouldBring" => @activity.activity_girls_bring,
      "EquipmentNeeded" => @activity.activity_equipment,
      "SignedPermissionFormDueDate" => @activity.activity_signed_permission_due_date ? @activity.activity_signed_permission_due_date.strftime("%m/%d/%Y") : '',
      "TroopNumber" => @activity.troop_number,
      "PAL" => @activity.troop_pal,
      "DaughterName" => @girl_scouts_permission_form.gapf_girl_scouts_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_girl_scouts_last_name.to_s,
      "EmergencyContact1Name" => @girl_scouts_permission_form.gapf_emergency_contact_1_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_1_last_name.to_s,
      "EmergencyContact2Name" => @girl_scouts_permission_form.gapf_emergency_contact_2_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_2_last_name.to_s,
      "EmergencyContact3Name" => @girl_scouts_permission_form.gapf_emergency_contact_3_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_3_last_name.to_s,
      "EmergencyContact1PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_3.to_s,
      "EmergencyContact2PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_3.to_s,
      "EmergencyContact3PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_3.to_s,
      "EmergencyContact1AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_3.to_s,
      "EmergencyContact2AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_3.to_s,
      "EmergencyContact3AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_3.to_s,
      "PhysicianName" => @girl_scouts_permission_form.gapf_physician_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_physician_last_name.to_s,
      "PhysicianPhoneAreaCode" => @girl_scouts_permission_form.gapf_physician_phone_1,
      "PhysicianPhoneLocalNumber" => @girl_scouts_permission_form.gapf_physician_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_physician_phone_3.to_s,
      "MyInsuranceCarrier" => @girl_scouts_permission_form.gapf_my_insurance_carrier,
      "MyInsuranceCarrierPolicyNumber" => @girl_scouts_permission_form.gapf_policy,
      "SpecialNeedsMedicationsComments" => @girl_scouts_permission_form.gapf_special_needs
    })
    # raise @pdftk.fields(form_pdf_path).to_yaml
  end

end
