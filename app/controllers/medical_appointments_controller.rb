class MedicalAppointmentsController < ApplicationController

  def index
    @doctor = Doctor.find_by_user_id(current_user.id)
    @appointments = MedicalAppointment.where("doctor_user_id = ? and service_provider_id=? and DATE_FORMAT(appointment_date_time, '%Y-%m-%d') = ?", @doctor.user_id, session[:user_service_provider], params['appointment_date'] ? params['appointment_date'] : Date.today.to_s).order("firstname ASC").paging(params[:page], params[:appointment_id]) if @doctor
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
      @appointment.medical_patient_forms.build({:service_provider_id  => @appointment.service_provider_id, :doctor_user_id => @appointment.doctor_user_id, :patient_user_id =>     @appointment.patient_user_id})
      @appointment.save
      #Notifier.appointment_confirmation_notification(@appointment, @doctor,session[:user_service_provider]).deliver
      redirect_to :medical_appointments
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
      #Notifier.appointment_confirmation_notification(@appointment, @doctor,session[:user_service_provider]).deliver
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

end
