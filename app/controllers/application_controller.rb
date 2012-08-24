class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  helper :all
  helper_method :is_admin?
  helper_method :current_user_name
  helper_method :user_service_provider_list
  #helper_method :patient_profile_exists

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
    return deviseroles_path
  end

  def user_service_provider_list
    return @user_service_providers if defined?(@user_service_providers)
    @user_service_providers = current_user.service_providers.collect{|sp| [sp.title , sp.id]}
    @user_service_providers[@user_service_providers.size] = ["Consumer", 0]
    @user_service_providers
  end
end
