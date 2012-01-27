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
    
    # def update
    #         
    #     if params[:user][:email] != @user.email
    #       send_confirmation = true
    #     if send_confirmation
    #     @user.confirmed_at = nil
    #     @user.confirmation_sent_at =nil
    #     @user.email = params[:user][:email]
    #     @user.save
    #     @user.send_confirmation_instructions
    #     redirect_to root_path
    #     end
    #     else
    #       super
    #     end
    #     
    #     end
end
