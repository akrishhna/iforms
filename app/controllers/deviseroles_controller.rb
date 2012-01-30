class DeviserolesController < ApplicationController
  before_filter :authenticate_user!, :only => ["index"]

  def index
     case current_user.role
       when 'patient'
       @patient = Patient.all(:conditions => ['user_id = ?', current_user.id]).first
       if @patient.blank?
         redirect_to :controller=>"patients", :action=>"new"
       else
         redirect_to :controller=>"patients", :action=>"index"
       end
       
       when 'doctor'
       @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
       if @doctor.blank?
         redirect_to :controller=>"doctors", :action=>"new"
       else
         redirect_to :controller=>"doctors", :action=>"index"
       end 
       
       when 'admin'
       redirect_to :controller=>"admin", :action => "index"
     else
       render :text => "some error"
     end
  end
  

    def new
      
    end 
    def contacts
      @name = params[:name]
      @email = params[:email]
      @subject = params[:subject]
      @message = params[:body]
      respond_to do |format|
      if !@name.empty? and !@email.empty? and !@message.empty? and verify_recaptcha
        format.html { redirect_to(root_url, :notice => 'Message sent.') }
        Notifier.contactus_form_notification(@name, @email, @subject, @message).deliver 
      else
        format.html { redirect_to('/contact', :alert => "Please enter valid re-captcha tag") }
      end 
    end
    end 
    
    def user_details
      p "user details"
      if session[:user_email_after_update]
        user = User.where("email =?", session[:user_email_after_update]).first
        user.confirmed_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        user.save
      end
    if session[:user_email_before_update]
      p session[:user_email_before_update] 
      @appointments = Appointment.where("email = ?", session[:user_email_before_update])
      @appointments.each do |i|
        i.email = session[:user_email_after_update]
        i.save(:validate =>false)
      end
      redirect_to deviseroles_path
      end 
    end  
      
end
