class Consumer::MedicalController < ApplicationController
  def index
    session["consumer_tab_index"] = 5
    @appointments = MedicalAppointment.where("email = ? and DATE_FORMAT(appointment_date_time, '%Y-%m-%d') = ?", current_user.email, params['appointment_date'] ? params['appointment_date'] : Date.today.to_s).order("timesent DESC").paging(params[:page], params[:appointment_id])
    @appointments = MedicalAppointment.where('email = ?', current_user.email).order("timesent DESC").paging(params[:page], params[:appointment_id]) if !params['appointment_date'].present?
    render :layout => false if request.xhr?
  end

  def edit
    session["consumer_tab_index"] = 5
    @medical = MedicalPatientForm.find(params[:id])
    @appointment = MedicalAppointment.find(@medical.medical_appointment_id)
    @doctor = Doctor.find_by_user_id(@appointment.doctor_user_id)
    @medical.first_name = @appointment.firstname
    @medical.last_name = @appointment.lastname
    if @appointment.status == 'Submitted' || @appointment.status == 'Updated'
      @appointment.status = 'Submitted'
    else
      @appointment.status = 'In Progress'
    end
    @appointment.save
  end

  def update
    @medical_patient_form = MedicalPatientForm.find(params[:medical_patient_form][:id])
    @appointment = MedicalAppointment.find(@medical_patient_form.medical_appointment_id)
    @service_provider_id = @appointment.service_provider_id

    if @medical_patient_form.update_attributes(params[:medical_patient_form])
      MedicalPatientForm.capital_medical_clinic_generate_pdf(@medical_patient_form, @appointment)
      if @appointment.status == "Submitted" || @appointment.status == "Updated"
        @appointment.status = "Updated"
      else
        @appointment.status = "Submitted"
      end
      @appointment.timereceived = Time.now
      @appointment.save
      #Notifier.edit_form_submission_notification(@iform.appointment, @iform.formname, @iform).deliver
      redirect_to :consumer_index
    else
      render :edit, :notice => 'Something wrong plese try again'
    end
  end

  def show
    redirect_to :consumer_index
  end

  def medical_patient_form_field_update
    @medical_patient_form = MedicalPatientForm.find(params[:id])
    appointment = MedicalAppointment.find(@medical_patient_form.medical_appointment_id)
    @medical_patient_form.update_attributes(params[:medical_patient_form])
    if params[:medical_patient_form][:first_name]
      appointment.firstname = params[:medical_patient_form][:first_name]
    elsif params[:medical_patient_form][:last_name]
      appointment.lastname = params[:medical_patient_form][:last_name]
    else
    end
    appointment.save(:validate => false)

    render :json => {:status => 'ok'}
  end

  def medical_patient_form_all_fields_update
    medical_patient_form = MedicalPatientForm.find(params[:medical_patient_form][:id])
    medical_patient_form.update_attributes params[:medical_patient_form]

    render :json => {:status => 'ok'}
  end

  def get_medical_patient_form
     @medical_patient_form = MedicalPatientForm.find(params[:id])
     appointment = MedicalAppointment.find(@medical_patient_form.medical_appointment_id)
    if appointment.status == 'Pending' || appointment.status == 'In Progress'
      send_file CAPITAL_MEDICAL_CLINIC_PATH,
                :filename => "CapitalMedical_Clinic.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    else
      file_name = "#{@medical_patient_form.first_name.gsub(' ', '-')}_#{@medical_patient_form.first_name.gsub(' ', '-')}_capital_medical_clinic"
      permission_form_path = "#{PDFFILES_PATH}#{file_name}"
      send_file permission_form_path,
                :filename => "#{file_name}",
                :disposition => "inline",
                :type => "application/pdf"
    end

  end


end
