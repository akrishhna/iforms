class Admin::UsersController < AdminController

  def index
    @users = User.order('username ASC').all
    @users = User.where('username=? or email=?', params[:user_search_filter], params[:user_search_filter]) if params[:user_search_filter].present?

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
    @user = User.find(params[:id])
    user_exist = User.where('username=? or email=?', params[:user][:username], params[:user][:email]).first
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
    @user_services = UserServiceProvider.joins(:service_provider).where('user_id=?', @user.id)
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

  def add_service
    user_exist = UserServiceProvider.find_by_user_id_and_service_provider_id(params[:user_id], params[:service])
    if user_exist
      flash[:notice] = 'User already having this service please upgrade.'
    else
      user_service_provider = UserServiceProvider.new
      user_service_provider.user_id = params[:user_id]
      user_service_provider.service_provider_id = params[:service]
      user_service_provider.expiry_date = params[:new_service_expiry_date]
      user_service_provider.save
      flash[:notice] = 'Added service.'
    end
    redirect_to :back
  end

  def extend_service
    @user_service_provider = UserServiceProvider.find(params[:service_id])
    render :layout => false if request.xhr?
  end

  def extend_user_service
    user_service_provider = UserServiceProvider.find(params[:service_id])
    user_service_provider.expiry_date = params[:expiry_date]
    user_service_provider.save
    redirect_to :back
  end


end
