class RegistrationsController < Devise::RegistrationsController

  def new
    # super
    @ayah = AYAH::Integration.new("c4767d34bc724283166728cdf6e6da245f7b16fd", "d4309f6c8672a358b1267060be9fd75f39731fef")
  end

  def create
    username = params[:user][:username]
    email = params[:user][:email]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    @ayah = AYAH::Integration.new(PUBLISHER_KEY, SCORING_KEY)
    ayah_passed = @ayah.score_result(params[:session_secret], request.remote_ip)
    if !username.empty? && !email.empty? && ayah_passed && (password == password_confirmation)
      username_present = User.find_by_username(username)
      email_present = User.find_by_email(email)
      if username_present
        flash.now[:notice] = "Username #{username} is unavailable"
        render :new
      elsif email_present
        flash.now[:notice] = "Email #{email} is unavailable"
        render :new
      else
        if ayah_passed
          super
        else
          build_resource
          clean_up_passwords(resource)
          flash.now[:alert] = "There was an error, Please re-enter."
          render_with_scope :new
        end
      end
    else
      flash[:error] = 'Please fill all the fields and Play the game'
      redirect_to :back
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

  def validate_users_sign_up_page
    @user_username = User.find_by_username(params[:user][:username])
    @user_email = User.find_by_email(params[:user][:email])
    @mail_validate = params[:user][:email]
  end

end
