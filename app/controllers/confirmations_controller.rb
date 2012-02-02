class ConfirmationsController < Devise::ConfirmationsController
  def new
  end
  
  def create
    p params[:user][:email]
    if params[:user][:email]
      @user = User.where("email =?", params[:user][:email]).first
      p @user.confirmation_token
      if @user.confirmation_token == nil and @user.edit_confirmed == "edited"
        p "inside if"
        Notifier.confirmation_instructions_notification(@user).deliver
       redirect_to root_url 
      else
        super
      end 
    end
  end

end
