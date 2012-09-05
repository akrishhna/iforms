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
    @girls_activity = GirlScoutsActivity.new if !params[:id].present?
    @girls_activity = GirlScoutsActivity.find(params[:id]) if params[:id].present?
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
          Notifier.send_parent_email_notification(@activity, girl_scout).deliver
          @counter += 1
        end
      end
      flash[:notice] = "Mails Send Successfully"
    end
  end

  def delete_activity
    GirlScoutsActivity.delete(params[:id])
  end

  def show_activity
    @activity = GirlScoutsActivity.find(params[:activity_id])
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
