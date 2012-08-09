class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :patient_profile_exists? #TODO need to remove
  helper :all
  helper_method :is_patient? #TODO need to remove

  def after_sign_in_path_for(resource)
    user_roles_home_path
  end

  #old code
 
 protected

  #TODO need to remove
  def is_patient?
    user_role = current_user.roles.find_by_role('patient')
    unless user_role && user_role.role == "patient"
      flash[:notice]="unauthorized access"
      redirect_to root_path
    end
  end

  #TODO need to remove
  def patient_profile_exists?
    patient_role = current_user.user_roles if current_user
    if current_user && patient_role.size == 0
      UserRole.create({:user_id => current_user.id, :role_id => 3})
      patient = Patient.new({:user_id => current_user.id})
      patient.save(:validate => false)

      flash[:info] = "You need update your profile."
      redirect_to edit_patient_profile_path
    end

=begin
patient = Patient.all(:conditions => ['user_id = ?', current_user.id]).first
    if @patient.blank?
      flash[:info] = "You need update your profile."
      redirect_to new_patient_profile_path
    end
=end
  end

end
