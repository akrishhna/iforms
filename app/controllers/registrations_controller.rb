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
        Sessionstore.delete_all
        p session[:useremail_before_update]= @user.email
          @user.confirmed_at = nil
          #@user.confirmation_sent_at =nil
          @user.email = params[:user][:email]
          if !params[:user][:password].empty?
          @user.password = params[:user][:password]
          end
          if !params[:user][:password_confirmation].empty?
          @user.password_confirmation = params[:user][:password_confirmation]
          end
          if @user.save
          p session[:useremail_after_update]= @user.email
          Notifier.confirmation_instructions_notification(@user).deliver
          Sessionstore.create(:useremail_beforeupdate => session[:useremail_before_update], :useremail_afterupdate => session[:useremail_after_update] )
          redirect_to root_path
          else
            flash[:alert] = "Email is already taken"
            redirect_to edit_user_registration_path
          end
      else
        super
      end
    end

end
