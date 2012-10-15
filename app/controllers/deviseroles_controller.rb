class DeviserolesController < ApplicationController
  before_filter :authenticate_user!, :only => ["index"]

  def index
    @service_provider = current_user.service_providers.first
    if @service_provider.nil?
      @profile = Profile.find_by_user_id( current_user.id)
      if @profile.nil?
        redirect_to :controller => "profiles", :action => "new"
      else
        redirect_to :controller => "consumer", :action => "index"
      end

    elsif @service_provider.id == 2
      @profile = Profile.find_by_user_id(current_user.id)
      if @profile.nil?
        redirect_to :controller => "profiles", :action => "new"
      else
        redirect_to permission_forms_girl_scouts_troop_leaders_path
      end
    elsif @service_provider.id == 1
      @doctor = Doctor.find_by_user_id( current_user.id)
      if @doctor.nil?
       redirect_to :controller => "doctors", :action => "new"
      else
       redirect_to :controller => "doctors", :action => "index"
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

    if !@name.empty? and !@email.empty? and !@message.empty? and ayah_passed
      Notifier.contactus_form_notification(@name, @email, @subject, @message).deliver
      redirect_to(homepage_url, :notice => "Thanks for contacting")
    else
      if ayah_passed
        flash[:notice] = 'Please fill up all * mark fields'
      else
        flash[:notice] = 'Please fill up all * mark fields and complete the game'
      end
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
end
