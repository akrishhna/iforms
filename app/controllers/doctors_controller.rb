class DoctorsController < ApplicationController
  #before_filter :allow_doctors
  def index    
    @iforms = Iform.all
    @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
    @appointments = Appointment.all(:conditions => ['doctor_id = ?', @doctor.id])
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
  
  def show
    @doctor = Doctor.find(params[:id])
  end

end
