class AdminController < ApplicationController

  before_filter :authenticate_admin

  def index

  end

  def admin_users

  end

  private

  def authenticate_admin
    admin_user = current_user.admin_user
    unless admin_user
      flash[:error] = "You don't have permissions to access this page !"
      redirect_to root_url
    end
  end
end
