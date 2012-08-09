class PatientsController < ApplicationController
  before_filter :is_patient?
  before_filter :patient_profile_exists?, :except => [:new, :create]

  def index
    #@appointments = Appointment.paging(params[:page], params[:id])
    @appointments = Appointment.where('email = ?', current_user.email).order("timereceived DESC").paging(params[:page], params[:appointment_id])
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(params[:patient])
    @patient.user_id = current_user.id

    respond_to do |format|
      if @patient.save
        @appointments = Appointment.all(:conditions => ['email = ?', current_user.email])
        @appointments.each do |i|
          i.patient_id = @patient.id
          i.save
          @appformjoins = Appformjoin.where("appointment_id = ?", i.id)
          @appformjoins.each do |appformjoin|
            appformjoin.patient_user_id = current_user.id
            appformjoin.save
          end
        end
        format.html { redirect_to(patients_path, :id => nil, :notice => 'Profile saved successfully.') }
        format.xml { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @patient = current_user.patients.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(edit_user_registration_path, :notice => 'Profile Updated successfully.') }
        #format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @patient = current_user.patients.find(params[:id])
  end

end
