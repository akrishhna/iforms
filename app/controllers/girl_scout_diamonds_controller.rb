class GirlScoutDiamondsController < ApplicationController
  before_filter :set_service_provider, :girl_scout_diamonds_activities

  def index

  end

  # girls scout activities

  def activities
    @girls_activity = GirlScoutDiamondActivity.new()
    if params[:id] == 'new'
      session[:selected_activity_id] = params[:id]
      @recent_activity = current_user.girl_scout_diamond_activities.order('updated_at').last
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
        @girls_activity[:activity_mode_of_transportation] = ''
        @girls_activity[:activity_equipment] = ''
      end
    elsif params[:id].present?
      session[:selected_activity_id] = params[:id]
      @girls_activity = current_user.girl_scout_diamond_activities.find(params[:id])
    elsif session[:selected_activity_id].present? && session[:selected_activity_id] != 'new'
      @girls_activity = current_user.girl_scout_diamond_activities.find(session[:selected_activity_id])
    else
    end

    @activities = current_user.girl_scout_diamond_activities.order("created_at DESC")
    @activities.each do |activity|
      @girl_scout_diamonds_activities << [activity.activity_name.present? ? activity.activity_name : "Activity #" + activity.id.to_s, activity.id.to_s]
    end

  end

  def create_activity
    @activity = GirlScoutDiamondActivity.find_or_initialize_by_id(params[:girl_scout_diamond_activity][:id])
    @activity.user_id = current_user.id
    @activity.attributes = params[:girl_scout_diamond_activity]
    @activity.save(:validate => false)
    session[:selected_activity_id] = @activity.id
  end

  def delete_activity
    GirlScoutDiamondActivity.delete(params[:id])
    #permissionforms = GirlScoutsActivityPermissionForm.where('girl_scouts_activity_id = ?', params[:id])
   # permissionforms.each do |pf|
  #    GirlScoutsActivityPermissionForm.delete(pf.id)
  #  end
    session[:selected_activity_id] = ''
  end

  def send_notification_email
    @activity = GirlScoutDiamondActivity.find(params[:id])
    if @activity.invalid?
      flash[:error] = "Something wrong please try again."
    else
      #sending mail to all parents
      #@counter = 0
      #@girls_scouts = current_user.girls_scouts
      #@girls_scouts.each do |girl_scout|
      #  email = girl_scout.email
      #  if email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
      #    @user = User.find_by_email(email)
      #    pf = GirlScoutsActivityPermissionForm.find_or_initialize_by_girls_scout_id_and_girl_scouts_activity_id(girl_scout.id, @activity.id)
      #    pf.user_id = @user.id if @user
      #    pf.girls_scout_id = girl_scout.id
      #    pf.girl_scouts_activity_id = @activity.id
      #    pf.status = "Pending"
      #    pf.girl_scout_attending = "?"
      #    pf.save
      #    Notifier.send_parent_email_notification(@activity, girl_scout).deliver
      #    @counter += 1
      #  end
      #end
      #flash[:notice] = "Messages Successfully Sent For #{@activity.activity_name}"
    end
  end

  def activity_permission_form
    if params[:activity_id] == 'new'
      send_file "#{PDFFILES_PATH}Parent_Permission_Diamonds.pdf",
                :filename => "Parent_Permission_Diamonds.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    elsif params[:activity_id].present?
      @activity = current_user.girl_scout_diamond_activities.find(params[:activity_id])
      activity_name = @activity.activity_name.gsub(' ', '-')
      activity_name = "Activity-#{@activity.id}" if !activity_name.present?
      permission_form_path = "#{PDFFILES_PATH}#{activity_name}.pdf"
      #GirlScoutsActivity.activity_permission_form_pdf_generater(@activity, permission_form_path)
      send_file permission_form_path,
                :filename => "#{activity_name}.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    else
    end
  end










  private

  def set_service_provider
    session[:user_service_provider] = 3
  end

  private

  def girl_scout_diamonds_activities
    return @girl_scout_diamonds_activities if defined?(@girl_scout_diamonds_activities)
    @girl_scout_diamonds_activities = []
  end
end
