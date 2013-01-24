class DoctorsController < ApplicationController
  before_filter :set_service_provider,:checking_user_status
  before_filter :doctor_profile_exists?, :except => [:new,:create]
  def index
    session["consumer_tab_index"] = 1
   # @iforms = Iform.all
    if session[:user_service_provider] == 1 || session[:user_service_provider] == 4 || session[:user_service_provider] == 7
      @doctor = Doctor.find_by_user_id(current_user.id)
   # @appointments = Appointment.where('doctor_user_id = ? and service_provider_id=? and date = ?', @doctor.user_id,session[:user_service_provider],params['appointment_date']?params['appointment_date']:Date.today.to_s).order("firstname ASC").paging(params[:page], params[:appointment_id]) if @doctor
      @appointments = Appointment.where("doctor_user_id = ? and service_provider_id = ? and DATE_FORMAT(appointment_date_time, '%Y-%m-%d') = ?", @doctor.user_id, session[:user_service_provider],params['appointment_date']?params['appointment_date']:Date.today.to_s).order("firstname ASC").paging(params[:page], params[:appointment_id]) if @doctor
    else
      redirect_to :medical_appointments
    end
    render :layout => false if request.xhr?
  end

  def new
    @doctor = Doctor.new
  end
  
  def create
    @doctor = Doctor.new(params[:doctor])
    @doctor.user_id = current_user.id
    @doctor.service_provider_id = session[:user_service_provider]
    @doctor.doctorname = @doctor.firstname + " " + @doctor.lastname
    respond_to do |format|
    if @doctor.save
      format.html { redirect_to(doctors_path, :id => nil, :notice => 'Profile saved successfully.') }
      format.xml  { render :xml => @doctor, :status => :created, :location => @doctor }
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
    end
    end
  end
  
  def edit
    @doctor = current_user.doctors.find(params[:id])
  end
  
  def update
   @doctor = Doctor.find(params[:id])
   @doctor.doctorname =  params[:doctor][:firstname] + " " +  params[:doctor][:lastname]
   respond_to do |format|
   if @doctor.update_attributes(params[:doctor])
     format.html { redirect_to(doctors_path, :notice => 'Profile Updated successfully.') }
     format.xml  { head :ok }
   else
     format.html { render :action => "edit" }
     format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
   end
   end 
  end
  
  def show
    @doctor = current_user.doctors.find(params[:id])
  end

  private

  def set_service_provider
    session[:user_service_provider] = 1 if params[:sp_id] == '1'
    session[:user_service_provider] = 4 if params[:sp_id] == '4'
    session[:user_service_provider] = 5 if params[:sp_id] == '5'
    session[:user_service_provider] = 7 if params[:sp_id] == '7'
  end


  def checking_user_status
    status = current_user.service_providers.where('user_service_providers.status=? and user_service_providers.service_provider_id in (?)',true, [session[:user_service_provider],params[:sp_id]]).first
    if status
    else
      flash[:error] = "You do not have permissions to access"
      redirect_to consumer_index_path
    end
  end

end
