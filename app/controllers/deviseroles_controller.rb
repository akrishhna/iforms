class DeviserolesController < ApplicationController
  before_filter :authenticate_user!, :only => ["index"]

  def index
    year =  Date.today.year.to_s
    month = Date.today.month.to_s
    month = '0' + month if month.to_i < 10
    day = Date.today.day.to_s
    day = '0' + day if day.to_i < 10
    appointment_date = year + '-' + month + '-' + day

    @service_provider = current_user.service_providers.where('user_service_providers.status=?', true).first

    if @service_provider.nil?
      @profile = Profile.find_by_user_id(current_user.id)
      if @profile.nil?
        redirect_to :controller => "profiles", :action => "new"
      else
        redirect_to :controller => "consumer", :action => "index"
      end

    elsif @service_provider.id == 1 || @service_provider.id == 4 || @service_provider.id == 5 || @service_provider.id == 7
      @doctor = Doctor.find_by_user_id(current_user.id)
      if @doctor.nil?
        redirect_to "/doctors/new?sp_id=#{@service_provider.id}"
      else
        redirect_to "/doctor/appointments?sp_id=#{@service_provider.id}" + "&appointment_date=#{appointment_date}"
      end

    elsif @service_provider.id == 2 || @service_provider.id == 3 || @service_provider.id == 8 || @service_provider.id == 9 || @service_provider.id == 10 || @service_provider.id == 1 || @service_provider.id == 12
      @troop_leader = GirlScoutTroopLeaderProfile.find_by_user_id(current_user.id)
      if @troop_leader.nil?
        redirect_to :controller => "girl_scout_troop_leader_profiles", :action => "new"
      else
        redirect_to "/girl_scouts_troop_leaders?sp_id=#{@service_provider.id}"
      end
    elsif @service_provider.id == 6
      @troop_leader = GirlScoutTroopLeaderProfile.find_by_user_id(current_user.id)
      if @troop_leader.nil?
        redirect_to :controller => "girl_scout_troop_leader_profiles", :action => "new"
      else
        redirect_to "/boy_scouts_troop_leaders?sp_id=#{@service_provider.id}"
      end
    else
    end

    #case current_user.role
    #  when 'patient'
    #    @profile = Profile.all(:conditions => ['user_id = ?', current_user.id]).first
    #    if @profile.blank?
    #      redirect_to :controller => "profile", :action => "new"
    #    else
    #      redirect_to :controller => "consumer", :action => "index"
    #    end
    #
    #  when 'doctor'
    #    @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
    #    if @doctor.blank?
    #      redirect_to :controller => "doctors", :action => "new"
    #    else
    #      redirect_to :controller => "doctors", :action => "index"
    #    end
    #
    #  when 'admin'
    #    redirect_to :controller => "admin", :action => "index"
    #  else
    #    render :text => "some error"
    #end
  end


  def new

  end

  def contact
    @ayah = AYAH::Integration.new("c4767d34bc724283166728cdf6e6da245f7b16fd", "d4309f6c8672a358b1267060be9fd75f39731fef")
  end

  def contacts
    @name = params[:name]
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]
    @ayah = AYAH::Integration.new(PUBLISHER_KEY, SCORING_KEY)
    ayah_passed = @ayah.score_result(params[:session_secret], request.remote_ip)
    ayah_passed = true if current_user.present?
    if ayah_passed
      Notifier.contactus_form_notification(@name, @email, @subject, @message).deliver
      flash[:success] = 'Thanks for contacting'
      redirect_to homepage_url
    else
      flash[:error] = 'Please Play the game'
      redirect_to('/contact')
    end

    #respond_to do |format|
    #  if !@name.empty? and !@email.empty? and !@message.empty? and verify_recaptcha
    #    format.html { redirect_to(root_url, :notice => 'Message sent.') }
    #    Notifier.contactus_form_notification(@name, @email, @subject, @message).deliver
    #  else
    #    format.html { redirect_to('/contact', :alert => "Please enter valid re-captcha tag") }
    #  end
    #end
  end

  def user_details
    @sessionstore = Sessionstore.all.first
    p "user details"
    p @sessionstore.useremail_beforeupdate
    p @sessionstore.useremail_afterupdate
    if @sessionstore.useremail_afterupdate
      @user = User.where("email =?", @sessionstore.useremail_afterupdate).first
      @user.confirmed_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      @user.edit_confirmed = "confirmed"
      @user.save
    end
    @user = User.where("email =?", @sessionstore.useremail_afterupdate).first
    if @user.role == 'patient'
      if @sessionstore.useremail_beforeupdate
        p "updating appointments for patient"
        @appointments = Appointment.where("email = ?", @sessionstore.useremail_beforeupdate)
        @appointments.each do |i|
          i.email = @sessionstore.useremail_afterupdate
          i.save(:validate => false)
        end
        @girls_scouts = GirlsScout.where("email = ?", @sessionstore.useremail_beforeupdate)
        @girls_scouts.each do |girl_scout|
          girl_scout.email = @sessionstore.useremail_afterupdate
          girl_scout.save(:validate => false)
        end
      end
    end
    redirect_to deviseroles_path
  end

  def privacy_policy

  end

  def forgot_username

  end

  def sending_username
    user = User.find_by_email(params[:user][:email])
    #raise user.to_yaml
    if user
      Notifier.send_username_notification(user).deliver
      flash[:success] = "Username sent to #{user.email}"
      redirect_to root_path
    else
      if !params[:user][:email].empty?
        flash[:error] = "#{params[:user][:email]} not found"
        redirect_to :back
      else
        flash[:error] = "Please enter Email"
        redirect_to :back
      end
    end
  end

  def girl_scout_sign_up_page
    @user = User.new
    @user.build_girl_scout_troop_leader_profile
    @ayah = AYAH::Integration.new("c4767d34bc724283166728cdf6e6da245f7b16fd", "d4309f6c8672a358b1267060be9fd75f39731fef")
  end

  def girl_scout_sign_up
    username = params[:user][:username]
    email = params[:user][:email]
    password = params[:user][:girl_scout_troop_leader_profile_attributes][:password]
    password_confirmation = params[:user][:girl_scout_troop_leader_profile_attributes][:password]
    @ayah = AYAH::Integration.new(PUBLISHER_KEY, SCORING_KEY)
    #service_type = params[:user][:girl_scout_troop_leader_profile_attributes][:council_type] if params[:select_type] == 'girl_scouts'
    # ayah_passed = @ayah.score_result(params[:session_secret], request.remote_ip)
    if !username.empty? && !email.empty? && (password == password_confirmation) # && !service_type.empty? && ayah_passed
      @user = User.new(params[:user])
      if params[:select_type] == 'girl_scouts'
        service_provider_type = ServiceProvider.find(params[:user][:girl_scout_troop_leader_profile_attributes][:council_type])
      else
        service_provider_type = ServiceProvider.find(6)
        @user.girl_scout_troop_leader_profile.council_type = 6
      end
      if @user.save
        UserServiceProvider.create(:user_id => @user.id, :service_provider_id => service_provider_type.id)
        flash[:success] = "Confirmation message sent to #{params[:user][:email]}"
        redirect_to homepage_url
      else
        flash[:error] = 'Something Wrong Please Try again.'
        redirect_to :back
      end
    else
      #  flash[:error] = 'Please fill all the fields and Play the game.'
      flash[:error] = 'Something Wrong Please Try again.'
      redirect_to :back
    end
  end

  def validate_girl_scout_sign_up_page
    @user_username = User.find_by_username(params[:user][:username])
    @user_email = User.find_by_email(params[:user][:email])
    @mail_validate = params[:user][:email]
  end

end
