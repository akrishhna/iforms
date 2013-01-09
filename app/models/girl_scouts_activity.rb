class GirlScoutsActivity < ActiveRecord::Base
  belongs_to :user
  has_many :girl_scouts_activity_permission_forms, :dependent => :destroy

  validates_presence_of :activity_name, :activity_signed_permission_due_date

  #,:leader_first_name,:leader_last_name
  # validates_presence_of :activity_name,:activity_location,:activity_date_begin,:activity_date_end,:activity_signed_permission_due_date,:activity_leave_from,:activity_leave_time_hh,:activity_leave_time_mm,:activity_leave_time_am_pm,:activity_return_to,:activity_return_time_hh,:activity_return_time_mm,:activity_return_time_am_pm,:activity_cost_dollars,:activity_cost_cents
  # validates_presence_of :troop_service_unit,:troop_pal,:troop_number
  # validates_presence_of :leader_first_name,:leader_last_name,:leader_day_phone_1,:leader_day_phone_2,:leader_day_phone_3
  # validates_presence_of :emergency_first_name,:emergency_last_name,:emergency_day_phone_1,:emergency_day_phone_2,:emergency_day_phone_3

  #def self.activity_permission_form_pdf_generater(activity, permission_form_path)
  #  @activity = activity
  #  if !@activity.activity_cost_cents.nil?
  #    @cents = @activity.activity_cost_cents <= 9 ? ('0' + @activity.activity_cost_cents.to_s) : @activity.activity_cost_cents.to_s
  #  else
  #    @cents = '00'
  #  end
  #  form_pdf_path = "#{CENTRAL_TEXAS_FORM_PATH}"
  #  @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
  #  @pdftk.fill_form(form_pdf_path, permission_form_path, {
  #    "ServiceUnit" => @activity.troop_service_unit,
  #    "ProgramYearFrom" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0] : @activity.activity_date_begin.to_s.split("-")[0].to_i - 1 : '',
  #    "ProgramYearTo" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0].to_i + 1 : @activity.activity_date_begin.to_s.split("-")[0] : '',
  #    "TroopLeaderName" => @activity.leader_first_name + " " + @activity.leader_last_name,
  #    "TroopLeaderEmailAddress" => @activity.leader_email,
  #    "TroopLeaderDayPhoneAreaCode" => @activity.leader_day_phone_1,
  #    "TroopLeaderDayPhoneLocalNumber" => @activity.leader_day_phone_2.to_s + '-' + @activity.leader_day_phone_3.to_s,
  #    "TroopLeaderEveningPhoneAreaCode" => @activity.leader_evening_phone_1,
  #    "TroopLeaderEveningPhoneLocalNumber" => @activity.leader_evening_phone_2.to_s + '-' + @activity.leader_evening_phone_3.to_s,
  #    "TroopLeaderEmergencyContactName" => @activity.emergency_first_name + ' ' + @activity.emergency_last_name,
  #    "TroopLeaderMobilePhoneAreaCode" => @activity.leader_cell_phone_1,
  #    "TroopLeaderMobilePhoneLocalNumber" => @activity.leader_cell_phone_2.to_s + '-' + @activity.leader_cell_phone_3.to_s,
  #    "TroopLeaderEmergencyContactDayPhoneAreaCode" => @activity.emergency_day_phone_1,
  #    "TroopLeaderEmergencyContactDayPhoneLocalNumber" => @activity.emergency_day_phone_2.to_s + '-' + @activity.emergency_day_phone_3.to_s,
  #    "TroopLeaderEmergencyContactEveningPhoneAreaCode" => @activity.emergency_evening_phone_1,
  #    "TroopLeaderEmergencyContactEveningPhoneLocalNumber" => @activity.emergency_evening_phone_2.to_s + '-' + @activity.emergency_evening_phone_3.to_s,
  #    "ActivityName" => @activity.activity_name,
  #    "ActivityLocation" => @activity.activity_location,
  #    "ActivityDateBeginMonth" => @activity.activity_date_begin.to_s.split("-")[1],
  #    "ActivityDateBeginDay" => @activity.activity_date_begin.to_s.split("-")[2],
  #    "ActivityDateBeginYear" => @activity.activity_date_begin.to_s.split("-")[0],
  #    "ActivityDateEndMonth" => @activity.activity_date_end.to_s.split("-")[1],
  #    "ActivityDateEndDay" => @activity.activity_date_end.to_s.split("-")[2],
  #    "ActivityDateEndYear" => @activity.activity_date_end.to_s.split("-")[0],
  #    "WeWillLeaveFrom" => @activity.activity_leave_from,
  #    "WeWillLeaveFromTime" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0'),
  #    "WeWillLeaveFromTimeAM" => @activity.activity_leave_time_am_pm == "AM" ? "Yes" : "Off",
  #    "WeWillLeaveFromTimePM" => @activity.activity_leave_time_am_pm == "PM" ? "Yes" : "Off",
  #    "WeWillReturnTo" => @activity.activity_return_to,
  #    "WeWillReturnToTime" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0'),
  #    "WeWillReturnToTimeAM" => @activity.activity_return_time_am_pm == "AM" ? "Yes" : "Off",
  #    "WeWillReturnToTimePM" => @activity.activity_return_time_am_pm == "PM" ? "Yes" : "Off",
  #    "Cost" => @activity.activity_cost_dollars ? (@activity.activity_cost_dollars.to_s + '.' + @cents.to_s) : 'Free!',
  #    "GirlsShouldWearOther" => @activity.activity_girls_wear_others,
  #    "GirlsShouldWearUniforms" => @activity.girls_wear_checkbox ? "Yes" : "Off",
  #    "GirlsShouldBring" => @activity.activity_girls_bring,
  #    "EquipmentNeeded" => @activity.activity_equipment,
  #    "SignedPermissionFormDueDate" => @activity.activity_signed_permission_due_date ? @activity.activity_signed_permission_due_date.strftime("%m/%d/%Y") : '',
  #    "TroopNumber" => @activity.troop_number,
  #    "PAL" => @activity.troop_pal
  #  })
  #  # raise @pdftk.fields(form_pdf_path).to_yaml
  #end
  #
  #def self.activity_permission_diamonds_form_pdf_generater(activity, permission_form_path)
  #  @activity = activity
  #  if !@activity.activity_cost_cents.nil?
  #    @cents = @activity.activity_cost_cents <= 9 ? ('0' + @activity.activity_cost_cents.to_s) : @activity.activity_cost_cents.to_s
  #  else
  #    @cents = '00'
  #  end
  #  form_pdf_path = "#{DIAMONDS_FORM_PATH}"
  #  @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
  #  @pdftk.fill_form(form_pdf_path, permission_form_path, {
  #    "TroopNumber" => @activity.troop_number,
  #    "ActivityName" => @activity.activity_name,
  #    "ActivityDate" => @activity.activity_date_begin,
  #    "ActivityLocation" => @activity.activity_location,
  #    "TimeAndPlaceOfDeparture" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_leave_time_am_pm + ', ' + @activity.activity_leave_from,
  #    "TimeAndPlaceOfReturn" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_return_time_am_pm + ', ' + @activity.activity_return_to,
  #    "ModeOfTransportation" => @activity.mode_of_transportation,
  #    "LeaderAdvisor1Name" => @activity.leader_advisor_1_first_name.to_s + ' ' + @activity.leader_advisor_1_last_name.to_s,
  #    "LeaderAdvisor1Phone" => @activity.leader_advisor_1_phone_1.to_s + '-' + @activity.leader_advisor_1_phone_2.to_s + '-' + @activity.leader_advisor_1_phone_3.to_s,
  #    "LeaderAdvisor1Cell" => @activity.leader_advisor_1_cell_1.to_s + '-' + @activity.leader_advisor_1_cell_2.to_s + '-' + @activity.leader_advisor_1_cell_3.to_s,
  #    "LeaderAdvisor2Name" => @activity.leader_advisor_2_first_name.to_s + ' ' + @activity.leader_advisor_2_last_name.to_s,
  #    "LeaderAdvisor2Phone" => @activity.leader_advisor_2_phone_1.to_s + '-' + @activity.leader_advisor_2_phone_2.to_s + '-' + @activity.leader_advisor_2_phone_3.to_s,
  #    "LeaderAdvisor2Cell" => @activity.leader_advisor_2_cell_1.to_s + '-' + @activity.leader_advisor_2_cell_2.to_s + '-' + @activity.leader_advisor_2_cell_3.to_s,
  #    "ForExpenses" => @activity.activity_cost_dollars ? ('$' + @activity.activity_cost_dollars.to_s + '.' + @cents.to_s) : 'Free!',
  #    "TroopLeaderEmergencyContactName" => @activity.troop_leader_emergency_contact_first_name.to_s + ' ' + @activity.troop_leader_emergency_contact_last_name.to_s,
  #    "TroopLeaderEmergencyContactPhoneNumber" => @activity.troop_leader_emergency_contact_phone_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_3.to_s,
  #    "TroopLeaderEmergencyContactCellNumber" => @activity.troop_leader_emergency_contact_cell_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_3.to_s,
  #    "TroopLeaderEmergencyContactNameAddress" => @activity.troop_leader_emergency_contact_name_address_street.to_s + ',' + (@activity.troop_leader_emergency_contact_name_address_line.to_s.present? ? (@activity.troop_leader_emergency_contact_name_address_line.to_s + ', ') : ' ') + @activity.troop_leader_emergency_contact_name_address_city.to_s + ' ' + @activity.troop_leader_emergency_contact_name_address_state.to_s + ' ' + @activity.troop_leader_emergency_contact_name_address_zip.to_s,
  #    "OtherEquipmentOrClothing" => @activity.activity_equipment
  #  })
  #  # raise @pdftk.fields(form_pdf_path).to_yaml
  #end


  def self.activity_permission_form_pdf_generater(activity, permission_form_path, form_pdf_path, fields)

    @activity = activity

    if !@activity.activity_cost_cents.nil?
      @cents = @activity.activity_cost_cents <= 9 ? ('0' + @activity.activity_cost_cents.to_s) : @activity.activity_cost_cents.to_s
    else
      @cents = '00'
    end

    @fields = fields
    # form_pdf_path = "#{CENTRAL_TEXAS_FORM_PATH}"

    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
    @pdftk.fill_form(form_pdf_path, permission_form_path, {

      # activity Tab

      "ActivityName" => @activity.activity_name,

      "ActivityLocation" => @activity.activity_location,
      "ActivityLocationPhone" => @activity.activity_location_phone_1.to_s + '-' + @activity.activity_location_phone_2.to_s + '-' + @activity.activity_location_phone_3.to_s,

      "ActivityDateBeginMonth" => @activity.activity_date_begin.to_s.split("-")[1],
      "ActivityDateBeginDay" => @activity.activity_date_begin.to_s.split("-")[2],
      "ActivityDateBeginYear" => @activity.activity_date_begin.to_s.split("-")[0],
      "ActivityDate" => @activity.activity_date_begin ? @activity.activity_date_begin.strftime('%m-%d-%Y') : '',

      "ActivityDateEndMonth" => @activity.activity_date_end.to_s.split("-")[1] ,
      "ActivityDateEndDay" => @activity.activity_date_end.to_s.split("-")[2] ,
      "ActivityDateEndYear" => @activity.activity_date_end.to_s.split("-")[0] ,

      #"ActivityBeginEndDate" => @activity.activity_date_begin ? @activity.activity_date_begin.strftime('%m-%d-%Y') + @activity_date_end ? activity_date_end.strftime('%m-%d-%Y'): '' : '',

      "SignedPermissionFormDueDate" => (@activity.activity_signed_permission_due_date ? @activity.activity_signed_permission_due_date.strftime("%m/%d/%Y") : '') ,

      "ActivityTime" => @activity.activity_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_time_am_pm,
      "ActivityStartTime" => @activity.activity_start_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_start_time_mm.to_s.rjust(2, '0'),
      "ActivityEndTime" => @activity.activity_end_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_end_time_mm.to_s.rjust(2, '0'),

      "WeWillLeaveFrom" => @activity.activity_leave_from,
      "WeWillLeaveFromTime" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0'),
      "WeWillLeaveFromTimeAM" => @activity.activity_leave_time_am_pm == "AM" ? "Yes" : "Off",
      "WeWillLeaveFromTimePM" => @activity.activity_leave_time_am_pm == "PM" ? "Yes" : "Off",
      "TimeAndPlaceOfDeparture" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_leave_time_am_pm + ', ' + @activity.activity_leave_from,

      "WeWillReturnTo" => @activity.activity_return_to ,
      "WeWillReturnToTime" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0'),
      "WeWillReturnToTimeAM" => @activity.activity_return_time_am_pm == "AM" ? "Yes" : "Off",
      "WeWillReturnToTimePM" => @activity.activity_return_time_am_pm == "PM" ? "Yes" : "Off",
      "TimeAndPlaceOfReturn" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_return_time_am_pm + ', ' + @activity.activity_return_to,

      "Cost" => @activity.activity_cost_dollars ? @activity.activity_cost_dollars.to_s + '.' + @cents.to_s : 'Free!',
      "ForExpenses" => @activity.activity_cost_dollars ? ('$' + @activity.activity_cost_dollars.to_s + '.' + @cents.to_s) : 'Free!',

      "CostUsedFor" => @activity.activity_cost_used_for ,
      "AdditonalExpenses" => @activity.activity_additional_expenses ,

      "GirlsShouldWearUniforms" => @activity.girls_wear_checkbox ? "Yes" : "Off",
      "GirlsShouldWearOther" => @activity.activity_girls_wear_others,
      "GirlsShouldBring" => @activity.activity_girls_bring,

      "ModeOfTransportation" => @activity.mode_of_transportation ,

      "AdultsAccompanyingGirls" => @activity.adults_accompanying_girls ,

      "EquipmentNeeded" => @activity.activity_equipment,
      "OtherEquipmentOrClothing" => @activity.activity_equipment,
      "ClothingAndAdditionalItemsNeeded" => @activity.activity_equipment,

      "Chaperone1Name" => @activity.activity_chaperone_1_name,
      "Chaperone1DriverNo" => @activity.activity_chaperone_1_driver == 'No' ? 'No_5' : '' ,
      "Chaperone1DriverYes" => @activity.activity_chaperone_1_driver == 'Yes' ? 'Yes_5' : '' ,
      "Chaperone1RegisteredNo" => @activity.activity_chaperone_1_registered == 'No' ? '1' : 'off' ,
      "Chaperone1RegisteredYes" => @activity.activity_chaperone_1_registered == 'Yes' ? 'Yes' : 'off' ,

      "Chaperone2Name" => @activity.activity_chaperone_2_name,
      "Chaperone2DriverNo" => @activity.activity_chaperone_2_driver == 'No' ? 'No_6' : '' ,
      "Chaperone2DriverYes" => @activity.activity_chaperone_2_driver == 'Yes' ? 'Yes_6' : '' ,
      "Chaperone2RegisteredNo" => @activity.activity_chaperone_2_registered == 'No' ? 'No_2' : '' ,
      "Chaperone2RegisteredYes" => @activity.activity_chaperone_2_registered == 'Yes' ? 'Yes_2' : '' ,

      "Chaperone3Name" => @activity.activity_chaperone_3_name,
      "Chaperone3DriverNo" => @activity.activity_chaperone_3_driver == 'No' ? 'No_7' : '' ,
      "Chaperone3DriverYes" => @activity.activity_chaperone_3_driver == 'Yes' ? 'Yes_7' : '' ,
      "Chaperone3RegisteredNo" => @activity.activity_chaperone_3_registered == 'No' ? 'No_3' : '' ,
      "Chaperone3RegisteredYes" => @activity.activity_chaperone_3_registered == 'Yes' ? 'Yes_3' : '' ,

      "Chaperone4Name" => @activity.activity_chaperone_4_name,
      "Chaperone4DriverNo" => @activity.activity_chaperone_4_driver == 'No' ? 'No_8' : '' ,
      "Chaperone4DriverYes" => @activity.activity_chaperone_4_driver == 'Yes' ? 'Yes_8' : '' ,
      "Chaperone4RegisteredNo" => @activity.activity_chaperone_4_registered == 'No' ? 'No_4' : '' ,
      "Chaperone4RegisteredYes" => @activity.activity_chaperone_4_registered == 'Yes' ? 'Yes_3' : '' ,

      # Troop Tab

      "ServiceUnit" =>  @activity.troop_service_unit ,
      "PAL" => @activity.troop_pal,
      "TroopNumber" => @activity.troop_number,
      "TroopGroup"  => @activity.troop_number,

      "CertifiedFirstAiderNotNeeded" => @activity.troop_leader_certified_first_aider_not_needed ? 'Yes' : 'Off',
      "CertifiedFirstAiderProvided" => @activity.troop_leader_certified_first_aider_provided ? 'Yes' : 'Off',
      "FirstAiderAttendingName" => @activity.troop_leader_first_aider_attending_first_name + ' ' + @activity.troop_leader_first_aider_attending_last_name,
      "CertificationExpirationChecked" => @activity.troop_leader_certification_expiration_checked ? 'Yes' : 'Off',
      # Troop Leader Tab

      "TroopLeaderName" => @activity.leader_first_name + " " + @activity.leader_last_name,
      "TroopLeaderEmailAddress" => @activity.leader_email,
      "TroopLeaderPhoneNumber" => @activity.troop_leader_phone_1.to_s + '-' + @activity.troop_leader_phone_2.to_s + '-' + @activity.troop_leader_phone_3.to_s,
      "TroopLeaderDayPhoneAreaCode" => @activity.leader_day_phone_1,
      "TroopLeaderDayPhoneLocalNumber" => @activity.leader_day_phone_2.to_s + '-' + @activity.leader_day_phone_3.to_s,
      "TroopLeaderEveningPhoneAreaCode" => @activity.leader_evening_phone_1 ,
      "TroopLeaderEveningPhoneLocalNumber" => @activity.leader_evening_phone_2.to_s + '-' + @activity.leader_evening_phone_3.to_s,
      "TroopLeaderMobilePhoneAreaCode" =>  @activity.leader_cell_phone_1 ,
      "TroopLeaderMobilePhoneLocalNumber" =>  @activity.leader_cell_phone_2.to_s + '-' + @activity.leader_cell_phone_3.to_s,

      "LeaderAdvisor1Name" => @fields['Troop Leader advisor 1 Name'] ? (@activity.leader_advisor_1_first_name.to_s + ' ' + @activity.leader_advisor_1_last_name.to_s) : '',
      "LeaderAdvisor1Phone" => @fields['Troop Leader advisor 1 Day Phone'] ? (@activity.leader_advisor_1_phone_1.to_s + '-' + @activity.leader_advisor_1_phone_2.to_s + '-' + @activity.leader_advisor_1_phone_3.to_s) : '',
      "LeaderAdvisor1Cell" => @fields['Troop Leader advisor 1 Cell Phone'] ? (@activity.leader_advisor_1_cell_1.to_s + '-' + @activity.leader_advisor_1_cell_2.to_s + '-' + @activity.leader_advisor_1_cell_3.to_s) : '',
      "LeaderAdvisor2Name" => @fields['Troop Leader advisor 2 Name'] ? (@activity.leader_advisor_2_first_name.to_s + ' ' + @activity.leader_advisor_2_last_name.to_s) : '',
      "LeaderAdvisor2Phone" => @fields['Troop Leader advisor 2 Day Phone'] ? (@activity.leader_advisor_2_phone_1.to_s + '-' + @activity.leader_advisor_2_phone_2.to_s + '-' + @activity.leader_advisor_2_phone_3.to_s) : '',
      "LeaderAdvisor2Cell" => @fields['Troop Leader advisor 2 Cell Phone'] ? (@activity.leader_advisor_2_cell_1.to_s + '-' + @activity.leader_advisor_2_cell_2.to_s + '-' + @activity.leader_advisor_2_cell_3.to_s) : '',

      "LeadersAccompanyingGirls" => @fields['Leaders Accompanying Girls'] ? @activity.troop_leader_accompanying_girls : '',

      # Troop Emergency Tab

      "TroopLeaderEmergencyContactName" => @fields['Troop Emergency Name'] ? (@activity.emergency_first_name + ' ' + @activity.emergency_last_name) : (@fields['Troop Emergency Contact Name'] ? (@activity.troop_leader_emergency_contact_first_name.to_s + ' ' + @activity.troop_leader_emergency_contact_last_name.to_s) : ''),
      "TroopLeaderEmergencyContactDayPhoneAreaCode" => @activity.emergency_day_phone_1,
      "TroopLeaderEmergencyContactDayPhoneLocalNumber" => @activity.emergency_day_phone_2.to_s + '-' + @activity.emergency_day_phone_3.to_s,
      "TroopLeaderEmergencyContactEveningPhoneAreaCode" => @activity.emergency_evening_phone_1,
      "TroopLeaderEmergencyContactEveningPhoneLocalNumber" => @activity.emergency_evening_phone_2.to_s + '-' + @activity.emergency_evening_phone_3.to_s,
      "TroopLeaderEmergencyContactPhoneNumber" => @activity.troop_leader_emergency_contact_phone_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_3.to_s,
      "TroopLeaderEmergencyContactCellNumber" => @activity.troop_leader_emergency_contact_cell_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_3.to_s,
      "TroopLeaderEmergencyContactNameAddress" => (@activity.troop_leader_emergency_contact_name_address_street.present? ? (@activity.troop_leader_emergency_contact_name_address_street.to_s + ', ') : ' ') + (@activity.troop_leader_emergency_contact_name_address_line.to_s.present? ? (@activity.troop_leader_emergency_contact_name_address_line.to_s + ', ') : ' ') + @activity.troop_leader_emergency_contact_name_address_city.to_s + ' ' + @activity.troop_leader_emergency_contact_name_address_state.to_s + ' ' + @activity.troop_leader_emergency_contact_name_address_zip.to_s,

      "TroopLeaderEmergencyContactNameAndPhoneNumber" => @activity.troop_leader_emergency_contact_first_name.to_s + ' ' +  @activity.troop_leader_emergency_contact_last_name.to_s + '    ' + @activity.troop_leader_emergency_contact_phone_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_3.to_s,

      "ActivityWillOrMayInvolve UnusualRisk" => @activity.activity_will_involve_unusual_risk == 'Yes' ? 'On' : 'Off',

      #others

      "ProgramYearFrom" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0] : @activity.activity_date_begin.to_s.split("-")[0].to_i - 1 : '',
      "ProgramYearTo" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0].to_i + 1 : @activity.activity_date_begin.to_s.split("-")[0] : '',

    })
    # raise @pdftk.fields(form_pdf_path).to_yaml
  end


end
