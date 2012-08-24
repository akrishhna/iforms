class GirlScoutsTroopLeadersController < ApplicationController

  before_filter :set_service_provider

  def index

  end

  def roster

  end

  private

  def set_service_provider
    @current_service_provider = 2
  end
end
