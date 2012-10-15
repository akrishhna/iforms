class ConfirmationsController < Devise::ConfirmationsController
  def new
  end
  
  def create
    p params[:user][:email]
    if params[:user][:email]
      @user = User.where("email =?", params[:user][:email]).first
      if params[:user][:email].empty?
        flash[:error] = "Please enter Email"
        redirect_to :back
      else
       # p @user.confirmation_token
        if @user
          if @user.confirmation_token == nil and @user.edit_confirmed == "edited"
            p "inside if"
            flash[:success] = "Account conformation instructions sent to #{params[:user][:email]}"
            Notifier.confirmation_instructions_notification(@user).deliver
            redirect_to root_url
          else
            flash[:notice] = "#{params[:user][:email]} was already confirmed"
            redirect_to root_url
            # super
          end
        else
          flash[:error] = "#{params[:user][:email]} not found"
          redirect_to :back
        end
      end
    end
  end

end
