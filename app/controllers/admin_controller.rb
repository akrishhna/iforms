class AdminController < ApplicationController
  before_filter :is_admin?

  def index
  end

  private

  def is_admin?
    user_role = current_user.roles.find_by_role('admin')
    unless user_role && user_role.role == "admin"
      flash[:notice]="unauthorized access"
      redirect_to root_path
    end
  end
end
