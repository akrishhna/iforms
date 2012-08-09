class PatientController < ApplicationController

  before_filter :is_patient?

  helper_method :patient

  private

  def patient
    return @patient if defined?(@patient)
    @patient = current_user.patient
  end

  def is_patient?
    user_role = current_user.roles.find_by_role('patient')
    unless user_role && user_role.role == "patient"
      flash[:notice]="unauthorized access"
      redirect_to root_path
    end
  end
end
