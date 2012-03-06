class Patient::AppointmentsController < PatientController

  #TODO need to modify UI
  def index
    @appointments = Appointment.where('email = ?', current_user.email).order("date DESC").paging(params[:page], params[:appointment_id])
    @appointments = patient.appointments.order("date DESC").paging(params[:page], params[:appointment_id])
  end

  def new

  end

  def show
    @appointment = Appointment.find(params[:id])
  end
end
