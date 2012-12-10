class MedicalAppointmentsController < ApplicationController
  before_filter :set_service_provider

  def index
    session["consumer_tab_index"] = 5
    @doctor = Doctor.find_by_user_id(current_user.id)
    if  params['appointment_date']
      begin_date = params['appointment_date'].beginning_of_day
      end_date = params['appointment_date'].end_of_day
    else
      begin_date = Date.today.beginning_of_day
      end_date = Date.today.end_of_day
    end
    @appointments = MedicalAppointment.where("doctor_user_id = ? and service_provider_id=? and appointment_date_time BETWEEN ? and ?", @doctor.user_id, session[:user_service_provider],begin_date,end_date).order("firstname ASC").paging(params[:page], params[:appointment_id]) if @doctor
  end

  def new
    @appointment = MedicalAppointment.new
    @old_appointment = MedicalAppointment.find(params[:appointment_id]) if params[:appointment_id].present?
  end

  def create
    @appointment = MedicalAppointment.new(params[:medical_appointment])
    @doctor = Doctor.where('user_id = ?', current_user.id).first
    @appointment.doctor_id = @doctor.id
    @appointment.doctor_user_id = current_user.id
    @appointment.service_provider_id = session[:user_service_provider]
    @appointment.formname = 'New_Medical_Patient'
    @appointment.formname = '' if params[:radio_buttons] == 'None'
    @appointment.status = 'Pending'
    if @appointment.save
      @user = User.find_by_email(@appointment.email)
      if @user
        @appointment.patient_user_id = @user.id
      end
      @doctor_details = @appointment.doctor
      @appointment.doctorname = @doctor_details.doctorname
      @appointment.timesent = Time.now
      @appointment.medical_patient_forms.build({:service_provider_id => @appointment.service_provider_id, :doctor_user_id => @appointment.doctor_user_id, :patient_user_id => @appointment.patient_user_id})
      @appointment.save
      Notifier.capital_medical_clinic_appointment_confirmation_notification(@appointment, @doctor, session[:user_service_provider]).deliver
      redirect_to :medical_appointments, :notice => "Appointment confirmation email sent successfully to #{@appointment.email}"
    else
      render :new, :notice => 'Something wrong plese try again'
    end
  end

  def edit
    @appointment = MedicalAppointment.find(params[:id])
  end

  def update
    @appointment = MedicalAppointment.find(params[:id])
    @appointment.formname = 'New_Medical_Patient'
    @appointment.formname = '' if params[:radio_buttons] == 'None'
    @appointment.status = 'Pending'
    @appointment.timesent = Time.now
    if @appointment.update_attributes(params[:medical_appointment])
      Notifier.capital_medical_clinic_appointment_confirmation_notification(@appointment, @doctor, session[:user_service_provider]).deliver
      redirect_to :medical_appointments
    else
      render :new, :notice => 'Something wrong plese try again'
    end
  end

  def destroy
    @appointment = MedicalAppointment.find(params[:id])
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url }
      format.xml { head :ok }
    end
  end

  private
  def set_service_provider
    session[:user_service_provider] = 5 if params[:sp_id] == '5'
  end

end
