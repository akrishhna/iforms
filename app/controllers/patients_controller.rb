class PatientsController < ApplicationController
  #before_filter :allow_patients
  def index
    @appointments = Appointment.all(:conditions => ['email = ?', current_user.email])
  end

  def new
    @patient = Patient.new
  end
  
  def create
    @patient = Patient.new(params[:patient])
    @patient.user_id = current_user.id
    @appointment = Appointment.all(:conditions => ['email = ?', current_user.email]).first
    @appointment.patient_id = @patient.id
    respond_to do |format|
    if @patient.save
      format.html { redirect_to(patients_path, :id => nil, :notice => 'Profile saved successfully.') }
      format.xml  { render :xml => @patient, :status => :created, :location => @patient }
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
    end
    end
  end
  
  def show
    @patient = Patient.find(params[:id])
  end

end
