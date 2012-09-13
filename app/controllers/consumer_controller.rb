class ConsumerController < ApplicationController
  before_filter :set_service_provider

  def index
    @consumer_tab_index = session["consumer_tab_index"]
  end

  #Boy Scouts
  def boy_scouts_list
    session["consumer_tab_index"] = 0
    render :layout => false if request.xhr?
  end

  #Dental
  def dental_list
    session["consumer_tab_index"] = 1
    render :layout => false if request.xhr?
  end

  # Elementary School
  def elementary_school_list
    session["consumer_tab_index"] = 2
    render :layout => false if request.xhr?
  end

  # Florist
  def florist_list
    session["consumer_tab_index"] = 3
    render :layout => false if request.xhr?
  end

  #Girl Scouts
  def girl_scouts_list
    session["consumer_tab_index"] = 4
    render :layout => false if request.xhr?
  end

  #Medical
  def medical_list
    session["consumer_tab_index"] = 5
    render :layout => false if request.xhr?
  end

  #Pre School
  def pre_school_list
    session["consumer_tab_index"] = 6

    render :layout => false if request.xhr?
  end

  private

  def set_service_provider
    session[:user_service_provider] = 0
  end
end
