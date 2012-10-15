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

  def edit
    @service_provider = current_user.service_providers.first
    #@profile = current_user.profile.id if current_user.profile.id.present?
  end

  def update
    username = @user.username
    email = @user.email
    @service_provider = current_user.service_providers.first
    if params[:user][:email] != @user.email || params[:user][:username] != @user.username
      Sessionstore.delete_all
      p session[:useremail_before_update]= @user.email
      @user.confirmed_at = nil
      @user.edit_confirmed = "edited"
      #@user.confirmation_sent_at =nil
      @user.email = params[:user][:email]
      @user.username = params[:user][:username]
      if !params[:user][:password].empty?
        @user.password = params[:user][:password]
      end
      if !params[:user][:password_confirmation].empty?
        @user.password_confirmation = params[:user][:password_confirmation]
      end
      if @user.save
        p session[:useremail_after_update]= @user.email
        Notifier.confirmation_instructions_notification(@user).deliver
        Sessionstore.create(:useremail_beforeupdate => session[:useremail_before_update], :useremail_afterupdate => session[:useremail_after_update])
        redirect_to :controller => "consumer", :action => "index"
      else
        if username != params[:user][:username]
          flash[:error] = "Your desired Username #{params[:user][:username]} is not available."
        elsif email != params[:user][:email]
          flash[:error] = "Your desired email address #{params[:user][:email]} is not available."
        else
          flash[:error] = "Something is wrong try again."
        end
        redirect_to edit_user_registration_path
      end
    else
      super
    end
  end

end
