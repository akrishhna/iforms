class Consumer::MedicalController < ApplicationController
  def index
    session["consumer_tab_index"] = 5
    @appointments = MedicalAppointment.where("email = ? and DATE_FORMAT(appointment_date_time, '%Y-%m-%d') = ?", current_user.email, params['appointment_date'] ? params['appointment_date'] : Date.today.to_s).order("timesent DESC").paging(params[:page], params[:appointment_id])
    @appointments = MedicalAppointment.where('email = ?', current_user.email).order("timesent DESC").paging(params[:page], params[:appointment_id]) if !params['appointment_date'].present?
    render :layout => false if request.xhr?
  end

  def edit_medical_form
    session["consumer_tab_index"] = 5
    @medical = MedicalPatientForm.find_or_initialize_by_medical_appointment_id(params[:id])
    raise @medical.to_yaml

  end

  def update

  end
end
