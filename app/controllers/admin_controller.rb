class AdminController < ApplicationController

  before_filter :authenticate_admin

  def index

  end

  def admin_users
    @admin_users = AdminUser.joins(:user).all
  end

  def add_admin_user
   user = User.find_by_email(params[:email])
    if user
      user.build_admin_user
      user.save
      flash[:success] = "#{params[:email]} is added as admin"
      redirect_to :back
    else
      flash[:notice] = "#{params[:email]} does not exist"
      redirect_to :back
    end

  end

  def change_admin_user_status
    @admin_user = AdminUser.find(params[:admin_user_id])
    @admin_user.status = !@admin_user.status
    @admin_user.save

    flash[:notice] = "Changed Admin User Status."
    redirect_to :back
  end

  def delete_admin_user
     AdminUser.delete(params[:admin_user_id])
     flash[:notice] = "Deleted Admin User."
     redirect_to :back
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
