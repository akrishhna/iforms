class ConsumerController < ApplicationController
before_filter :set_service_provider

  def index

  end

  private

  def set_service_provider
    @current_service_provider = 0
  end
end
