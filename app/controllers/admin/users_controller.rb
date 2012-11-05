class Admin::UsersController < AdminController

  def index
    @users = User.all
    @users = User.where('username=? or email=?',params[:user_search_filter],params[:user_search_filter]) if params[:user_search_filter].present?

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User successfully created."
      redirect_to :back
    else
     # flash[:error] = "Something wrong please try again"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user =  User.find(params[:id])
     user_exist = User.where('username=? or email=?',params[:user][:username],params[:user][:email]).first
    if user_exist
      flash[:notice] = "User is already exist with following details"
      redirect_to :back
    elsif @user.update_attributes(params[:user])
      redirect_to :back, :notice => 'User details successfully updated.'
    else
      render :edit, :notice => 'Something wrong please try again'
    end
  end

  def show
    @user = User.find(params[:id])
    @user_services = UserServiceProvider.joins(:service_provider).where('user_id=?',@user.id)
  end

  def delete_user
    User.delete(params[:user_id])
    flash[:success] = "User deleted."
    redirect_to :back
  end

  def change_service_provider_status
    @user_service = UserServiceProvider.find(params[:usp_id])
    @user_service.status = !@user_service.status
    @user_service.save

    flash[:notice] = "Changed Service Status."
    redirect_to :back
  end
end
