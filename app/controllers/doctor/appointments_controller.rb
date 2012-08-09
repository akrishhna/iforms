class Doctor::AppointmentsController < DoctorController

  #TODO need modify UI logic
  def index
    @appointments = doctor.appointments.order("date DESC").paging(params[:page], params[:appointment_id])
  end

  #TODO need modify UI logic
  def new
    @appointment = doctor.appointments.new
    @forms = doctor.forms
  end

  #TODO need modify logic
  def create
    @appointment = doctor.appointments.new(params[:appointment])
    @forms = doctor.forms

    @user_forms = Form.find(params[:form_ids])
    form_names = []
    @user_forms.each do |user_form|
      form_names << user_form.formname
    end
    @appointment.formname = form_names.join(',')

    if !@appointment.time_hrs.empty? and !@appointment.AM_PM.empty? and !@appointment.time_min.empty?
      @appointment.appointment_time = @appointment.time_hrs+@appointment.AM_PM+@appointment.time_min
    end

    if @appointment.save
      @user = User.find_by_email(@appointment.email)

      if @user
        @patient = Patient.find_by_user_id(@user.id)
        @appointment.patient_id = @patient.id if @patient
      end

      @appointment.doctorname = doctor.doctorname
      @appointment.timesent = Time.now
      @appointment.save

      @user_forms.each do |user_form|
        @appformjoin = Appformjoin.create(:appointment_id => @appointment.id, :form_id => user_form.id, :formname => user_form.formname, :status => "pending", :doctor_user_id => current_user.id)
        if @user
          @appformjoin.patient_user_id = @user.id
          @appformjoin.save
        end
      end

      Notifier.appointment_confirmation_notification(@appointment, @doctor).deliver

      flash[:success] = "Appointment confirmation email sent successfully to <b>#{@appointment.email}</b>"
      redirect_to doctor_appointments_path
    else
      flash[:error] = "Something is wrong while creating appointment, Please try again."
      render :action => "new"
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @forms = doctor.forms
  end

  #TODO Need modify  logic
  def update
    @appointment = Appointment.find(params[:id])
    @forms = doctor.forms

    @appointment.timesent = Time.now

    p @formids = params[:form_ids]
    a=""
    if @formids
      @formids.each do |i|
        @form = Form.find(i)
        a<<@form.formname+","
      end
    end
    p a
    unless @appointment.formname == a
      p @appointment.formname = a
      app_delete = Appformjoin.where("appointment_id =?",@appointment.id)
      app_delete.delete_all
      @user = User.all(:conditions => ['email = ?', @appointment.email]).first
      if @formids
        @formids.each do |i|
          @form = Form.find(i)
          @appformjoin = Appformjoin.create(:appointment_id => @appointment.id, :form_id => i, :formname => @form.formname, :status => "pending", :doctor_user_id => current_user.id)
          if @user
            @appformjoin.patient_user_id = @user.id
            @appformjoin.save
          end
        end
      end
    end

    if @appointment.update_attributes(params[:appointment])
      Notifier.appointment_confirmation_notification(@appointment, @doctor).deliver
      flash[:success] = 'Appointment details resent successfully.'
      redirect_to doctor_appointments_path
    else
      flash[:error] = "Something is wrong while creating appointment, Please try again."
      render :action => "edit"
    end
  end
end