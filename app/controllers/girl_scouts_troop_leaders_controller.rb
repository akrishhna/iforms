class GirlScoutsTroopLeadersController < ApplicationController

  before_filter :set_service_provider, :girls_scouts_activities

  def index

  end

  # Girls scout roster
  def roster
    @girls_scouts = current_user.girls_scouts.order("first_name ASC")
  end

  def girl_scouts_roster
    @row_index = params[:row_index]
    @girls_scout = GirlsScout.find_or_initialize_by_id(params[:id])
    @girls_scout.user_id = current_user.id
    @girls_scout.first_name = params[:first_name]
    @girls_scout.last_name = params[:last_name]
    @girls_scout.parent_first_name = params[:parent_first_name]
    @girls_scout.parent_last_name = params[:parent_last_name]
    @girls_scout.email = params[:email]
    @girls_scout.save if @girls_scout.first_name.present? || @girls_scout.last_name.present? || @girls_scout.parent_first_name.present? || @girls_scout.parent_last_name.present? || @girls_scout.email.present?
  end

  def get_girl_scouts_row
    @row_index = params[:row_count].to_i
    @girls_scout = GirlsScout.new
  end

  def delete_girl_scouts
    @ids = params[:checked_vals]
    GirlsScout.delete(@ids.split(','))
  end

  # girls scout activities

  def activities
    if params[:id] == 'new'
      @girls_activity = GirlScoutsActivity.new()
      @recent_activity = current_user.girl_scouts_activities.order('updated_at').last
      if @recent_activity
        @girls_activity = @recent_activity.dup
      end
    elsif params[:id].present?
      @girls_activity = GirlScoutsActivity.find(params[:id])
    else
      @girls_activity = GirlScoutsActivity.find_or_initialize_by_id("")
    end

    @activities = current_user.girl_scouts_activities.order("created_at DESC")
    @activities.each do |activity|
      @girls_scouts_activities << [activity.activity_name.present? ? activity.activity_name : "Activity #" + activity.id.to_s, activity.id.to_s]
    end
  end

  def create_activity
    @activity = GirlScoutsActivity.find_or_initialize_by_id(params[:girl_scouts_activity][:id])
    @activity.user_id = current_user.id
    @activity.attributes = params[:girl_scouts_activity]
    @activity.save(:validate => false)
  end

  def send_notification_email
    @activity = GirlScoutsActivity.find(params[:id])
    if @activity.invalid?
      flash[:error] = "Something wrong please try again."

      #re organized error messages
=begin
       if @girls_scout.errors[:activity_leave_time_hh] || @girls_scout.errors[:activity_leave_time_mm] || @girls_scout.errors[:activity_leave_time_am_pm]
         @girls_scout.errors.delete(:activity_leave_time_hh)
         @girls_scout.errors.delete(:activity_leave_time_mm)
         @girls_scout.errors.delete(:activity_leave_time_am_pm)
         @girls_scout.errors[:base]  << "Activity leave time can't be blank"
       end
       if @girls_scout.errors[:activity_return_time_hh] || @girls_scout.errors[:activity_return_time_mm] || @girls_scout.errors[:activity_return_time_am_pm]
         @girls_scout.errors.delete(:activity_return_time_hh)
         @girls_scout.errors.delete(:activity_return_time_mm)
         @girls_scout.errors.delete(:activity_return_time_am_pm)
         @girls_scout.errors[:base]  << "Activity return time can't be blank"
       end
       if @girls_scout.errors[:activity_cost_dollars]  || @girls_scout.errors[:activity_cost_cents]
         @girls_scout.errors.delete(:activity_cost_dollars)
         @girls_scout.errors.delete(:activity_cost_cents)
         @girls_scout.errors[:base]  << "Activity cost can't be blank"
       end
       if @girls_scout.errors[:leader_day_phone_1] || @girls_scout.errors[:leader_day_phone_2] || @girls_scout.errors[:leader_day_phone_3]
         @girls_scout.errors.delete(:leader_day_phone_1)
         @girls_scout.errors.delete(:leader_day_phone_2)
         @girls_scout.errors.delete(:leader_day_phone_3)
         @girls_scout.errors[:base]  << "Leader day phone can't be blank"
       end
       if @girls_scout.errors[:emergency_day_phone_1] || @girls_scout.errors[:emergency_day_phone_2] || @girls_scout.errors[:emergency_day_phone_3]
         @girls_scout.errors.delete(:emergency_day_phone_1)
         @girls_scout.errors.delete(:emergency_day_phone_2)
         @girls_scout.errors.delete(:emergency_day_phone_3)
         @girls_scout.errors[:base]  << "Emergency day phone can't be blank"
       end
=end
    else
      #sending mail to all parents
      @counter = 0
      @girls_scouts = current_user.girls_scouts
      @girls_scouts.each do |girl_scout|
        email = girl_scout.email
        if email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
          @user = User.find_by_email(email)
          if @user
          @girl_scouts_activity_permission_form = GirlScoutsActivityPermissionForm.create(:user_id => @user.id,:girl_scouts_activity_id => @activity.id,:girls_scout_id => girl_scout.id,:status => 'Pending')
          else
            @girl_scouts_activity_permission_form = GirlScoutsActivityPermissionForm.create(:user_id => '',:girl_scouts_activity_id => @activity.id,:girls_scout_id => girl_scout.id,:status => 'Pending')
          end
          Notifier.send_parent_email_notification(@activity, girl_scout).deliver
          @counter += 1
        end
      end
      flash[:notice] = "Messages Successfully Sent For #{@activity.activity_name}"
    end
  end

  def delete_activity
    GirlScoutsActivity.delete(params[:id])
  end

  def show_activity
    @activity = current_user.girl_scouts_activities.find(params[:activity_id])
  end

  def activity_permission_form
    @activity = current_user.girl_scouts_activities.find(params[:activity_id])
    activity_name = @activity.activity_name.gsub(' ', '-')
    activity_name = "Activity-#{@activity.id}" if !activity_name.present?
    permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
    activity_permission_form_pdf_generater(@activity,permission_form_path)
    send_file permission_form_path,
              :filename => "#{activity_name}.pdf",
              :disposition => "inline",
              :type => "application/pdf"
  end

  def activity_permission_form_pdf_generater(activity,permission_form_path)
    @activity = activity
    form_pdf_path = "#{PDFFILES_PATH}Parent_Permission_iForms.pdf"
    @pdftk = PdftkForms::Wrapper.new(PDFTK_PATH)
    @pdftk.fill_form(form_pdf_path, permission_form_path, {
      "ServiceUnit" => @activity.troop_service_unit,
      "ProgramYearFrom" => "",
      "ProgramYearTo" => "",
      "TroopLeaderName" => @activity.leader_first_name + " " + @activity.leader_last_name,
      "TroopLeaderEmailAddress" => @activity.leader_email,
      "TroopLeaderDayPhoneAreaCode" => @activity.leader_day_phone_1,
      "TroopLeaderDayPhoneLocalNumber" => @activity.leader_day_phone_2.to_s + '' + @activity.leader_day_phone_3.to_s,
      "TroopLeaderEveningPhoneAreaCode" => @activity.leader_evening_phone_1,
      "TroopLeaderEveningPhoneLocalNumber" => @activity.leader_evening_phone_2.to_s + '' + @activity.leader_evening_phone_3.to_s,
      "TroopLeaderEmergencyContactName" => @activity.emergency_first_name + ' ' + @activity.emergency_last_name,
      "TroopLeaderMobilePhoneAreaCode" => @activity.leader_cell_phone_1,
      "TroopLeaderMobilePhoneLocalNumber" => @activity.leader_cell_phone_2.to_s + '' + @activity.leader_cell_phone_3.to_s,
      "TroopLeaderEmergencyContactDayPhoneAreaCode" => @activity.emergency_day_phone_1,
      "TroopLeaderEmergencyContactDayPhoneLocalNumber" => @activity.emergency_day_phone_2.to_s + '' + @activity.emergency_day_phone_3.to_s,
      "TroopLeaderEmergencyContactEveningPhoneAreaCode" => @activity.emergency_evening_phone_1,
      "TroopLeaderEmergencyContactEveningPhoneLocalNumber" => @activity.emergency_evening_phone_2.to_s + '' + @activity.emergency_evening_phone_3.to_s,
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
      "SignedPermissionFormDueDate" => @activity.activity_signed_permission_due_date,
      "TroopNumber" => @activity.troop_number,
      "PAL" => @activity.troop_pal
    })
   # raise @pdftk.fields(form_pdf_path).to_yaml
  end

  private

  def set_service_provider
    session[:user_service_provider] = 2
  end

  def girls_scouts_activities
    return @girls_scouts_activities if defined?(@girls_scouts_activities)
    @girls_scouts_activities = ["<Create New Activity>", 0], ["--------------------", :disabled => "disabled"]
  end

end
