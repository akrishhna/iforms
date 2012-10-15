class DoctorsController < ApplicationController
  before_filter :set_service_provider
  before_filter :doctor_profile_exists?, :except => [:new,:create]
  def index
    session["consumer_tab_index"] = 1
    @iforms = Iform.all
    @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
    @appointments = Appointment.where('doctor_id = ? and date = ?', @doctor.id,params['appointment_date']?params['appointment_date']:Date.today.to_s).order("firstname ASC").paging(params[:page], params[:appointment_id])
    render :layout => false if request.xhr?
  end

  def new
    @doctor = Doctor.new
  end
  
  def create
    @doctor = Doctor.new(params[:doctor])
    @doctor.user_id = current_user.id
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
    session[:user_service_provider] = 1
  end


end
