class GirlScoutsTroopLeadersController < ApplicationController

  before_filter :set_service_provider

  def index


  end

  def roster
    @girls_scouts = current_user.girls_scouts
  end

  def girl_scouts_roster
    @row_index = params[:row_index]
    @girls_scout = GirlsScout.find_or_initialize_by_id(params[:id])
    @girls_scout.user_id = current_user.id
    @girls_scout.name = params[:name]
    @girls_scout.parent_name = params[:parent_name]
    @girls_scout.email = params[:email]
    @girls_scout.save if @girls_scout.name.present? || @girls_scout.parent_name.present? || @girls_scout.email.present?
  end

  def get_girl_scouts_row
    @row_index = params[:row_count].to_i
    @girls_scout = GirlsScout.new
  end

  def delete_girl_scouts
      @ids = params[:checked_vals]
     #  raise @ids.to_yaml
      GirlsScout.delete(@ids.split(','))
  end

  private

  def set_service_provider
    @current_service_provider = 2
  end
end
