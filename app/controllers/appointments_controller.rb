class AppointmentsController < ApplicationController
  #before_filter :is_doctor?, :except => ["show"]

  def new
    @appointment = Appointment.new
    @old_appointment = Appointment.find_by_id(params[:appointment_id])
    @forms = Appformjoin.where('appointment_id = ?', params[:appointment_id])
    @ids = @forms.map { |f| f.form_id }
    #Form.create(:formname => "Bastrop_Child", :doctor_id => 2, :formpath => "http://50.57.138.165/iforms/new")
    #Form.create(:formname => "Steiner_Ranch_Adult", :doctor_id => 2, :formpath => "http://localhost:3000/iforms/new")
  end

  def create

    @appointment = Appointment.new(params[:appointment])
      respond_to do |format|
        @doctor = Doctor.where('user_id = ?', current_user.id).first
        @appointment.doctor_id = @doctor.id
        @appointment.doctor_user_id = current_user.id
        @appointment.service_provider_id = session[:user_service_provider]
        if @appointment.location == 'Bastrop'
          @appointment.formname = 'Adult Bastrop' if params[:radio_buttons] == 'Adult'
          @appointment.formname = 'Child Bastrop' if params[:radio_buttons] == 'Child'
          @appointment.formname = '' if params[:radio_buttons] == 'None'
        elsif @appointment.location == 'Central Austin'
          @appointment.formname = 'Adult Central Austin' if params[:radio_buttons] == 'Adult'
          @appointment.formname = 'Child Central Austin' if params[:radio_buttons] == 'Child'
          @appointment.formname = '' if params[:radio_buttons] == 'None'
        elsif @appointment.location == 'Steiner Ranch'
          @appointment.formname = 'Adult Steiner Ranch' if params[:radio_buttons] == 'Adult'
          @appointment.formname = 'Child Steiner Ranch' if params[:radio_buttons] == 'Child'
          @appointment.formname = '' if params[:radio_buttons] == 'None'
        elsif @appointment.location == 'Cedar Park'
          @appointment.formname = 'New Patient'
          @appointment.formname = '' if params[:radio_buttons] == 'None'
        elsif @appointment.location == 'Location Name'
          @appointment.formname = 'Rising Stars Pediatric'
          @appointment.formname = '' if params[:radio_buttons] == 'None'
        else
          @appointment.formname = ''
        end
        if !@appointment.time_hrs.empty? and !@appointment.AM_PM.nil? and !@appointment.time_min.empty?
          @appointment.appointment_time = @appointment.time_hrs+@appointment.AM_PM+@appointment.time_min
        end

        if @appointment.save
          @user = User.find_by_email(@appointment.email)
          if @user
            @patient = Patient.find_by_user_id(@user.id)
          end
          #-- recent changes
          if @patient
            @appointment.patient_id = @patient.id
            @appointment.patient_user_id = @patient.user_id
          end
          #changes end
          @doctor_details = @appointment.doctor
          @appointment.doctorname = @doctor_details.doctorname
          @appointment.timesent = Time.now
          @appointment.save
          if params[:radio_buttons] != 'None' and @appointment.formname != ''
            form = Form.find_by_formname(@appointment.formname)
            @appformjoin = Appformjoin.create(:appointment_id => @appointment.id, :form_id => form.id, :formname => form.formname, :status => "pending", :doctor_user_id => current_user.id)
            if @user
              @appformjoin.patient_user_id = @user.id
              @appformjoin.save
            end
          end

          Notifier.appointment_confirmation_notification(@appointment, @doctor,session[:user_service_provider]).deliver
          format.html { redirect_to(doctors_path, :id => nil, :notice => "Appointment confirmation email sent successfully to #{@appointment.email}") }
          format.xml { render :xml => @appointment, :status => :created, :location => @appointment }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @appointment.errors, :status => :unprocessable_entity }
        end
      end
  end

  def index
    @appointments = Appointment.all
    respond_to do |format|
      format.html { redirect_to new_appointment_path }
      format.xml { head :ok }
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update

    @appointment = Appointment.find(params[:id])
    respond_to do |format|
      @doctor = Doctor.where('user_id = ?', current_user.id).first
      @appointment.timesent = Time.now

      if params[:appointment][:location] == 'Bastrop'
        @appointment.formname = 'Adult Bastrop' if params[:radio_buttons] == 'Adult'
        @appointment.formname = 'Child Bastrop' if params[:radio_buttons] == 'Child'
        @appointment.formname = '' if params[:radio_buttons] == 'None'
      elsif params[:appointment][:location] == 'Central Austin'
        @appointment.formname = 'Adult Central Austin' if params[:radio_buttons] == 'Adult'
        @appointment.formname = 'Child Central Austin' if params[:radio_buttons] == 'Child'
        @appointment.formname = '' if params[:radio_buttons] == 'None'
      elsif params[:appointment][:location] == 'Steiner Ranch'
        @appointment.formname = 'Adult Steiner Ranch' if params[:radio_buttons] == 'Adult'
        @appointment.formname = 'Child Steiner Ranch' if params[:radio_buttons] == 'Child'
        @appointment.formname = '' if params[:radio_buttons] == 'None'
      elsif @appointment.location == 'Cedar Park'
        @appointment.formname = 'New Patient'
        @appointment.formname = '' if params[:radio_buttons] == 'None'
      elsif @appointment.location == 'Location Name'
        @appointment.formname = 'Rising Stars Pediatric'
        @appointment.formname = '' if params[:radio_buttons] == 'None'
      else
        @appointment.formname = ''
      end
      if params[:radio_buttons] != 'None' and @appointment.formname != ''
        app_delete = Appformjoin.where("appointment_id =?", @appointment.id)
        app_delete.delete_all
        @user = User.find_by_email(@appointment.email)
        form = Form.find_by_formname(@appointment.formname)
        @appformjoin = Appformjoin.create(:appointment_id => @appointment.id, :form_id => form.id, :formname => form.formname, :status => "pending", :doctor_user_id => current_user.id)
        if @user
          @appformjoin.patient_user_id = @user.id
          @appformjoin.save
        end
      end
      if @appointment.update_attributes(params[:appointment])
        Notifier.appointment_confirmation_notification(@appointment, @doctor, session[:user_service_provider]).deliver
        format.html { redirect_to(doctors_path, :notice => 'Appointment details resent successfully.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @appointment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    # @appointment.destroy
    respond_to do |format|
      format.html { redirect_to doctors_url }
      format.xml { head :ok }
    end
  end


end
