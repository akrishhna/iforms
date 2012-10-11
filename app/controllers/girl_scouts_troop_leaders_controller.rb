class GirlScoutsTroopLeadersController < ApplicationController

  before_filter :set_service_provider, :girls_scouts_activities

  def index
    @girls_activity = current_user.girl_scouts_activities.where("activity_date_begin >= ?", Date.today).order('activity_date_begin ').first
    id = @girls_activity.id rescue nil
    id = session[:selected_activity_id] if session[:selected_activity_id].present?
    session[:selected_activity_id] = id

    #checking default message
    display_message = current_user.display_messages.where("message_type = 'welcome_msg_girl_scouts_troop_leaders'").first

    unless display_message && display_message.status
      @display_message = DisplayMessage.new
    else
      redirect_to permission_forms_girl_scouts_troop_leaders_path(:id => id)
    end
  end

  def change_welcome_message_status
    @display_message = DisplayMessage.new
    @display_message.user_id = current_user.id
    @display_message.message_type = 'welcome_msg_girl_scouts_troop_leaders'
    @display_message.status = true
    @display_message.save
    redirect_to girl_scouts_troop_leaders_path
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
    @girls_activity = GirlScoutsActivity.new()
    if params[:id] == 'new'
      session[:selected_activity_id] = params[:id]
      @recent_activity = current_user.girl_scouts_activities.order('updated_at').last
      if @recent_activity
        @girls_activity = @recent_activity.dup
        @girls_activity[:activity_name] = ''
        @girls_activity[:activity_location] = ''
        @girls_activity[:activity_date_begin] = ''
        @girls_activity[:activity_date_end] = ''
        @girls_activity[:activity_signed_permission_due_date] = ''
        @girls_activity[:activity_leave_from] = ''
        @girls_activity[:activity_leave_time_hh] = ''
        @girls_activity[:activity_leave_time_mm] = ''
        @girls_activity[:activity_leave_time_am_pm] = ''
        @girls_activity[:activity_return_to] = ''
        @girls_activity[:activity_return_time_hh] = ''
        @girls_activity[:activity_return_time_mm] = ''
        @girls_activity[:activity_return_time_am_pm] = ''
        @girls_activity[:activity_cost_dollars] = ''
        @girls_activity[:activity_cost_cents] = ''
        @girls_activity[:girls_wear_checkbox] = ''
        @girls_activity[:activity_girls_wear_others] = ''
        @girls_activity[:activity_girls_bring] = ''
        @girls_activity[:activity_equipment] = ''
      end
    elsif params[:id].present?
      session[:selected_activity_id] = params[:id]
      @girls_activity = GirlScoutsActivity.find(params[:id])
    elsif session[:selected_activity_id].present? && session[:selected_activity_id] != 'new'
      @girls_activity = GirlScoutsActivity.find(session[:selected_activity_id])
    else

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
    session[:selected_activity_id] = @activity.id
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
          pf = GirlScoutsActivityPermissionForm.find_or_initialize_by_girls_scout_id_and_girl_scouts_activity_id(girl_scout.id, @activity.id)
          pf.user_id = @user.id if @user
          pf.girls_scout_id = girl_scout.id
          pf.girl_scouts_activity_id = @activity.id
          pf.status = "Pending"
          pf.girl_scout_attending = "?"
          pf.save
          Notifier.send_parent_email_notification(@activity, girl_scout).deliver
          @counter += 1
        end
      end
      flash[:notice] = "Messages Successfully Sent For #{@activity.activity_name}"
    end
  end

  def delete_activity
    GirlScoutsActivity.delete(params[:id])
    permissionforms = GirlScoutsActivityPermissionForm.where('girl_scouts_activity_id = ?', params[:id])
    permissionforms.each do |pf|
      GirlScoutsActivityPermissionForm.delete(pf.id)
    end
    session[:selected_activity_id] = ''
  end

  def show_activity
    @activity = current_user.girl_scouts_activities.find(params[:activity_id])
    if !@activity.activity_cost_cents.nil?
      @cents = @activity.activity_cost_cents <= 9 ? ('0' + @activity.activity_cost_cents.to_s) : @activity.activity_cost_cents.to_s
    else
      @cents = '00'
    end
  end

  def activity_permission_form
    if params[:activity_id] == 'new'
      send_file "#{PDFFILES_PATH}Parent_Permission_iForms.pdf",
                :filename => "Parent_Permission_iForms.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    elsif params[:activity_id].present?
      @activity = current_user.girl_scouts_activities.find(params[:activity_id])
      activity_name = @activity.activity_name.gsub(' ', '-')
      activity_name = "Activity-#{@activity.id}" if !activity_name.present?
      permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
      GirlScoutsActivity.activity_permission_form_pdf_generater(@activity, permission_form_path)
      send_file permission_form_path,
                :filename => "#{activity_name}.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    else
    end
  end

  # Girl Scout Permission Forms

  def permission_forms

    if params[:id].present?
      #@girls_scout_permission_forms = GirlScoutsActivityPermissionForm.find_all_by_girl_scouts_activity_id(params[:id])
      activity_id = params[:id]
      @activity = GirlScoutsActivity.find_by_id(params[:id])
      session[:selected_activity_id] = params[:id]
    else
      #@girls_scout_permission_forms = GirlScoutsActivityPermissionForm.find_all_by_girl_scouts_activity_id(session[:selected_activity_id])
      activity_id = session[:selected_activity_id]
      @activity = GirlScoutsActivity.find_by_id(session[:selected_activity_id])
    end
    @girls_scout_permission_forms = GirlScoutsActivityPermissionForm.joins(:girls_scout).where("girl_scouts_activity_id = ?", activity_id).order("girls_scouts.first_name")
    @results = []
    @yes_counter = 0
    @no_counter = 0
    @other_counter = 0
    @girls_scout_permission_forms.each do |pf|
      item = {}
      girl_scout_first_name = pf.girls_scout.first_name.present? ? pf.girls_scout.first_name : ""
      girl_scout_last_name = pf.girls_scout.last_name.present? ? pf.girls_scout.last_name : ""
      item[:girl_scout] = girl_scout_first_name + ' ' + girl_scout_last_name
      item[:id] = pf.id
      item[:girl_scout_attending] = pf.girl_scout_attending.nil? ? '?' : pf.girl_scout_attending
      item[:status] = pf.status
      item[:updated_at] = pf.updated_at.strftime('%m/%d/%y')
      item[:girl_scout_id] = pf.girls_scout_id
      @results << item
    end
    @activities = current_user.girl_scouts_activities.order("created_at DESC")
    @activities.each do |activity|
      @girls_scouts_activities << [activity.activity_name.present? ? activity.activity_name : "Activity #" + activity.id.to_s, activity.id.to_s]
    end
  end

  def resend_permission_form
    @counter = 0
    #@girl_scouts_activity_permission_forms = GirlScoutsActivityPermissionForm.where('girl_scouts_activity_id = ? and status = ?', params[:activity_id], 'Pending')
    @girl_scouts_activity_permission_forms = GirlScoutsActivityPermissionForm.where('girl_scouts_activity_id=? and status in (?) and girl_scout_attending in (?)', params[:activity_id], ['Pending', 'In Progress'], ['Yes', '?'])
    @girl_scouts_activity_permission_forms.each do |pf|
      @girl_scout = GirlsScout.find_by_id(pf.girls_scout_id)
      @activity = GirlScoutsActivity.find_by_id(pf.girl_scouts_activity_id)
      Notifier.send_parent_email_notification(@activity, @girl_scout).deliver
      @counter += 1
    end
  end

  def pdf_merging
    @files = []
    ids = params[:checked_vals].split(',')
    @activity = GirlScoutsActivity.find(params[:activity_id])
    activity_name = @activity.activity_name.gsub(' ', '-')

    ids.each do |id|
      #@girl_scouts_permission_form = GirlScoutsActivityPermissionForm.find(id)
      @girl_scouts_permission_form = GirlScoutsActivityPermissionForm.where('id=? and status in (?)', id, ['Submitted', 'Sent', 'Updated']).first
      if @girl_scouts_permission_form
        @girl_scout = @girl_scouts_permission_form.girls_scout
        permission_form_name = activity_name + '-permission-form-of-id-' + @girl_scout.id.to_s rescue ''
        permission_form_path = "#{PDFFILES_PATH}#{permission_form_name}.pdf"
        GirlScoutsActivityPermissionForm.activity_parent_permission_form_pdf_generater(@activity, @girl_scouts_permission_form, permission_form_path)
        @files << Rails.root.join("#{PDFFILES_PATH}#{permission_form_name}.pdf")
      end
    end
    if !@files.empty?
      pdf = Pdftk.combine @files
      combined_file = File.new("#{PDFFILES_PATH}#{activity_name}_permission_forms.pdf", 'w+b')
      combined_file.puts pdf.read
      combined_file.close
    end
  end

  def show_all_permission_forms_pdf
    @activity = GirlScoutsActivity.find(params[:activity_id])
    activity_name = @activity.activity_name.gsub(' ', '-')

    pdf_form_path = Rails.root.join("#{PDFFILES_PATH}#{activity_name}_permission_forms.pdf")
    send_file pdf_form_path,
              :filename => "#{activity_name}_permission_forms.pdf",
              :disposition => "inline",
              :type => "application/pdf"
  end

  private

  def set_service_provider
    session[:user_service_provider] = 2
  end

  def girls_scouts_activities
    return @girls_scouts_activities if defined?(@girls_scouts_activities)
    @girls_scouts_activities = []
  end

end
