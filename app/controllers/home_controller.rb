class HomeController < ApplicationController

  def index

  end

  def user_roles
    @user_roles =  current_user.roles.order('id')

    if @user_roles.size == 1
      user_role = @user_roles.first
      if user_role.role == 'patient'
        redirect_to patient_dashboard_path
        return
      elsif user_role.role == 'doctor'
        redirect_to doctor_dashboard_path
        return
      end
    end

  end
end
