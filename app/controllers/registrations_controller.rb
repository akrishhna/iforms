class RegistrationsController < Devise::RegistrationsController

    def create
      if verify_recaptcha
        super
      else
        build_resource
        clean_up_passwords(resource)
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
        render_with_scope :new
      end
    end
    
    def update

      if params[:user][:email] != @user.email
        p session[:user_email_before_update]= @user.email
          @user.confirmed_at = nil
          #@user.confirmation_sent_at =nil
          @user.email = params[:user][:email]
          if params[:user][:password]
          @user.password = params[:user][:password]
          end
          if params[:user][:password_confirmation]
          @user.password_confirmation = params[:user][:password_confirmation]
          end
          @user.save
          p session[:user_email_after_update]= @user.email
          Notifier.confirmation_instructions_notification(@user).deliver
          redirect_to root_path
      else
        super
      end

    end

end
