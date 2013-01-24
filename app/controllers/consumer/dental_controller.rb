class Consumer::DentalController < ApplicationController

  def index

    session["consumer_tab_index"] = 1

  #  @appointments = Appointment.where('email = ? and date = ?', current_user.email, params['appointment_date'] ? params['appointment_date'] : Date.today.to_s).order("timesent DESC").paging(params[:page], params[:appointment_id])
  #  @appointments = Appointment.where('email = ?', current_user.email).order("timesent DESC").paging(params[:page], params[:appointment_id]) if !params['appointment_date'].present?

    if params['appointment_date'] && params['appointment_date'] != ''
      begin_date = params['appointment_date'].to_date.beginning_of_day
      end_date = params['appointment_date'].to_date.end_of_day
    else
      begin_date = Date.today.beginning_of_day
      end_date = Date.today.end_of_day
    end

    @appointments = Appointment.where("email = ? and appointment_date_time BETWEEN ? and ?", current_user.email,begin_date,end_date).order("timesent DESC").paging(params[:page], params[:appointment_id])
    @appointments = Appointment.where('email = ?', current_user.email).order("timesent DESC").paging(params[:page], params[:appointment_id]) if !params['appointment_date'].present?


    @appointment_date = params[:appointment_date]
    @check_show_all = true

    if params[:show_all] == 'true'
      @check_show_all = true
      @appointment_date = ''
    # @appointments = Appointment.where('email = ?', current_user.email).order("timesent DESC").paging(params[:page], params[:appointment_id])
    elsif params[:show_all] == 'false'
      @check_show_all = false
    end

    render :layout => false if request.xhr?
  end
end
