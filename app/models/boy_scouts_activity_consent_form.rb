class BoyScoutsActivityConsentForm < ActiveRecord::Base
  belongs_to :user
  belongs_to :boy_scouts_roster
  belongs_to :boy_scouts_activity
  validates_uniqueness_of :boy_scouts_activity_id, :scope => [:boy_scout_id]


  def self.activity_parent_permission_form_pdf_generater(activity, boy_scouts_permission_form, permission_form_path)
    @activity = activity
    @boy_scouts_permission_form = boy_scouts_permission_form
    @boy_scout = @boy_scouts_permission_form.boy_scouts_roster
    form_pdf_path = "#{BOY_SCOUTS_ACTIVITY_CONSENT_FORM_PATH}"
    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)

    if @boy_scouts_permission_form.bacf_birthdate
      @You_Age = Date.today.strftime('%Y%m%d').to_i - @boy_scouts_permission_form.bacf_birthdate.strftime('%Y%m%d').to_i
      @You_Age = @You_Age.to_s.split('')
    end

    @pdftk.fill_form(form_pdf_path, permission_form_path, {
      "Adult_Tour_Leader" => @activity.leader_first_name.to_s + ' ' + @activity.leader_last_name.to_s,
      "Adult_Tour_Leader_Phone" => (@activity.leader_phone_1 ? (@activity.leader_phone_1.to_s + '-') : '') + (@activity.leader_phone_2 ? (@activity.leader_phone_2.to_s + '-') : '') + @activity.leader_phone_3.to_s,
      "Adult_Tour_Leader_Email" => @activity.leader_email,
      "Date_From" => @activity.activity_date_begin,
      "Date_To" => @activity.activity_date_end,
      "Has_approval_to_participate" => @activity.activity_name,
      "First_name_of_participant" => @boy_scout.first_name,
      "Middle_initial" => @boy_scout.middle_name,
      "Last_name" => @boy_scout.last_name,
      "Birthdate_Month" => @boy_scouts_permission_form.bacf_birthdate ? @boy_scouts_permission_form.bacf_birthdate.strftime('%m') : '',
      "Birthdate_Day" => @boy_scouts_permission_form.bacf_birthdate ? @boy_scouts_permission_form.bacf_birthdate.strftime('%d') : '',
      "Birthdate_Year" => @boy_scouts_permission_form.bacf_birthdate ? @boy_scouts_permission_form.bacf_birthdate.strftime('%Y') : '',
      "Age_during_activity" => @You_Age ? @You_Age[0].to_s + @You_Age[1].to_s + 'Y' + ' ' + @You_Age[2].to_s + @You_Age[3].to_s + 'M' : '',
      "Address" => (@boy_scouts_permission_form.bacf_address_1 ? (@boy_scouts_permission_form.bacf_address_1.to_s + ', ') : '') + @boy_scouts_permission_form.bacf_address_2.to_s,
      "City" => @boy_scouts_permission_form.bacf_address_city,
      "State" => @boy_scouts_permission_form.bacf_address_state,
      "Zip" => @boy_scouts_permission_form.bacf_address_zip,
      "Without_Restrictions" => @boy_scouts_permission_form.bacf_restriction ? (@boy_scouts_permission_form.bacf_restriction == 'without_restrictions' ? 'Yes' : 'No') : '',
      "Special_considerations" => @boy_scouts_permission_form.bacf_spcl_considerations_for_restriction,
      "With_Restrictions" => @boy_scouts_permission_form.bacf_restriction ? (@boy_scouts_permission_form.bacf_restriction == 'with_restrictions' ? 'Yes' : 'No') : '',
      "Parentguardian_printed_name" => @boy_scouts_permission_form.bacf_parent_first_name.to_s + ' ' + @boy_scouts_permission_form.bacf_parent_last_name.to_s,
      "Area_code_and_telephone_number_best_contact_and_emergency_contact" => @boy_scouts_permission_form.bacf_parent_phone_1.to_s + '-' + @boy_scouts_permission_form.bacf_parent_phone_2.to_s + '-' + @boy_scouts_permission_form.bacf_parent_phone_3.to_s,
      "Parentguardian_Email" => @boy_scouts_permission_form.email
    })
    # raise @pdftk.fields(form_pdf_path).to_yaml
  end


end
