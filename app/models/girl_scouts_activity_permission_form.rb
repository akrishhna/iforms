class GirlScoutsActivityPermissionForm < ActiveRecord::Base
  belongs_to :user
  belongs_to :girls_scout
  belongs_to :girl_scouts_activity
  validates_uniqueness_of :girl_scouts_activity_id, :scope => [:girls_scout_id]
  #alidates_presence_of :gapf_emergency_contact_1_first_name,:gapf_emergency_contact_1_last_name,:gapf_emergency_contact_1_phone_1_1,:gapf_emergency_contact_1_phone_1_2,:gapf_emergency_contact_1_phone_1_3,:gapf_girl_scouts_first_name,:gapf_emergency_contact_3_last_name,:gapf_physician_first_name,:gapf_physician_last_name,:gapf_physician_phone_1,:gapf_physician_phone_2,:gapf_physician_phone_3,:gapf_policy,:gapf_my_insurance_carrier


  #def self.activity_parent_permission_form_pdf_generater(activity, girl_scouts_permission_form, permission_form_path)
  #  @activity = activity
  #  @girl_scouts_permission_form = girl_scouts_permission_form
  #  @girl_scout = @girl_scouts_permission_form.girls_scout
  #  #@girl_scouts_permission_form = girl_scouts_permission_form
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
  #    "Cost" => @activity.activity_cost_dollars.to_s + '.' + @activity.activity_cost_cents.to_s,
  #    "GirlsShouldWearOther" => @activity.activity_girls_wear_others,
  #    "GirlsShouldWearUniforms" => @activity.girls_wear_checkbox ? "Yes" : "Off",
  #    "GirlsShouldBring" => @activity.activity_girls_bring,
  #    "EquipmentNeeded" => @activity.activity_equipment,
  #    "SignedPermissionFormDueDate" => @activity.activity_signed_permission_due_date ? @activity.activity_signed_permission_due_date.strftime("%m/%d/%Y") : '',
  #    "TroopNumber" => @activity.troop_number,
  #    "PAL" => @activity.troop_pal,
  #    "DaughterName" => @girl_scout.first_name.to_s + ' ' + @girl_scout.last_name.to_s,
  #    "EmergencyContact1Name" => @girl_scouts_permission_form.gapf_emergency_contact_1_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_1_last_name.to_s,
  #    "EmergencyContact2Name" => @girl_scouts_permission_form.gapf_emergency_contact_2_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_2_last_name.to_s,
  #    "EmergencyContact3Name" => @girl_scouts_permission_form.gapf_emergency_contact_3_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_3_last_name.to_s,
  #    "EmergencyContact1PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_3.to_s,
  #    "EmergencyContact2PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_3.to_s,
  #    "EmergencyContact3PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_3.to_s,
  #    "EmergencyContact1AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_3.to_s,
  #    "EmergencyContact2AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_3.to_s,
  #    "EmergencyContact3AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_3.to_s,
  #    "PhysicianName" => @girl_scouts_permission_form.gapf_physician_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_physician_last_name.to_s,
  #    "PhysicianPhoneAreaCode" => @girl_scouts_permission_form.gapf_physician_phone_1,
  #    "PhysicianPhoneLocalNumber" => @girl_scouts_permission_form.gapf_physician_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_physician_phone_3.to_s,
  #    "MyInsuranceCarrier" => @girl_scouts_permission_form.gapf_my_insurance_carrier,
  #    "MyInsuranceCarrierPolicyNumber" => @girl_scouts_permission_form.gapf_policy,
  #    "SpecialNeedsMedicationsComments" => @girl_scouts_permission_form.gapf_special_needs
  #  })
  #  # raise @pdftk.fields(form_pdf_path).to_yaml
  #end
  #
  #
  #def self.activity_parent_diamonds_permission_form_pdf_generater(activity, girl_scouts_permission_form, permission_form_path)
  #  @activity = activity
  #  @girl_scouts_permission_form = girl_scouts_permission_form
  #  @girl_scout = @girl_scouts_permission_form.girls_scout
  #  #@girl_scouts_permission_form = girl_scouts_permission_form
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
  #    "ForExpenses" => @activity.activity_cost_dollars ? (@activity.activity_cost_dollars.to_s + '.' + @cents.to_s) : 'Free!',
  #    "TroopLeaderEmergencyContactName" => @activity.troop_leader_emergency_contact_first_name.to_s + ' ' + @activity.troop_leader_emergency_contact_last_name.to_s,
  #    "TroopLeaderEmergencyContactPhoneNumber" => @activity.troop_leader_emergency_contact_phone_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_3.to_s,
  #    "TroopLeaderEmergencyContactCellNumber" => @activity.troop_leader_emergency_contact_cell_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_3.to_s,
  #    "TroopLeaderEmergencyContactNameAddress" => @activity.troop_leader_emergency_contact_name_address_street.to_s + ',' + @activity.troop_leader_emergency_contact_name_address_line.to_s + ',' + @activity.troop_leader_emergency_contact_name_address_city.to_s + ',' + @activity.troop_leader_emergency_contact_name_address_state.to_s + ',' + @activity.troop_leader_emergency_contact_name_address_country.to_s + ',' + @activity.troop_leader_emergency_contact_name_address_zip.to_s,
  #    "DaughterName" => @girl_scout.first_name.to_s + ' ' + @girl_scout.last_name.to_s,
  #    "ActInMyBehalfName" => @girl_scouts_permission_form.act_in_my_behalf_first_name.to_s + ' ' + @girl_scouts_permission_form.act_in_my_behalf_last_name.to_s,
  #    "ParentPhoneNumberDuringActivity" => @girl_scouts_permission_form.parent_phone_number_during_activity_1.to_s + '-' + @girl_scouts_permission_form.parent_phone_number_during_activity_2.to_s + '-' + @girl_scouts_permission_form.parent_phone_number_during_activity_3.to_s,
  #    "EmergencyContactName" => @girl_scouts_permission_form.emergency_contact_first_name.to_s + ' ' + @girl_scouts_permission_form.emergency_contact_last_name.to_s,
  #    "EmergencyContactPhoneNumber" => @girl_scouts_permission_form.emergency_contact_phone_number_1.to_s + '-' + @girl_scouts_permission_form.emergency_contact_phone_number_2.to_s + '-' + @girl_scouts_permission_form.emergency_contact_phone_number_3.to_s,
  #    "EmergencyContactCellNumber" => @girl_scouts_permission_form.emergency_contact_cell_number_1.to_s + '-' + @girl_scouts_permission_form.emergency_contact_cell_number_2.to_s + '-' + @girl_scouts_permission_form.emergency_contact_cell_number_3.to_s,
  #    "EmergencyContactAddress" => @girl_scouts_permission_form.emergency_contact_address_street.to_s + (@girl_scouts_permission_form.emergency_contact_address_line.to_s.present? ? (', ' + @girl_scouts_permission_form.emergency_contact_address_line.to_s) : ' '),
  #    "EmergencyContactCity" => @girl_scouts_permission_form.emergency_contact_address_city.to_s,
  #    "EmergencyContactState" => @girl_scouts_permission_form.emergency_contact_address_state.to_s,
  #    "EmergencyContactRelationshipToParticipant" => @girl_scouts_permission_form.emergency_contact_relationship_to_participant.to_s,
  #    "Medications" => @girl_scouts_permission_form.medications
  #  })
  #   #raise @pdftk.fields(form_pdf_path).to_yaml
  #end


  def self.activity_parent_permission_form_pdf_generater(activity, girl_scouts_permission_form, permission_form_path, form_pdf_path, fields)

    @activity = activity
    @girl_scouts_permission_form = girl_scouts_permission_form
    @girl_scout = @girl_scouts_permission_form.girls_scout
    @fields = fields

    #@girl_scouts_permission_form = girl_scouts_permission_form

    # form_pdf_path = "#{CENTRAL_TEXAS_FORM_PATH}"

    if !@activity.activity_cost_cents.nil?
      @cents = @activity.activity_cost_cents <= 9 ? ('0' + @activity.activity_cost_cents.to_s) : @activity.activity_cost_cents.to_s
    else
      @cents = '00'
    end

    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
    @pdftk.fill_form(form_pdf_path, permission_form_path, {

      # activity Tab

      "ActivityName" => @activity.activity_name,

      "ActivityLocation" => @activity.activity_location,
      "ActivityLocationPhone" => @activity.activity_location_phone_1.to_s + '-' + @activity.activity_location_phone_2.to_s + '-' + @activity.activity_location_phone_3.to_s,

      "ActivityDateBeginMonth" => @activity.activity_date_begin.to_s.split("-")[1],
      "ActivityDateBeginDay" => @activity.activity_date_begin.to_s.split("-")[2],
      "ActivityDateBeginYear" => @activity.activity_date_begin.to_s.split("-")[0],
      "ActivityDate" => @activity.activity_date_begin.strftime('%m-%d-%Y'),

      "ActivityDateEndMonth" => @activity.activity_date_end.to_s.split("-")[1],
      "ActivityDateEndDay" => @activity.activity_date_end.to_s.split("-")[2],
      "ActivityDateEndYear" => @activity.activity_date_end.to_s.split("-")[0],

      "SignedPermissionFormDueDate" => (@activity.activity_signed_permission_due_date ? @activity.activity_signed_permission_due_date.strftime("%m/%d/%Y") : ''),

      "ActivityTime" => @activity.activity_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_time_am_pm.to_s,
      "ActivityStartTime" => @activity.activity_start_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_start_time_mm.to_s.rjust(2, '0'),
      "ActivityEndTime" => @activity.activity_end_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_end_time_mm.to_s.rjust(2, '0'),

      "WeWillLeaveFrom" => @activity.activity_leave_from,
      "WeWillLeaveFromTime" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0'),
      "WeWillLeaveFromTimeAM" => @activity.activity_leave_time_am_pm == "AM" ? "Yes" : "Off",
      "WeWillLeaveFromTimePM" => @activity.activity_leave_time_am_pm == "PM" ? "Yes" : "Off",
      "TimeAndPlaceOfDeparture" => @activity.activity_leave_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_leave_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_leave_time_am_pm + ', ' + @activity.activity_leave_from,

      "WeWillReturnTo" => @activity.activity_return_to,
      "WeWillReturnToTime" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0'),
      "WeWillReturnToTimeAM" => @activity.activity_return_time_am_pm == "AM" ? "Yes" : "Off",
      "WeWillReturnToTimePM" => @activity.activity_return_time_am_pm == "PM" ? "Yes" : "Off",
      "TimeAndPlaceOfReturn" => @activity.activity_return_time_hh.to_s.rjust(2, '0') + ':' + @activity.activity_return_time_mm.to_s.rjust(2, '0') + ' ' + @activity.activity_return_time_am_pm + ', ' + @activity.activity_return_to,

      "Cost" => @activity.activity_cost_dollars ? @activity.activity_cost_dollars.to_s + '.' + @cents.to_s : 'Free!',
      "ForExpenses" => @activity.activity_cost_dollars ? ('$' + @activity.activity_cost_dollars.to_s + '.' + @cents.to_s) : 'Free!',

      "CostUsedFor" => @activity.activity_cost_used_for,
      "AdditonalExpenses" => @activity.activity_additional_expenses,

      "GirlsShouldWearUniforms" => @activity.girls_wear_checkbox ? "Yes" : "Off",
      "GirlsShouldWearOther" => @activity.activity_girls_wear_others,
      "GirlsShouldBring" => @activity.activity_girls_bring,

      "ModeOfTransportation" => @activity.mode_of_transportation,

      "AdultsAccompanyingGirls" => @activity.adults_accompanying_girls,

      "EquipmentNeeded" => @activity.activity_equipment,
      "OtherEquipmentOrClothing" => @activity.activity_equipment,
      "ClothingAndAdditionalItemsNeeded" => @activity.activity_equipment,

      # Troop Tab

      "ServiceUnit" => @activity.troop_service_unit,
      "PAL" => @activity.troop_pal,
      "TroopNumber" => @activity.troop_number,
      "TroopGroup" => @activity.troop_number,

      # Troop Leader Tab

      "TroopLeaderName" => @activity.leader_first_name + " " + @activity.leader_last_name,
      "TroopLeaderEmailAddress" => @activity.leader_email,
      "TroopLeaderPhoneNumber" => @activity.troop_leader_phone_1.to_s + '-' + @activity.troop_leader_phone_2.to_s + '-' + @activity.troop_leader_phone_3.to_s,
      "TroopLeaderDayPhoneAreaCode" => @activity.leader_day_phone_1,
      "TroopLeaderDayPhoneLocalNumber" => @activity.leader_day_phone_2.to_s + '-' + @activity.leader_day_phone_3.to_s,
      "TroopLeaderEveningPhoneAreaCode" => @activity.leader_evening_phone_1,
      "TroopLeaderEveningPhoneLocalNumber" => @activity.leader_evening_phone_2.to_s + '-' + @activity.leader_evening_phone_3.to_s,
      "TroopLeaderMobilePhoneAreaCode" => @activity.leader_cell_phone_1,
      "TroopLeaderMobilePhoneLocalNumber" => @activity.leader_cell_phone_2.to_s + '-' + @activity.leader_cell_phone_3.to_s,

      "LeaderAdvisor1Name" => @activity.leader_advisor_1_first_name.to_s + ' ' + @activity.leader_advisor_1_last_name.to_s,
      "LeaderAdvisor1Phone" => @activity.leader_advisor_1_phone_1.to_s + '-' + @activity.leader_advisor_1_phone_2.to_s + '-' + @activity.leader_advisor_1_phone_3.to_s,
      "LeaderAdvisor1Cell" => @activity.leader_advisor_1_cell_1.to_s + '-' + @activity.leader_advisor_1_cell_2.to_s + '-' + @activity.leader_advisor_1_cell_3.to_s,
      "LeaderAdvisor2Name" => @activity.leader_advisor_2_first_name.to_s + ' ' + @activity.leader_advisor_2_last_name.to_s,
      "LeaderAdvisor2Phone" => @activity.leader_advisor_2_phone_1.to_s + '-' + @activity.leader_advisor_2_phone_2.to_s + '-' + @activity.leader_advisor_2_phone_3.to_s,
      "LeaderAdvisor2Cell" => @activity.leader_advisor_2_cell_1.to_s + '-' + @activity.leader_advisor_2_cell_2.to_s + '-' + @activity.leader_advisor_2_cell_3.to_s,

      "LeadersAccompanyingGirls" => @activity.troop_leader_accompanying_girls,

      # Troop Emergency Tab

      "TroopLeaderEmergencyContactName" => @fields['Troop Emergency Name'] ? (@activity.emergency_first_name + ' ' + @activity.emergency_last_name) : (@fields['Troop Emergency Contact Name'] ? (@activity.troop_leader_emergency_contact_first_name.to_s + ' ' + @activity.troop_leader_emergency_contact_last_name.to_s) : ''),
      "TroopLeaderEmergencyContactDayPhoneAreaCode" =>  @activity.emergency_day_phone_1,
      "TroopLeaderEmergencyContactDayPhoneLocalNumber" => @activity.emergency_day_phone_2.to_s + '-' + @activity.emergency_day_phone_3.to_s,
      "TroopLeaderEmergencyContactEveningPhoneAreaCode" => @activity.emergency_evening_phone_1,
      "TroopLeaderEmergencyContactEveningPhoneLocalNumber" => @activity.emergency_evening_phone_2.to_s + '-' + @activity.emergency_evening_phone_3.to_s,

      "TroopLeaderEmergencyContactPhoneNumber" => @activity.troop_leader_emergency_contact_phone_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_phone_number_3.to_s,
      "TroopLeaderEmergencyContactCellNumber" => @activity.troop_leader_emergency_contact_cell_number_1.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_2.to_s + '-' + @activity.troop_leader_emergency_contact_cell_number_3.to_s,
      "TroopLeaderEmergencyContactNameAddress" => @activity.troop_leader_emergency_contact_name_address_street.to_s + ', ' + (@activity.troop_leader_emergency_contact_name_address_line.to_s.present? ? (@activity.troop_leader_emergency_contact_name_address_line.to_s + ', ') : ' ') + @activity.troop_leader_emergency_contact_name_address_city.to_s + ' ' + @activity.troop_leader_emergency_contact_name_address_state.to_s + ' ' + @activity.troop_leader_emergency_contact_name_address_zip.to_s,

      "ActivityWillOrMayInvolveUnusualRisk" => @activity.activity_will_involve_unusual_risk == 'Yes' ? 'Yes' : 'No',

      #others

      "ProgramYearFrom" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0] : @activity.activity_date_begin.to_s.split("-")[0].to_i - 1 : '',
      "ProgramYearTo" => @activity.activity_date_begin ? (@activity.activity_date_begin.to_s.split("-")[1].to_i == 10 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 11 || @activity.activity_date_begin.to_s.split("-")[1].to_i == 12) ? @activity.activity_date_begin.to_s.split("-")[0].to_i + 1 : @activity.activity_date_begin.to_s.split("-")[0] : '',

      # permission form

      "DaughterName" => @girl_scout.first_name.to_s + ' ' + @girl_scout.last_name.to_s,

      "EmergencyContact1Name" => @girl_scouts_permission_form.gapf_emergency_contact_1_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_1_last_name.to_s,
      "EmergencyContact1PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_1_3.to_s,
      "EmergencyContact1AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_1_phone_2_3.to_s,

      "ActInMyBehalfName" => @girl_scouts_permission_form.act_in_my_behalf_first_name.to_s + ' ' + @girl_scouts_permission_form.act_in_my_behalf_last_name.to_s,
      "ParentAddressDuringActivity" => @girl_scouts_permission_form.act_in_my_behalf_address_1.to_s + (@girl_scouts_permission_form.act_in_my_behalf_address_2.to_s.present? ? (', ' + @girl_scouts_permission_form.act_in_my_behalf_address_2.to_s) + ' ' + @girl_scouts_permission_form.act_in_my_behalf_address_city.to_s + ' ' + @girl_scouts_permission_form.act_in_my_behalf_address_state.to_s + ' ' + @girl_scouts_permission_form.act_in_my_behalf_address_zip.to_s : ' '),

      "ParentPhoneNumberDuringActivity" => @girl_scouts_permission_form.parent_phone_number_during_activity_1.to_s + '-' + @girl_scouts_permission_form.parent_phone_number_during_activity_2.to_s + '-' + @girl_scouts_permission_form.parent_phone_number_during_activity_3.to_s,

      "EmergencyContact2Name" => @girl_scouts_permission_form.gapf_emergency_contact_2_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_2_last_name.to_s,
      "EmergencyContact2PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_1_3.to_s,
      "EmergencyContact2AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_2_phone_2_3.to_s,

      "EmergencyContactName" => @girl_scouts_permission_form.emergency_contact_first_name.to_s + ' ' + @girl_scouts_permission_form.emergency_contact_last_name.to_s,
      "EmergencyContactPhoneNumber" => @girl_scouts_permission_form.emergency_contact_phone_number_1.to_s + '-' + @girl_scouts_permission_form.emergency_contact_phone_number_2.to_s + '-' + @girl_scouts_permission_form.emergency_contact_phone_number_3.to_s,
      "EmergencyContactCellNumber" => @girl_scouts_permission_form.emergency_contact_cell_number_1.to_s + '-' + @girl_scouts_permission_form.emergency_contact_cell_number_2.to_s + '-' + @girl_scouts_permission_form.emergency_contact_cell_number_3.to_s,

      "EmergencyContact3Name" => @girl_scouts_permission_form.gapf_emergency_contact_3_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_emergency_contact_3_last_name.to_s,
      "EmergencyContact3PhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_1_3.to_s,
      "EmergencyContact3AlternatePhoneNumber" => @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_1.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_2.to_s + '-' + @girl_scouts_permission_form.gapf_emergency_contact_3_phone_2_3.to_s,

      "PhysicianName" => @girl_scouts_permission_form.gapf_physician_first_name.to_s + ' ' + @girl_scouts_permission_form.gapf_physician_last_name.to_s,
      "PhysicianPhoneAreaCode" => @girl_scouts_permission_form.gapf_physician_phone_1,
      "PhysicianPhoneLocalNumber" => @girl_scouts_permission_form.gapf_physician_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_physician_phone_3.to_s,
      "PhysicianPhoneNumber" => @girl_scouts_permission_form.gapf_physician_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_physician_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_physician_phone_3.to_s,

      "MyInsuranceCarrier" => @girl_scouts_permission_form.gapf_my_insurance_carrier,
      "MyInsuranceCarrierPolicyNumber" =>  @girl_scouts_permission_form.gapf_policy,

      "EmergencyContactAddress" => @girl_scouts_permission_form.emergency_contact_address_street.to_s + (@girl_scouts_permission_form.emergency_contact_address_line.to_s.present? ? (', ' + @girl_scouts_permission_form.emergency_contact_address_line.to_s) : ' '),
      "EmergencyContactCity" => @girl_scouts_permission_form.emergency_contact_address_city.to_s,
      "EmergencyContactState" => @girl_scouts_permission_form.emergency_contact_address_state.to_s,
      "EmergencyContactAddressCityStateZip" => @girl_scouts_permission_form.emergency_contact_address_street.to_s + (@girl_scouts_permission_form.emergency_contact_address_line.to_s.present? ? (', ' + @girl_scouts_permission_form.emergency_contact_address_line.to_s) + ' ' + @girl_scouts_permission_form.emergency_contact_address_city.to_s + ' ' + @girl_scouts_permission_form.emergency_contact_address_state.to_s + ' ' + @girl_scouts_permission_form.emergency_contact_address_zip.to_s : ' '),

      "EmergencyContactRelationshipToParticipant" => @girl_scouts_permission_form.emergency_contact_relationship_to_participant.to_s,
      "ActInMyBehalfRelationshipToParticipant" => @girl_scouts_permission_form.gapf_activity_my_behalf_relationship_to_participant.to_s,

      "SpecialNeedsMedicationsComments" => @girl_scouts_permission_form.gapf_special_needs,
      "Medications" => @girl_scouts_permission_form.medications,

      "ChangesToGeneralPermissionSlip" => @girl_scouts_permission_form.gapf_changes_to_general_permission_slip,
      "SpecialNeeds" => @girl_scouts_permission_form.gapf_special_needs_yes_or_no == 'Yes' ? 'On' : 'Off' ,
      "NoSpecialNeeds" => @girl_scouts_permission_form.gapf_special_needs_yes_or_no == 'No' ? 'Off' : 'On',
      "UnusualRiskAcknowledgement" => @girl_scouts_permission_form.gapf_unusual_risk_acknowledgement == 'Yes' ? 'On' : 'Off',
      "Parent1AddressCityStateZip" => @girl_scouts_permission_form.gapf_parent_1_address_1.to_s + (@girl_scouts_permission_form.gapf_parent_1_address_2.to_s.present? ? (', ' + @girl_scouts_permission_form.gapf_parent_1_address_2.to_s) + ' ' + @girl_scouts_permission_form.gapf_parent_1_address_city.to_s + ' ' + @girl_scouts_permission_form.gapf_parent_1_address_state.to_s + ' ' + @girl_scouts_permission_form.gapf_parent_1_address_zip.to_s : ' '),
      "Parent1HomePhone" => @girl_scouts_permission_form.gapf_parent_1_home_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_home_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_home_phone_3.to_s + '            ' + @girl_scouts_permission_form.gapf_parent_1_work_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_work_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_work_phone_3.to_s,
      "Parent1MobilePhone" => @girl_scouts_permission_form.gapf_parent_1_mobile_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_mobile_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_mobile_phone_3.to_s + '           ' + @girl_scouts_permission_form.gapf_parent_1_other_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_other_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_1_other_phone_3.to_s,
      "Parent1EmailAddress" => @girl_scouts_permission_form.gapf_parent_1_email,
      "Parent2AddressCityStateZip" => @girl_scouts_permission_form.gapf_parent_2_address_1.to_s + (@girl_scouts_permission_form.gapf_parent_2_address_2.to_s.present? ? (', ' + @girl_scouts_permission_form.gapf_parent_2_address_2.to_s) + ' ' + @girl_scouts_permission_form.gapf_parent_2_address_city.to_s + ' ' + @girl_scouts_permission_form.gapf_parent_2_address_state.to_s + ' ' + @girl_scouts_permission_form.gapf_parent_2_address_zip.to_s : ' '),
      "Parent2HomePhone" => @girl_scouts_permission_form.gapf_parent_2_home_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_home_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_home_phone_3.to_s + '            ' + @girl_scouts_permission_form.gapf_parent_2_work_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_work_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_work_phone_3.to_s,
      "Parent2MobilePhone" => @girl_scouts_permission_form.gapf_parent_2_mobile_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_mobile_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_mobile_phone_3.to_s + '            ' + @girl_scouts_permission_form.gapf_parent_2_other_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_other_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_parent_2_other_phone_3.to_s,
      "Parent2EmailAddress" => @girl_scouts_permission_form.gapf_parent_2_email,

      "ActInMyBehalfPhoneNumber" => @girl_scouts_permission_form.gapf_activity_my_behalf_phone_1.to_s + '-' + @girl_scouts_permission_form.gapf_activity_my_behalf_phone_2.to_s + '-' + @girl_scouts_permission_form.gapf_activity_my_behalf_phone_3.to_s,
      "AdditionalRemarks" => @girl_scouts_permission_form.gapf_additional_remarks,
    })
    #raise @pdftk.fields(form_pdf_path).to_yaml
  end


end
