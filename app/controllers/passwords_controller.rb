class PasswordsController < Devise::PasswordsController

  def new
    super
  end

  def create
    p params[:user][:email]
    if params[:user][:email]
      @user = User.where("email =?", params[:user][:email]).first
      if params[:user][:email].empty?
        flash[:error] = "Please Enter Email!"
        redirect_to :back
      else
        if @user
          flash[:success] = "Password reset instructions sent to #{params[:user][:email]}"
          super
        else
          flash[:error] = "#{params[:user][:email]} not found"
          redirect_to :back
        end
      end
    end
  end
end
