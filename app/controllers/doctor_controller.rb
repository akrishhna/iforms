class DoctorController < ApplicationController

  before_filter :authenticate_user!
  before_filter :is_doctor?

  helper_method :doctor



  private

  def doctor
    return @doctor if defined?(@doctor)
    @doctor = current_user.doctor
  end

  def is_doctor?
    user_role = current_user.roles.find_by_role('doctor')
    unless user_role && user_role.role == "doctor"
      flash[:notice]="unauthorized access"
      redirect_to root_path
    end
  end
end
