class BoyScoutsTroopLeadersController < ApplicationController
  before_filter :set_service_provider,:reset_activity, :boy_scouts_activities, :checking_user_status

  def index
  #  raise params.to_yaml
    @boy_activity = current_user.boy_scouts_activities.where("activity_date_begin >= ? and service_provider_id=?", Date.today, session[:user_service_provider]).order('activity_date_begin ').first
    id = @boy_activity.id rescue nil
    id = session[:selected_activity_id] if session[:selected_activity_id].present?
    session[:selected_activity_id] = id

    #checking default message
    display_message = current_user.display_messages.where("message_type = 'welcome_msg_boy_scouts_troop_leaders'").first

    unless display_message && display_message.status
      @display_message = DisplayMessage.new
    else
      redirect_to permission_forms_boy_scouts_troop_leaders_path(:id => id)
    end
  end

  def change_welcome_message_status
    @display_message = DisplayMessage.new
    @display_message.user_id = current_user.id
    @display_message.message_type = 'welcome_msg_boy_scouts_troop_leaders'
    @display_message.status = true
    @display_message.save
    redirect_to boy_scouts_troop_leaders_path
  end

  # boys scout roster
  def roster
    @boy_scouts = current_user.boy_scouts_rosters.where("service_provider_id=?", session[:user_service_provider]).order("first_name ASC")
  end

  def boy_scouts_roster
    @row_index = params[:row_index]
    @boy_scout = BoyScoutsRoster.find_or_initialize_by_id(params[:id])
    @boy_scout.user_id = current_user.id
    @boy_scout.first_name = params[:first_name]
    @boy_scout.last_name = params[:last_name]
    @boy_scout.middle_name = params[:middle_name]
    @boy_scout.parent_first_name = params[:parent_first_name]
    @boy_scout.parent_last_name = params[:parent_last_name]
    @boy_scout.email = params[:email]
    @boy_scout.service_provider_id = session[:user_service_provider]
    @boy_scout.save if @boy_scout.first_name.present? || @boy_scout.last_name.present? || @boy_scout.middle_name.present?|| @boy_scout.parent_first_name.present? || @boy_scout.parent_last_name.present? || @boy_scout.email.present?
  end

  def get_boy_scouts_row
    @row_index = params[:row_count].to_i
    @boy_scout = BoyScoutsRoster.new
  end

  def delete_boy_scouts
    @ids = params[:checked_vals]
    BoyScoutsRoster.delete(@ids.split(','))
  end

  # boys scout activities

  def activities
    @boy_activity = BoyScoutsActivity.new()
    if params[:id] == 'new'
      session[:selected_activity_id] = params[:id]
      @recent_activity = current_user.boy_scouts_activities.where("service_provider_id=?", session[:user_service_provider]).order('updated_at').last
      if @recent_activity
        @boy_activity = @recent_activity.dup
        @boy_activity[:activity_name] = ''
        @boy_activity[:activity_date_begin] = ''
        @boy_activity[:activity_date_end] = ''
        @boy_activity[:activity_signed_permission_due_date] = ''
      end
    elsif params[:id].present?
      session[:selected_activity_id] = params[:id]
      @boy_activity = BoyScoutsActivity.find_by_id_and_service_provider_id(params[:id], session[:user_service_provider])
    elsif session[:selected_activity_id].present? && session[:selected_activity_id] != 'new'
      @boy_activity = BoyScoutsActivity.find_by_id_and_service_provider_id(session[:selected_activity_id], session[:user_service_provider])
      @boy_activity = BoyScoutsActivity.new if @boy_activity.nil?
    else

    end

    @activities = current_user.boy_scouts_activities.where("service_provider_id=?", session[:user_service_provider]).order("created_at DESC")
    @activities.each do |activity|
      @boy_scouts_activities << [activity.activity_name.present? ? activity.activity_name : "Activity #" + activity.id.to_s, activity.id.to_s]
    end
  end

  def create_activity
    @activity = BoyScoutsActivity.find_or_initialize_by_id(params[:boy_scouts_activity][:id])

    @is_new_activity = @activity.new_record?

    @activity.user_id = current_user.id
    @activity.attributes = params[:boy_scouts_activity]
    @activity.service_provider_id = session[:user_service_provider]

    @is_activity_name_changed = @activity.activity_name_changed?

    @activity.save(:validate => false)
    session[:selected_activity_id] = @activity.id
  end

  def send_notification_email
    @activity = current_user.boy_scouts_activities.find_by_id_and_service_provider_id(params[:id], session[:user_service_provider])
    if @activity.invalid?
      flash[:error] = "Something wrong please try again."
    else
      @counter = 0
      @boys_scouts = current_user.boy_scouts_rosters.where('service_provider_id=?', session[:user_service_provider])
      @boys_scouts.each do |boy_scout|
        email = boy_scout.email
        if email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
          @user = User.find_by_email(email)
          pf = BoyScoutsActivityConsentForm.find_or_initialize_by_boy_scouts_roster_id_and_boy_scout_activity_id(boy_scout.id, @activity.id)
          pf.user_id = @user.id if @user
          pf.boy_scouts_roster_id = boy_scout.id
          pf.boy_scout_activity_id = @activity.id
          pf.status = "Pending"
          pf.attending = "?"
          pf.save(:validate => false)
          Notifier.send_boy_scout_parent_email_notification(@activity, boy_scout,session[:user_service_provider]).deliver
          @counter += 1
        end
      end
      flash[:notice] = "Messages Successfully Sent For #{@activity.activity_name}"
    end
  end

  def delete_activity
    BoyScoutsActivity.delete(params[:id])
    permissionforms = BoyScoutsActivityConsentForm.where('boy_scout_activity_id = ?', params[:id])
    permissionforms.each do |pf|
      BoyScoutsActivityConsentForm.delete(pf.id)
    end
    session[:selected_activity_id] = ''
  end

  def show_activity
    @activity = current_user.boy_scouts_activities.find_by_id_and_service_provider_id(params[:activity_id], session[:user_service_provider])
  end

  def activity_permission_form
    if params[:activity_id] == 'new'
       form_path = "#{BOY_SCOUTS_ACTIVITY_CONSENT_FORM}"
      send_file form_path,
                :filename => "Boy Scouts Activity Consent From.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    elsif params[:activity_id].present?
      @activity = current_user.boy_scouts_activities.find_by_id_and_service_provider_id(params[:activity_id], session[:user_service_provider])
      activity_name = @activity.activity_name.gsub(' ', '-') + "-sp_id-#{session[:user_service_provider]}"
      activity_name = "Activity-#{@activity.id}" + "-sp_id-#{session[:user_service_provider]}" if !activity_name.present?
      permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
     BoyScoutsActivity.activity_activity_consent_form_pdf_generater(@activity, permission_form_path)
      send_file permission_form_path,
                :filename => "#{activity_name}.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    else
    end
  end

  # boy Scout Activity Consent Forms

  def permission_forms
    if params[:id].present?
      activity_id = params[:id]
      @activity = BoyScoutsActivity.find_by_id(params[:id])
      session[:selected_activity_id] = params[:id]
    else
      activity_id = session[:selected_activity_id]
      @activity = BoyScoutsActivity.find_by_id(session[:selected_activity_id])
    end
    @boy_scout_permission_forms = BoyScoutsActivityConsentForm.joins(:boy_scouts_roster).where("boy_scout_activity_id = ? and service_provider_id=?", activity_id, session[:user_service_provider]).order("boy_scouts_rosters.first_name")
    @results = []
    @yes_counter = 0
    @no_counter = 0
    @other_counter = 0
    @boy_scout_permission_forms.each do |pf|
      item = {}
     boy_scout_first_name = pf.boy_scouts_roster.first_name.present? ? pf.boy_scouts_roster.first_name : ""
      boy_scout_last_name = pf.boy_scouts_roster.last_name.present? ? pf.boy_scouts_roster.last_name : ""
      item[:boy_scout] = boy_scout_first_name + ' ' + boy_scout_last_name
      item[:id] = pf.id
      item[:boy_scout_attending] = pf.attending.nil? ? '?' : pf.attending
      item[:status] = pf.status
      item[:updated_at] = pf.updated_at.strftime('%m/%d/%y')
      item[:boy_scout_id] = pf.boy_scouts_roster_id
      @results << item
    end
    @activities = current_user.boy_scouts_activities.where("service_provider_id=?", session[:user_service_provider]).order("created_at DESC")
    @activities.each do |activity|
      @boy_scouts_activities << [activity.activity_name.present? ? activity.activity_name : "Activity #" + activity.id.to_s, activity.id.to_s]
    end
  end

  def resend_permission_form
    @counter = 0
    @boy_scouts_activity_permission_forms = BoyScoutsActivityConsentForm.where('boy_scout_activity_id=? and status in (?) and attending in (?)', params[:activity_id], ['Pending', 'In Progress'], ['Yes', '?'])
    @boy_scouts_activity_permission_forms.each do |pf|
      @boy_scout = current_user.boy_scouts_rosters.find_by_id_and_service_provider_id(pf.boy_scouts_roster_id, session[:user_service_provider])
      @activity = current_user.boy_scouts_activities.find_by_id_and_service_provider_id(pf.boy_scout_activity_id, session[:user_service_provider])
      Notifier.send_boy_scout_parent_email_notification(@activity, @boy_scout,session[:user_service_provider]).deliver
      @counter += 1
    end
  end

  def pdf_merging
    @files = []
    ids = params[:checked_vals].split(',')
    @activity = current_user.boy_scouts_activities.find_by_id_and_service_provider_id(params[:activity_id], session[:user_service_provider])
    activity_name = @activity.activity_name.gsub(' ', '-')

    ids.each do |id|
      @boy_scouts_permission_form = BoyScoutsActivityConsentForm.where('id=? and status in (?)', id, ['Submitted', 'Sent', 'Updated']).first
      if @boy_scouts_permission_form
        @boy_scout = @boy_scouts_permission_form.boy_scouts_roster
        permission_form_name = activity_name + '-activity-consent-form-of-id-' + @boy_scout.id.to_s + "-sp_id-#{session[:user_service_provider]}" rescue ''
        permission_form_path = "#{PDFFILES_PATH}#{permission_form_name}.pdf"
          BoyScoutsActivityConsentForm.activity_parent_diamonds_permission_form_pdf_generater(@activity, @boy_scouts_permission_form, permission_form_path)
        @files << Rails.root.join("#{PDFFILES_PATH}#{permission_form_name}.pdf")
      end
    end
    if !@files.empty?
      pdf = Pdftk.combine @files
      combined_file = File.new("#{PDFFILES_PATH}#{activity_name}_activity_consent_forms.pdf", 'w+b')
      combined_file.puts pdf.read
      combined_file.close
    end
  end

  def show_all_permission_forms_pdf
    @activity = BoyScoutsActivity.find(params[:activity_id])
    activity_name = @activity.activity_name.gsub(' ', '-')

    pdf_form_path = Rails.root.join("#{PDFFILES_PATH}#{activity_name}_activity_consent_forms.pdf")
    send_file pdf_form_path,
              :filename => "#{activity_name}-activity-consent-forms-of-sp_id-#{session[:user_service_provider]}.pdf",
              :disposition => "inline",
              :type => "application/pdf"
  end




  private

  def set_service_provider
    session[:user_service_provider] = 6 if params[:sp_id] == '6'
  end

  def boy_scouts_activities
    return @boy_scouts_activities if defined?(@boy_scouts_activities)
    @boy_scouts_activities = []
  end

  def reset_activity
    if session[:user_service_provider] != params[:sp_id]
      session[:selected_activity_id] = ''
    end
  end

  def checking_user_status
    status = current_user.service_providers.where('user_service_providers.status=? and user_service_providers.service_provider_id in (?)',true, [session[:user_service_provider],params[:sp_id]]).first
    if status
    else
      flash[:error] = "You do not have permissions to access"
      redirect_to consumer_index_path
    end
  end

end
