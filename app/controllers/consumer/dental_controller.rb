class Consumer::DentalController < ApplicationController
  def index
    session["consumer_tab_index"] = 1
    @appointments = Appointment.where('email = ? and date = ?', current_user.email, params['appointment_date'] ? params['appointment_date'] : Date.today.to_s).order("timesent DESC").paging(params[:page], params[:appointment_id])
    @appointments = Appointment.where('email = ?', current_user.email).order("timesent DESC").paging(params[:page], params[:appointment_id]) if !params['appointment_date'].present?
    render :layout => false if request.xhr?
  end
end
