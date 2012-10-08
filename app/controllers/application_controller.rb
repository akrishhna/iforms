class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery
  helper :all
  helper_method :is_admin?
  helper_method :current_user_name
  helper_method :user_service_provider_list, :set_service_provider,:homepage_url
  #helper_method :patient_profile_exists

  #http://ramblinglabs.com/blog/2012/01/rails-3-1-adding-custom-404-and-500-error-pages
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  def current_user_name
    if current_user.role == 'doctor'
      (current_user.doctors.first.firstname + ' ' + current_user.doctors.first.lastname) rescue 'Doctor'
    elsif current_user.role == 'patient'
      (current_user.patients.first.firstname + ' ' + current_user.patients.first.lastname) rescue 'User'
    end
  end

  protected
  def is_doctor?
    unless current_user.role=="doctor"
      flash[:notice]="unauthorized access"
      redirect_to :controller => "deviseroles", :action => "index"
      false
    end
  end

  protected
  def is_patient?
    unless current_user.role=="patient"
      flash[:notice]="unauthorized access"
      redirect_to :controller => "deviseroles", :action => "index"
      false
    end
  end

  protected
  def is_admin?
    unless current_user.role=="admin"
      flash[:notice]="unauthorized access"
      redirect_to :controller => "deviseroles", :action => "index"
      false
    end
  end

  protected
  def patient_profile_exists?
    @patient = Patient.all(:conditions => ['user_id = ?', current_user.id]).first
    if @patient.blank?
      redirect_to :controller => "patients", :action => "new"
      false
    end
  end

  protected
  def doctor_profile_exists?
    @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
    if @doctor.blank?
      redirect_to :controller => "doctors", :action => "new"
      false
    end
  end

  def after_sign_in_path_for(resource)
    # return deviseroles_path
    stored_location_for(resource) || deviseroles_path
  end

  def user_service_provider_list
    return @user_service_providers if defined?(@user_service_providers)
    @user_service_providers = current_user.service_providers.collect{|sp| [sp.title , sp.id]}
    @user_service_providers[@user_service_providers.size] = ["Consumer", 0]
    @user_service_providers
  end

  def set_service_provider
    return @user_service_provider if defined?(@user_service_provider)
    @user_service_provider = session[:user_service_provider]
  end

  def homepage_url
    return @homepage_url if defined?(@homepage_url)
    if session[:user_service_provider] == 1
      @homepage_url = '/doctor/appointments'
    elsif session[:user_service_provider] == 2
      @homepage_url = '/girl_scouts_troop_leaders'
    elsif session[:user_service_provider] == 0
      @homepage_url = '/consumer'
    else
      @homepage_url = root_url
    end
  end

  private

  #404 errors
  def render_404(error)
    @error = error
    @not_found_path = error.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  #500 errors
  def render_500(error)
    @error = error
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
end
