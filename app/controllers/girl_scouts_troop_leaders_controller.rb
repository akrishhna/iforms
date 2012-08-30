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
    @girls_activity = GirlScoutsActivity.new
  end


  private

  def set_service_provider
    @current_service_provider = 2
  end

  def girls_scouts_activities
    return @girls_scouts_activities if defined?(@girls_scouts_activities)
    @girls_scouts_activities = ["<Create New Activity>",0],["--------------------",:disabled => "disabled"]
  end

end
