class IformsController < ApplicationController

  before_filter :authenticate_user! #, :except => [:index]
                                    #  before_filter :is_patient?, :except => [:show, :get_iform]

  def index
    # @iform = Iform.all
    respond_to do |format|
      format.html { redirect_to patients_path }
      format.xml { head :ok }
    end
  end

  def save
    @iform = Iform.new(params[:iform])
    p "with in save"
    p @iform.Self_Name_First
    respond_to do |format|
      format.js
    end
  end

  # GET /iform/1
  # GET /iform/1.xml
  def show
    redirect_to consumer_index_path
    #session[:appointment_id_show] = params[:appointment_id]
    #if session[:appointment_id_show]
    #  @appointment = Appointment.find(session[:appointment_id_show])
    #  @iform = @appointment.iform
    #else
    #  @iform = Iform.find(params[:id])
    #  @appointment = Appointment.find(@iform.appointment_id)
    #end
    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.xml { render :xml => @iform }
    #end
  end

  def new
    @iform = Iform.new
    session[:formname] = params[:name]
    session[:appointment_id] = params[:appointment_id]
    @iform.formname = params[:name]
    @iform.appointment_id = params[:appointment_id]
    @iform.save(:validate => false)

    @appformjoin = Appformjoin.where(:patient_user_id => current_user.id, :appointment_id => @iform.appointment_id, :formname => @iform.formname).first
    @appformjoin.update_attributes({:iform_id => @iform.id})

    redirect_to edit_iform_path(@iform)
  end

  def create
    if session[:formname]
      if session[:formname].include?("Child")
        submit_childform()
      end

      # session[:iform_params].deep_merge!(params[:iform]) if params[:iform]
      #   @iform = Iform.new(session[:iform_params])
      #   @iform.current_step = session[:iform_step]
      #     if @iform.valid?
      #       if params[:back_button]
      #         @iform.previous_step
      #       elsif @iform.last_step?
      #         @iform.save if @iform.all_valid?
      #       else
      #        @iform.next_step
      #       end
      #      session[:iform_step] = @iform.current_step
      #     end
      #     if @iform.new_record?
      #       render "new"
      #     else
      #       session[:iform_step] = session[:iform_params] = nil
      #       flash[:notice] = "iform saved!"
      #       redirect_to @iform
      #     end
      if session[:formname].include?("Adult")
        @iformcheck = Iform.where("appointment_id = ? and formname = ?", session[:appointment_id], session[:formname]).first
        if !@iformcheck
          @iform = Iform.new(params[:iform])
          #@age = Date.today.year - @iform.Self_Birthdate.year
          #@age -= 1 if Date.today < @iform.Self_Birthdate + age.years and birthdate.month > now.month and birthdate.day > now.day
          age_calculator(@iform)

          @iform.path = iform_file_name(@iform)
          @iform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider = Date.today
          @iform.formname = session[:formname]
          respond_to do |format|

            if @iform.save! and !@iform.Self_Name_Last.empty? and !@iform.Self_Name_First.empty?
              @iform.appointment_id = session[:appointment_id]

              age_calculator(@iform)
              @iform.Self_Age = @You_Age
              @iform.save
              #------------------------------------------------------------------
              adultform_control_conditions(@iform)

              #--------------------------------------------------------------------------------

              @appointment = Appointment.find(session[:appointment_id])
              @appointment.timereceived = Time.now
              @appointment.status = "Received"
              @appointment.save
              @form = Form.where("formname = ?", session[:formname]).first
              @appformjoin = Appformjoin.where("appointment_id = ? and form_id = ?", session[:appointment_id], @form.id).first
              @appformjoin = Appformjoin.find(@appformjoin.id)
              @appformjoin.status = "submitted"
              p @appformjoin.formsubmittedtime = Time.now
              @appformjoin.iform_id = @iform.id
              @appformjoin.save
              adultform_controls_mapping(@iform.path, @iform)
              Notifier.form_submission_notification(@appointment, session[:formname], @iform).deliver

              format.html { redirect_to(@iform, :notice => 'form was successfully submitted.') }
              format.xml { render :xml => @iform, :status => :created, :location => @iform }
            else
              format.html { render :action => "new" }
              format.xml { render :xml => @iform.errors, :status => :unprocessable_entity }
            end
          end
          # p @appformjoin.status
          #   Iform.update_appformjoin(@appformjoin)
          # @appformjoin = Appformjoin.where("appointment_id = ?", session[:appointment_id])
          #   @appformjoin.each do |i|
          #     if i.status == "pending"
          #       i.status = nil
          #       i.save
          #     end
          #   end
        else
          render :text => "You have already filled the form"
        end
      end
      session[:formname]=nil
      session[:appointment_id]=nil
    else
      render :text => "You have already filled the form"
    end
  end

  def edit
    @iform = Iform.find(params[:id])
    @appointment = Appointment.find(@iform.appointment_id)
    #@doctor = Doctor.find(@appointment.doctor_id)
    @iform.Self_Name_First = @appointment.firstname
    @iform.Self_Name_Last = @appointment.lastname
    @doctor = Doctor.find_by_user_id(@appointment.doctor_user_id)
    @appform = Appformjoin.find_by_appointment_id(@appointment.id)
    @appform = Appformjoin.find_by_appointment_id_and_id(@appointment.id, params[:appform_id]) if params[:appform_id].present?
    if @appform.status == 'submitted' || @appform.status == 'updated'
      @appform.status = 'submitted'
    else
      @appform.status = 'in progress'
    end
    @recent_app_form = Appformjoin.where('status in (?) and patient_user_id=?', ['Sent', 'Submitted', 'Updated'], @appointment.patient_user_id).order('updated_at').last

    @recent_iform = Iform.find(@recent_app_form.iform_id) rescue nil

    if @recent_iform
      # patient Tab
      @iform[:Self_Home_Address1] = @recent_iform['Self_Home_Address1']
      @iform[:Self_Home_Address2] = @recent_iform['Self_Home_Address2']
      @iform[:Self_Home_City] = @recent_iform['Self_Home_City']
      @iform[:Self_Home_State] = @recent_iform['Self_Home_State']
      @iform[:Self_Home_Postal_Code] = @recent_iform['Self_Home_Postal_Code']
      @iform[:home_phone_1] = @recent_iform['home_phone_1']
      @iform[:home_phone_2] = @recent_iform['home_phone_2']
      @iform[:home_phone_3] = @recent_iform['home_phone_3']
      @iform[:patient_other_phone_1] = @recent_iform['patient_other_phone_1']
      @iform[:patient_other_phone_2] = @recent_iform['patient_other_phone_2']
      @iform[:patient_other_phone_3] = @recent_iform['patient_other_phone_3']
      @iform[:patient_previously_siblings_list] = @recent_iform['patient_previously_siblings_list']
      @iform[:how_did_you_hear_about_office] = @recent_iform['how_did_you_hear_about_office']

      # Father Tab
      @iform[:patient_guardian_father] = @recent_iform['patient_guardian_father']
      @iform[:patient_guardian_father_other_description] = @recent_iform['patient_guardian_father_other_description']
      @iform[:patient_guardian_father_first_name] = @recent_iform['patient_guardian_father_first_name']
      @iform[:patient_guardian_father_last_name] = @recent_iform['patient_guardian_father_last_name']
      @iform[:patient_guardian_father_birth_date] = @recent_iform['patient_guardian_father_birth_date']
      @iform[:patient_guardian_father_ssn_1] = @recent_iform['patient_guardian_father_ssn_1']
      @iform[:patient_guardian_father_ssn_2] = @recent_iform['patient_guardian_father_ssn_2']
      @iform[:patient_guardian_father_ssn_3] = @recent_iform['patient_guardian_father_ssn_3']
      @iform[:patient_guardian_father_employer] = @recent_iform['patient_guardian_father_employer']
      @iform[:patient_guardian_father_work_phone_1] = @recent_iform['patient_guardian_father_work_phone_1']
      @iform[:patient_guardian_father_work_phone_2] = @recent_iform['patient_guardian_father_work_phone_2']
      @iform[:patient_guardian_father_work_phone_3] = @recent_iform['patient_guardian_father_work_phone_3']
      @iform[:patient_guardian_father_address_1] = @recent_iform['patient_guardian_father_address_1']
      @iform[:patient_guardian_father_address_2] = @recent_iform['patient_guardian_father_address_2']
      @iform[:patient_guardian_father_address_city] = @recent_iform['patient_guardian_father_address_city']
      @iform[:patient_guardian_father_address_state] = @recent_iform['patient_guardian_father_address_state']
      @iform[:patient_guardian_father_address_zip] = @recent_iform['patient_guardian_father_address_zip']
      @iform[:patient_guardian_father_home_phone_1] = @recent_iform['patient_guardian_father_home_phone_1']
      @iform[:patient_guardian_father_home_phone_2] = @recent_iform['patient_guardian_father_home_phone_2']
      @iform[:patient_guardian_father_home_phone_3] = @recent_iform['patient_guardian_father_home_phone_3']
      @iform[:patient_guardian_father_cell_phone_1] = @recent_iform['patient_guardian_father_cell_phone_1']
      @iform[:patient_guardian_father_cell_phone_2] = @recent_iform['patient_guardian_father_cell_phone_2']
      @iform[:patient_guardian_father_cell_phone_3] = @recent_iform['patient_guardian_father_cell_phone_3']
      @iform[:patient_guardian_father_email] = @recent_iform['patient_guardian_father_email']

      # Mother Tab
      @iform[:patient_guardian_mother] = @recent_iform['patient_guardian_mother']
      @iform[:patient_guardian_mother_other_description] = @recent_iform['patient_guardian_mother_other_description']
      @iform[:patient_guardian_mother_first_name] = @recent_iform['patient_guardian_mother_first_name']
      @iform[:patient_guardian_mother_last_name] = @recent_iform['patient_guardian_mother_last_name']
      @iform[:patient_guardian_mother_birth_date] = @recent_iform['patient_guardian_mother_birth_date']
      @iform[:patient_guardian_mother_ssn_1] = @recent_iform['patient_guardian_mother_ssn_1']
      @iform[:patient_guardian_mother_ssn_2] = @recent_iform['patient_guardian_mother_ssn_2']
      @iform[:patient_guardian_mother_ssn_3] = @recent_iform['patient_guardian_mother_ssn_3']
      @iform[:patient_guardian_mother_employer] = @recent_iform['patient_guardian_mother_employer']
      @iform[:patient_guardian_mother_work_phone_1] = @recent_iform['patient_guardian_mother_work_phone_1']
      @iform[:patient_guardian_mother_work_phone_2] = @recent_iform['patient_guardian_mother_work_phone_2']
      @iform[:patient_guardian_mother_work_phone_3] = @recent_iform['patient_guardian_mother_work_phone_3']
      @iform[:patient_guardian_mother_address_1] = @recent_iform['patient_guardian_mother_address_1']
      @iform[:patient_guardian_mother_address_2] = @recent_iform['patient_guardian_mother_address_2']
      @iform[:patient_guardian_mother_address_city] = @recent_iform['patient_guardian_mother_address_city']
      @iform[:patient_guardian_mother_address_state] = @recent_iform['patient_guardian_mother_address_state']
      @iform[:patient_guardian_mother_address_zip] = @recent_iform['patient_guardian_mother_address_zip']
      @iform[:patient_guardian_mother_home_phone_1] = @recent_iform['patient_guardian_mother_home_phone_1']
      @iform[:patient_guardian_mother_home_phone_2] = @recent_iform['patient_guardian_mother_home_phone_2']
      @iform[:patient_guardian_mother_home_phone_3] = @recent_iform['patient_guardian_mother_home_phone_3']
      @iform[:patient_guardian_mother_cell_phone_1] = @recent_iform['patient_guardian_mother_cell_phone_1']
      @iform[:patient_guardian_mother_cell_phone_2] = @recent_iform['patient_guardian_mother_cell_phone_2']
      @iform[:patient_guardian_mother_cell_phone_3] = @recent_iform['patient_guardian_mother_cell_phone_3']
      @iform[:patient_guardian_mother_email] = @recent_iform['patient_guardian_mother_email']

      # Insurance Tab
      @iform[:insurance_do_you_have_more_than_one_dental_insurance] = @recent_iform['insurance_do_you_have_more_than_one_dental_insurance']
      @iform[:insurance_second_insurance_company_name] = @recent_iform['insurance_second_insurance_company_name']
      @iform[:insurance_insured] = @recent_iform['insurance_insured']
      @iform[:insurance_person_first_name] = @recent_iform['insurance_person_first_name']
      @iform[:insurance_person_last_name] = @recent_iform['insurance_person_last_name']
      @iform[:insurance_relation_ship_to_patient] = @recent_iform['insurance_relation_ship_to_patient']
      @iform[:insurance_employer] = @recent_iform['insurance_employer']
      @iform[:insurance_company_name] = @recent_iform['insurance_company_name']
      @iform[:insurance_member_id] = @recent_iform['insurance_member_id']
      @iform[:insurance_group] = @recent_iform['insurance_group']
      @iform[:insurance_phone_1] = @recent_iform['insurance_phone_1']
      @iform[:insurance_phone_2] = @recent_iform['insurance_phone_2']
      @iform[:insurance_phone_3] = @recent_iform['insurance_phone_3']
      @iform[:insurance_address_1] = @recent_iform['insurance_address_1']
      @iform[:insurance_address_2] = @recent_iform['insurance_address_2']
      @iform[:insurance_address_city] = @recent_iform['insurance_address_city']
      @iform[:insurance_address_state] = @recent_iform['insurance_address_state']
      @iform[:insurance_address_zip] = @recent_iform['insurance_address_zip']
    end
    @iform.save(:validate => false)
    @appform.save
  end

  # PUT /iform/1
  # PUT /iform/1.xml
  def update
    p "with in update"
    @iform = Iform.find(params[:id])
    app_form = Appformjoin.find_by_iform_id(@iform.id)
    appointment = Appointment.find(app_form.appointment_id)
    @service_provider_id = appointment.service_provider_id
    respond_to do |format|
      if @iform.update_attributes(params[:iform])
        @iform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider = Date.today
        age_calculator(@iform)
        @iform.Self_Age = @You_Age
        @iform.path = iform_file_name(@iform)
        @iform.save
        if @service_provider_id == 1
          if @iform.formname.include?("Adult")
            @iform.save
            adultform_control_conditions(@iform)
            adultform_controls_mapping(@iform.path, @iform)
          end
          if @iform.formname.include?("Child")
            childform_control_conditions(@iform)
            childform_controls_mapping(@iform.path, @iform)
          end
        elsif @service_provider_id == 4
          Iform.new_patient_form_generator(@iform)
        elsif @service_provider_id == 7
          Iform.rising_stars_pediatric_form_generator(@iform)
        else
        end

        appformjoin = Appformjoin.where(:iform_id => @iform.id).first
        if appformjoin.status == "submitted" || appformjoin.status == "Updated"
          appformjoin.status = "updated"
        else
          appformjoin.status = "submitted"
        end
        appformjoin.formsubmittedtime = Time.now
        appformjoin.save
        Notifier.edit_form_submission_notification(@iform.appointment, @iform.formname, @iform).deliver
        format.html { redirect_to(@iform, :notice => 'Form was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @iform.errors, :status => :unprocessable_entity }
      end
    end

  end

  # DELETE /iform/1
  # DELETE /iform/1.xml
  def destroy
    @iform = Iform.find(params[:id])
    @iform.destroy

    respond_to do |format|
      format.html { redirect_to(iform_url) }
      format.xml { head :ok }
    end
  end

  def get_iform
    @iform = Iform.find(params[:iform_id]) if params[:iform_id].present?
    iform_status = params[:iform_status]
    iform_name = params[:iform_name].gsub(' ', '_') rescue nil
    if iform_status
      send_file "#{PDFFILES_PATH}#{iform_name}_Read_Only.pdf",
                :filename => "#{iform_name}.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    else
      send_data @iform.pdffile_path,
                :filename => "#{@iform.path}.pdf",
                :disposition => "inline",
                :type => "application/pdf"
    end
  end

  def iform_field_update
    iform = Iform.find(params[:iform_id])
    appointment = Appointment.find(iform.appointment_id)
    iform.update_attributes(params[:iform])
    if params[:iform][:Self_Name_First]
      appointment.firstname = params[:iform][:Self_Name_First]
    elsif params[:iform][:Self_Name_Last]
      appointment.lastname = params[:iform][:Self_Name_Last]
    else
    end
    appointment.save(:validate => false)

    render :json => {:status => 'ok'}
  end

  def iform_all_fields_update
    iform = Iform.find(params[:iform_id])
    iform.update_attributes params[:iform]

    if params[:iform][:person_responsible_for_ac] == "Self"
      iform.billing_birth_date = iform.Self_Birthdate
    end

    iform.save(:validate => false)

    render :json => {:status => 'ok'}
  end


  protected
  def submit_childform
    @iformcheck = Iform.where("appointment_id = ? and formname = ?", session[:appointment_id], session[:formname]).first
    if !@iformcheck
      @iform = Iform.new(params[:iform])
      @iform.path = iform_file_name(@iform)
      @iform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider = Date.today
      age_calculator(@iform)
      @iform.Self_Age = @You_Age
      @iform.formname = session[:formname]
      respond_to do |format|

        if @iform.save!
          @iform.appointment_id = session[:appointment_id]
          @iform.save
          childform_control_conditions(@iform)
          @appointment = Appointment.find(session[:appointment_id])
          @appointment.timereceived = Time.now
          @appointment.status = "Received"
          @appointment.save
          @form = Form.where("formname = ?", session[:formname]).first
          p "00000000000000000000"
          p @form.id
          @appformjoin = Appformjoin.where("appointment_id = ? and form_id = ?", session[:appointment_id], @form.id).first
          @appformjoin = Appformjoin.find(@appformjoin.id)
          @appformjoin.status = "submitted"
          p @appformjoin.formsubmittedtime = Time.now
          @appformjoin.iform_id = @iform.id
          @appformjoin.save
          childform_controls_mapping(@iform.path, @iform)
          Notifier.form_submission_notification(@appointment, session[:formname], @iform).deliver
          format.html { redirect_to(@iform, :notice => 'form was successfully submitted.') }
          format.xml { render :xml => @iform, :status => :created, :location => @iform }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @iform.errors, :status => :unprocessable_entity }
        end
      end
      @appformjoin = Appformjoin.where("appointment_id = ?", session[:appointment_id])
      @appformjoin.each do |i|
        if i.status == "pending"
          i.status = nil
          i.save
        end
      end
    else
      render :text => "You have already filled the form"
    end
  end

  def age_calculator(iform)
    @iform = iform
    if @iform.Self_Birthdate
      @You_Age = Date.today.year - @iform.Self_Birthdate.year
      if Date.today.month < @iform.Self_Birthdate.month
        @You_Age = @You_Age - 1
      end
      if Date.today.month == @iform.Self_Birthdate.month and Date.today.day < @iform.Self_Birthdate.day
        @You_Age = @You_Age - 1
      end
    end
  end

  # method below -- to check conditions to assign to form controls
  def adultform_control_conditions(iform)
    @iform = iform
    @yes = "Yes"
    @Any_serious_medical_conditions = @iform.Med_His_Serious_Medical_Issues
    @Any_speech_problems = @iform.Dental_History_Habits_Speech_Problems
    if !@iform.Med_His_Currently_Taking_Presc_Drugs_List.empty? and !@iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List.empty?
      @Please_list_all_drugs_that_your_child_is_currently_taking = @iform.Med_His_Currently_Taking_Presc_Drugs_List+" / "+@iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List
    elsif @iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List.empty?
      @Please_list_all_drugs_that_your_child_is_currently_taking = @iform.Med_His_Currently_Taking_Presc_Drugs_List
    else
      @Please_list_all_drugs_that_your_child_is_currently_taking = @iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List
    end
    @Billing_Address = @iform.Person_Responsible_For_Account_Address1+" "+@iform.Person_Responsible_For_Account_Address2+" "+ @iform.Person_Responsible_For_Account_City+" "+ @iform.Person_Responsible_For_Account_State+" "+@iform.Person_Responsible_For_Account_Postal_Code
    unless @iform.Med_His_Personal_Physician_Date_Of_Last_Visit.blank?
      @Date_of_last_visit = @iform.Med_His_Personal_Physician_Date_Of_Last_Visit.strftime("%m-%d-%Y")
    end
    if !@iform.Emergency_Contact_Phone_Home.blank? and @iform.Emergency_Contact_Phone_Home.length == 10
      @emergency_phone_hm = @iform.Emergency_Contact_Phone_Home.slice(3, 3) + "-" + @iform.Emergency_Contact_Phone_Home.slice(6, 4)
      @Hm_areacode = @iform.Emergency_Contact_Phone_Home.slice(0, 3)
    end
    if !@iform.Emergency_Contact_Phone_Work.blank? and @iform.Emergency_Contact_Phone_Work.length == 10
      @emergency_phone_wk = @iform.Emergency_Contact_Phone_Work.slice(3, 3) + "-" + @iform.Emergency_Contact_Phone_Work.slice(6, 4)
      @Wk_areacode = @iform.Emergency_Contact_Phone_Work.slice(0, 3)
    end
    @General_Dentist = @iform.Self_General_Dentist_Name
    @Group_Plan_Local_or_Policy = @iform.Insurance_Company_Primary_Group_Plan_Local_Policy_Number
    @Group_Plan_Local_or_Policy2 = @iform.Insurance_Company_Secondary_Group_Plan_Local_Policy_Number
    @His_Her_Name_2 = @iform.Emergency_Contact_Name_First+" "+@iform.Emergency_Contact_Name_Last
    @How_long_there = @iform.Self_Length_Of_Employment
    @I_prefer_to_be_called = @iform.Self_Name_Preferred
    @Ins_Relation_2 = @iform.Insurance_Company_Primary_Insured_Relationship
    unless @iform.Insurance_Company_Primary_Insured_Birthdate.blank?
      @InsBday_1 = @iform.Insurance_Company_Primary_Insured_Birthdate.strftime("%m-%d-%Y")
    end
    @Insurance_Co_Address = @iform.Insurance_Company_Primary_Address1 + " " + @iform.Insurance_Company_Primary_Address2 + " " + @iform.Insurance_Company_Primary_City + " " + @iform.Insurance_Company_Primary_State + " " + @iform.Insurance_Company_Primary_Postal_Code
    @Insurance_Co_Address_2 = @iform.Insurance_Company_Secondary_Address1 + " " + @iform.Insurance_Company_Secondary_Address2 + " " + @iform.Insurance_Company_Secondary_City + " " + @iform.Insurance_Company_Secondary_State + " " + @iform.Insurance_Company_Secondary_Postal_Code
    if !@iform.Insurance_Company_Primary_Phone.blank? and @iform.Insurance_Company_Primary_Phone.length == 10
      @Insurance_Co_AreaCode = @iform.Insurance_Company_Primary_Phone.slice(0, 3)
      @Insurance_Co_Phone = @iform.Insurance_Company_Primary_Phone.slice(3, 3)+"-"+@iform.Insurance_Company_Primary_Phone.slice(6, 4)
    end
    if !@iform.Insurance_Company_Secondary_Phone.blank? and @iform.Insurance_Company_Secondary_Phone.length == 10
      @Insurance_Co_Areacode_2 = @iform.Insurance_Company_Secondary_Phone.slice(0, 3)
      @Insurance_Co_Phone2 = @iform.Insurance_Company_Secondary_Phone.slice(3, 3)+"-"+@iform.Insurance_Company_Secondary_Phone.slice(6, 4)
    end
    @Insurance_Co_Name = @iform.Insurance_Company_Primary_Name
    @Insurance_Co_Name_2 = @iform.Insurance_Company_Secondary_Name
    p @Insured_8217_s_Employer_1 = @iform.Insurance_Company_Primary_Insured_Employer_Name
    p @Insured_8217_s_Employer_2 = @iform.Insurance_Company_Secondary_Insured_Employer_Name
    p "insurance"
    p @Insured_8217_s_Name = @iform.Insurance_Company_Primary_Insured_Name_First+" "+@iform.Insurance_Company_Primary_Insured_Name_Last
    p @Insured_8217_s_Name_2 = @iform.Insurance_Company_Secondary_Insured_Name_First+" "+@iform.Insurance_Company_Secondary_Insured_Name_Last
    if !@iform.Insurance_Company_Primary_Insured_Social_Security_Number.blank? and @iform.Insurance_Company_Primary_Insured_Social_Security_Number.length == 9
      p @Insured_8217_s_SS = @iform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(0, 3)+"-"+@iform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(3, 2) + "-" + @iform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(5, 4)
    end
    if !@iform.Insurance_Company_Secondary_Insured_Social_Security_Number.blank? and @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.length == 9
      p @Insured_8217_s_SS_2 = @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(0, 3)+"-"+@iform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(3, 2) + "-" + @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(5, 4)
    end
    unless @iform.Insurance_Company_Secondary_Insured_Birthdate.blank?
      @InsuredBday_2 = @iform.Insurance_Company_Secondary_Insured_Birthdate.strftime("%m-%d-%Y")
    end
    unless @iform.Self_General_Dentist_Date_Last_Appointment.blank?
      @Last_Visit_Date = @iform.Self_General_Dentist_Date_Last_Appointment.strftime("%m-%d-%Y")
    end
    @Name = @iform.Self_Name_Last + ", " + @iform.Self_Name_First + " " + @iform.Self_Name_Middle+"       "+@iform.Self_Name_Honorific
    @Occupation = @iform.Self_Occupation
    @Other_family_members_seen_by_us = @iform.Self_Other_Family_Members
    @Person_Responsible_for_Account = @iform.Person_Responsible_For_Account_Name_First + " " + @iform.Person_Responsible_For_Account_Name_Middle+" "+ @iform.Person_Responsible_For_Account_Name_Last
    if !@iform.Med_His_Personal_Physician_Phone.blank? and @iform.Med_His_Personal_Physician_Phone.length == 10
      @Physician_areacode = @iform.Med_His_Personal_Physician_Phone.slice(0, 3)
      @Physician_phone = @iform.Med_His_Personal_Physician_Phone.slice(3, 3) + "-" + @iform.Med_His_Personal_Physician_Phone.slice(6, 4)
    end
    p @Physician_8217_s_Name = @iform.Med_His_Personal_Physician_Name_First+ " " +@iform.Med_His_Personal_Physician_Name_Last
    @Please_explain = @iform.Med_His_Currently_Under_The_Care_Of_A_Physician_Desc
    @Relation = @iform.Person_Responsible_For_Account_Relationship
    @Relation_3 = @iform.Insurance_Company_Secondary_Insured_Relationship
    @Relation_4 = @iform.Emergency_Contact_Relationship
    @RespPerson_DL = @iform.Person_Responsible_For_Account_Drivers_License_State + " " + @iform.Person_Responsible_For_Account_Drivers_License_Number
    @RespPerson_Employer = @iform.Person_Responsible_For_Account_Employer_Name
    if !@iform.Person_Responsible_For_Account_Social_Security_Number.blank? and @iform.Person_Responsible_For_Account_Social_Security_Number.length == 9
      @RespPerson_SS = @iform.Person_Responsible_For_Account_Social_Security_Number.slice(0, 3) + "-" + @iform.Person_Responsible_For_Account_Social_Security_Number.slice(3, 2) + "-" + @iform.Person_Responsible_For_Account_Social_Security_Number.slice(5, 4)
    end
    if !@iform.Person_Responsible_For_Account_Phone_Home.blank? and @iform.Person_Responsible_For_Account_Phone_Home.length == 10
      @RespPersonHm = @iform.Person_Responsible_For_Account_Phone_Home.slice(3, 3) + "-" + @iform.Person_Responsible_For_Account_Phone_Home.slice(6, 4)
      @RespPersonHmAreacode = @iform.Person_Responsible_For_Account_Phone_Home.slice(0, 3)
    end
    if !@iform.Person_Responsible_For_Account_Phone_Work.blank? and @iform.Person_Responsible_For_Account_Phone_Work.length == 10
      @RespPersonWk = @iform.Person_Responsible_For_Account_Phone_Work.slice(3, 3) + "-" + @iform.Person_Responsible_For_Account_Phone_Work.slice(6, 4)
      @RespPersonWk_areacode = @iform.Person_Responsible_For_Account_Phone_Work.slice(0, 3)
    end
    @RespPersonWkExt = @iform.Person_Responsible_For_Account_Phone_Work_Extension
    unless @iform.Spouse_Birthdate.blank?
      @Spouse_Birthdate = @iform.Spouse_Birthdate.strftime("%m-%d-%Y")
    end
    @Spouse_Employer = @iform.Spouse_Employer_Name
    @Spouse_Name = @iform.Spouse_Name_First + " " + @iform.Spouse_Name_Middle + " " + @iform.Spouse_Name_Last
    if !@iform.Spouse_Phone_Work.blank? and @iform.Spouse_Phone_Work.length == 10
      @Spouse_Wk_Area_Code = @iform.Spouse_Phone_Work.slice(0, 3)
      @Spouse_Wk_Phone = @iform.Spouse_Phone_Work.slice(3, 3) + "-" + @iform.Spouse_Phone_Work.slice(6, 4)
    end
    @Spouse_Wk_Ext = @iform.Spouse_Phone_Work_Extension
    if !@iform.Spouse_Social_Security_Number.blank? and @iform.Spouse_Social_Security_Number.length == 9
      @SpouseSS = @iform.Spouse_Social_Security_Number.slice(0, 3) + "-" + @iform.Spouse_Social_Security_Number.slice(3, 2) + "-" + @iform.Spouse_Social_Security_Number.slice(5, 4)
    end
    @Today_8217_s_Date = @iform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider.strftime("%m-%d-%Y")
    @Week = @iform.Med_His_Weeks_Pregnant
    @What_do_you_want = @iform.Dental_History_Orthodontic_Goals
    @When_taken_Phen_Fen = @iform.Dental_History_When_Taken_PhenFen_Redux_Pondimin
    if !@iform.Self_Best_Contact_Method.empty? and !@iform.Self_Best_Contact_Time.empty?
      @Where_amp_when_are_best_times_to_reach_you = @iform.Self_Best_Contact_Method + ": " + @iform.Self_Best_Contact_Time
    elsif !@iform.Self_Best_Contact_Method.empty?
      @Where_amp_when_are_best_times_to_reach_you = @iform.Self_Best_Contact_Method
    else
      @Where_amp_when_are_best_times_to_reach_you = @iform.Self_Best_Contact_Time
    end
    @Whom_may_we_Thank_for_referring_you = @iform.Self_Referred_By
    unless @iform.Self_Birthdate.blank?
      @You_Birthdate = @iform.Self_Birthdate.strftime("%m-%d-%Y")
    end
    @You_City = @iform.Self_Home_City
    @You_Drivers_License = @iform.Self_Driver_License_State + ": " + @iform.Self_Driver_License_Number
    @You_Employer = @iform.Self_Employer_Name
    @You_Employer_8217_s_Address = @iform.Self_Employer_Address1 + " " + @iform.Self_Employer_Address2 + " " + @iform.Self_Employer_City + " " + @iform.Self_Employer_State + " " + @iform.Self_Employer_Postal_Code
    @You_Ext = @iform.Self_Phone_Work_Extension
    if !@iform.Self_Phone_Home.blank? and @iform.Self_Phone_Home.length == 10
      @You_Hm = @iform.Self_Phone_Home.slice(3, 3) + "-" + @iform.Self_Phone_Home.slice(6, 4)
      @You_Hm_Area_Code = @iform.Self_Phone_Home.slice(0, 3)
    end
    @You_Home_Address = @iform.Self_Home_Address1 + " " + @iform.Self_Home_Address2
    if !@iform.Self_Phone_Mobile.blank? and @iform.Self_Phone_Mobile.length == 10
      @You_Pager_Other = @iform.Self_Phone_Mobile.slice(0, 3) + "-" + @iform.Self_Phone_Mobile.slice(3, 3) + "-" + @iform.Self_Phone_Mobile.slice(6, 4)
    end
    if !@iform.Self_Social_Security_Number.blank? and @iform.Self_Social_Security_Number.length == 9
      @You_SS = @iform.Self_Social_Security_Number.slice(0, 3) + "-" + @iform.Self_Social_Security_Number.slice(3, 2) + "-" + @iform.Self_Social_Security_Number.slice(5, 4)
    end
    @You_State = @iform.Self_Home_State
    @Allergic = @iform.Allergic_To_Drugs_List
    if !@iform.Self_Phone_Work.blank? and @iform.Self_Phone_Work.length == 10
      @You_Wk = @iform.Self_Phone_Work.slice(3, 3) + "-" + @iform.Self_Phone_Work.slice(6, 4)
      @You_Wk_Area_Code = @iform.Self_Phone_Work.slice(0, 3)
    end
    @You_Zip = @iform.Self_Home_Postal_Code
    @Your_EMail_Address = @iform.Self_Email_Address
    case @iform.Allergic_To_Aspirin
      when true
        @Aspirin_Y = @yes
      when false
        @Aspirin_N = @yes
    end
    case @iform.Allergic_To_Codeine
      when true
        @Codeine_Y = @yes
      when false
        @Codeine_N = @yes
    end
    case @iform.Allergic_To_Dental_Anesthetics
      when true
        @Anesthetics_Y = @yes
      when false
        @Anesthetics_N = @yes
    end
    case @iform.Allergic_To_Erythromycin
      when true
        @Erythromycin_Y = @yes
      when false
        @Erythromycin_N = @yes
    end
    case @iform.Allergic_To_Latex
      when true
        @Latex_Y = @yes
      when false
        @Latex_N = @yes
    end
    case @iform.Allergic_To_Metals or @iform.Allergic_To_Plastics
      when true
        @Metals_Y = @yes
      when false
        @Metals_N = @yes
    end
    case @iform.Allergic_To_Other
      when true
        @Other_Y = @yes
      when false
        @Other_N = @yes
    end
    case @iform.Allergic_To_Penicillin
      when true
        @Penicillin_Y = @yes
      when false
        @Penicillin_N = @yes
    end
    case @iform.Allergic_To_Tetracycline
      when true
        @Tetracycline_Y = @yes
      when false
        @Tetracycline_N = @yes
    end
    case @iform.Dental_History_Any_Missing_Teeth or @iform.Dental_History_Any_Extra_Permanent_Teeth
      when true
        @Teeth_yes = @yes
      when false
        @Teeth_no = @yes
    end
    case @iform.Dental_History_Bleeding_Gums
      when true
        @Gums_bleed_yes = @yes
      when false
        @Gums_bleed_no = @yes
    end
    case @iform.Dental_History_Current_Dental_Health
      when "fair"
        @Dental_Health_fair = @yes
      when "good"
        @Dental_Health_good = @yes
      when "poor"
        @Dental_Health_Poor = @yes
    end
    case @iform.Dental_History_Like_Smile
      when true
        @Smile_yes = @yes
      when false
        @Smile_no = @yes
    end
    case @iform.Dental_History_Previous_Dental_Work_Issues
      when true
        @Previous_problems_yes = @yes
      when false
        @Previous_problems_no = @yes
    end
    case @iform.Dental_History_Previous_Orthodontic_Evaluation
      when true
        @Evaluated_yes = @yes
      when false
        @Evaluated_no = @yes
    end
    case @iform.Dental_History_TMJ_TMD_Issues_Current or @iform.Dental_History_TMJ_TMD_Issues_Previous
      when true
        @TMJ_yes = @yes
      when false
        @TMJ_no = @yes
    end
    case @iform.Dental_History_Tobacco_Smoke or @iform.Dental_History_Tobacco_Smokeless
      when true
        @Tobacco_yes = @yes
      when false
        @Tobacco_no = @yes
    end
    case @iform.Dental_History_Ever_Taken_PhenFen_Redux_Pondimin
      when true
        @Phen_Fen_yes = @yes
      when false
        @Phen_Fen_no = @yes
    end
    case @iform.Dental_History_Habits_Mouth_Breather
      when true
        @Mouth_breather_yes = @yes
      when false
        @Mouth_breather_no = @yes
    end
    case @iform.Insurance_Company_Primary_Dental_Coverage
      when true
        @Dentalcoverage_yes = @yes
      when false
        @Dentalcoverage_no = @yes
    end
    case @iform.Insurance_Company_Primary_Orthodontic_Coverage
      when true
        @Orthocoverage_yes = @yes
      when false
        @Orthocoverage_no = @yes
    end
    case @iform.Insurance_Company_Secondary_Dental_Coverage
      when true
        @DentalCoverage_Yes2 = @yes
      when false
        @DentalCoverage_No2 = @yes
    end
    case @iform.Insurance_Company_Secondary_Orthodontic_Coverage
      when true
        @OrthoCoverage_Yes2 = @yes
      when false
        @OrthoCoverage_No2 = @yes
    end
    case @iform.Med_His_Anemia
      when true
        @Anemia_Y = @yes
      when false
        @Anemia_N = @yes
    end
    case @iform.Med_His_Current_Physical_Health
      when "fair"
        @Health_fair = @yes
      when "good"
        @Health_good = @yes
      when "poor"
        @Health_poor = @yes
    end
    case @iform.Med_His_Currently_Taking_Over_The_Counter_Drugs or @iform.Med_His_Currently_Taking_Presc_Drugs
      when true
        @Drugs_yes = @yes
      when false
        @Drugs_no = @yes
    end
    case @iform.Med_His_Personal_Physician
      when true
        @Persdoc_yes = @yes
      when false
        @Persdoc_no = @yes
    end
    case @iform.Med_His_Abnormal_Bleeding
      when true
        @Bleeding_Y = @yes
      when false
        @Bleeding_N = @yes
    end
    case @iform.Med_His_AIDS or @iform.Med_His_HIV_Positive
      when true
        @HIV_Y = @yes
      when false
        @HIV_N = @yes
    end
    case @iform.Med_His_Artificial_Bones_Joints_Valves
      when true
        @Bones_Y = @yes
      when false
        @Bones_N = @yes
    end
    case @iform.Med_His_Asthma
      when true
        @Asthma_Y = @yes
      when false
        @Asthma_N = @yes
    end
    case @iform.Med_His_Blood_Transfusion
      when true
        @Transfusion_Y = @yes
      when false
        @Transfusion_N = @yes
    end
    case @iform.Med_His_Cancer
      when true
        @Cancer_Y = @yes
      when false
        @Cancer_N = @yes
    end
    case @iform.Med_His_Congenital_Heart_Defect
      when true
        @Congenital_Heart_Defect_Y = @yes
      when false
        @Congenital_Heart_Defect_N = @yes
    end
    case @iform.Med_His_Currently_Nursing
      when true
        @Nursing_yes = @yes
      when false
        @Nursing_no = @yes
    end
    case @iform.Med_His_Currently_Pregnant
      when true
        @Pregnant_yes = @yes
      when false
        @Pregnant_no = @yes
    end
    case @iform.Med_His_Currently_Taking_Birth_Control_Pills
      when true
        @Pills_yes = @yes
      when false
        @Pills_no = @yes
    end
    case @iform.Med_His_Currently_Under_The_Care_Of_A_Physician
      when true
        @Physician_yes = @yes
      when false
        @Physician_no = @yes
    end
    case @iform.Med_His_Diabetes
      when true
        @Diabetes_Y = @yes
      when false
        @Diabetes_N = @yes
    end
    case @iform.Med_His_Difficulty_Breathing
      when true
        @Difficulty_Breathing_Y = @yes
      when false
        @Difficulty_Breathing_N = @yes
    end
    case @iform.Med_His_Drug_Abuse
      when true
        @Drug_Abuse_Y = @yes
      when false
        @Drug_Abuse_N = @yes
    end
    case @iform.Med_His_Emphysema
      when true
        @Emphysema_Y = @yes
      when false
        @Emphysema_N = @yes
    end
    case @iform.Med_His_Epilepsy
      when true
        @Epilepsy_Y = @yes
      when false
        @Epilepsy_N = @yes
    end
    case @iform.Med_His_Fever_Blisters
      when true
        @Fever_Blisters_Y = @yes
      when false
        @Fever_Blisters_N = @yes
    end
    case @iform.Med_His_Frequent_Headaches
      when true
        @Headaches_Y = @yes
      when false
        @Headaches_N = @yes
    end
    case @iform.Med_His_Glaucoma
      when true
        @Glaucoma_Y = @yes
      when false
        @Glaucoma_N = @yes
    end
    case @iform.Med_His_Heart_Attack or @iform.Med_His_Stroke
      when true
        @Heart_Attack_Y = @yes
      when false
        @Heart_Attack_N = @yes
    end
    case @iform.Med_His_Heart_Murmur
      when true
        @Heart_Murmur_Y = @yes
      when false
        @Heart_Murmur_N = @yes
    end
    case @iform.Med_His_Heart_Surgery or @iform.Med_His_Pacemaker
      when true
        @Heart_Surgery_Y = @yes
      when false
        @Heart_Surgery_N = @yes
    end
    case @iform.Med_His_Hemophilia
      when true
        @Hemophilia_Y = @yes
      when false
        @Hemophilia_N = @yes
    end
    case @iform.Med_His_Hepatitis
      when true
        @Hepatitis_Y = @yes
      when false
        @Hepatitis_N = @yes
    end
    case @iform.Med_His_High_Blood_Pressure or @iform.Med_His_Low_Blood_Pressure
      when true
        @Blood_Pressure_Y = @yes
      when false
        @Blood_Pressure_N = @yes
    end
    case @iform.Med_His_Hospitalized_For_Any_Reason
      when true
        @Hospitalization_Y = @yes
      when false
        @Hospitalization_N = @yes
    end
    case @iform.Med_His_Kidney_Problems
      when true
        @Kidney_Y = @yes
      when false
        @Kidney_N = @yes
    end
    case @iform.Med_His_Mitral_Valve_Prolapse
      when true
        @MVP_Y = @yes
      when false
        @MVP_N = @yes
    end
    case @iform.Med_His_Psychiatric_Problems
      when true
        @Phychiatric_Y = @yes
      when false
        @Phychiatric_N = @yes
    end
    case @iform.Med_His_Radiation_Treatment
      when true
        @Radiation_Y = @yes
      when false
        @Radiation_N = @yes
    end
    case @iform.Med_His_Rheumatic_Fever or @iform.Med_His_Scarlet_Fever
      when true
        @Rheumatic_Fever_Y = @yes
      when false
        @Rheumatic_Fever_N = @yes
    end
    case @iform.Med_His_Shingles
      when true
        @Shingles_Y = @yes
      when false
        @Shingles_N = @yes
    end
    case @iform.Med_His_Sickle_Cell_Disease or @iform.Med_His_Sickle_Cell_Disease_Traits
      when true
        @Sickle_Cell_Y = @yes
      when false
        @Sickle_Cell_N = @yes
    end
    case @iform.Med_His_Sinus_Problems
      when true
        @Sinus_Y = @yes
      when false
        @Sinus_N = @yes
    end
    case @iform.Med_His_Tuberculosis
      when true
        @TB_Y = @yes
      when false
        @TB_N = @yes
    end
    case @iform.Med_His_Ulcers
      when true
        p "ulcer 1", @Ulcer_Y = @yes
      when false
        p 0, @Ulcers_N = @yes
    end
    case @iform.Med_His_Venereal_Disease
      when true
        @Venereal_Disease_Y = @yes
      when false
        @Venereal_Disease_N = @yes
    end
    p "0000000000000000", @iform.Self_Marital_Status
    case @iform.Self_Marital_Status
      when "divorced"
        @You_Divorced = @yes
      when "married"
        p @You_Married = @yes
      when "separated"
        @You_Separated = @yes
      when "single"
        @You_Single = @yes
      when "widowed"
        @You_Widowed = @yes
    end
    case @iform.Self_Sex
      when "f"
        @You_Female = @yes
      when "m"
        @You_mail = @yes
    end
    if @iform.Dental_History_Breathe_Through_Mouth_While_Asleep == "1"
      @While_Asleep = @yes
    end
    if @iform.Dental_History_Breathe_Through_Mouth_While_Awake == "1"
      @While_Awake = @yes
    end
    if @iform.Dental_History_Injury_To_Chin == "1"
      @Chin = @yes
    end
    if @iform.Dental_History_Injury_To_Mouth == "1"
      @Mouth = @yes
    end
    if @iform.Dental_History_Injury_To_Teeth == "1"
      @Teeth = @yes
    end
  end

  protected
  def adultform_controls_mapping(str, iform)

    pdftkpath = PDFTK_PATH
    pdffilepath = PDFFILES_PATH
    p path = pdffilepath + "#{str}.pdf"
    @pdftk = PdftkForms::Wrapper.new(pdftkpath)

    # @pfields = @pdftk.fields(pdffilepath + 'iform.pdf')
    #   @pfields.each do |pff|
    #     #if pff.name == 'You Female'
    #     #You Female check_box 0 nil Off Yes
    #     # print pff.name, pff.field_type, pff.flags, pff.value, pff.options
    #     #end
    #   end
    formname_split = iform.formname.split(" ")
    if formname_split[2]
      @pdf_form = formname_split[0]+"_"+formname_split[1]+"_"+formname_split[2]
    else
      @pdf_form = formname_split[0]+"_"+formname_split[1]
    end

    @pdftk.fill_form(pdffilepath+"#{@pdf_form}.pdf", path, {
      "Anemia N" => @Anemia_N,
      "Anemia Y" => @Anemia_Y,
      "Anesthetics N" => @Anesthetics_N,
      "Anesthetics Y" => @Anesthetics_Y,
      "Aspirin N" => @Aspirin_N,
      "Aspirin Y" => @Aspirin_Y,
      "Asthma N" => @Asthma_N,
      "Asthma Y" => @Asthma_Y,
      "Bleeding N" => @Bleeding_N,
      "Bleeding Y" => @Bleeding_Y,
      "Blood Pressure N" => @Blood_Pressure_N,
      "Blood Pressure Y" => @Blood_Pressure_Y,
      "Bones N" => @Bones_N,
      "Bones Y" => @Bones_Y,
      "Cancer N" => @Cancer_N,
      "Cancer Y" => @Cancer_Y,
      "Chin" => @Chin,
      "Codeine N" => @Codeine_N,
      "Codeine Y" => @Codeine_Y,
      "Congenital Heart Defect Y" => @Congenital_Heart_Defect_Y,
      "Congenital Heart Defect N" => @Congenital_Heart_Defect_N,
      "Dentalcoverage_no" => @Dentalcoverage_no,
      "DentalCoverage_No2" => @DentalCoverage_No2,
      "Dentalcoverage_yes" => @Dentalcoverage_yes,
      "DentalCoverage_Yes2" => @DentalCoverage_Yes2,
      "Diabetes N" => @Diabetes_N,
      "Diabetes Y" => @Diabetes_Y,
      "Difficulty Breathing N" => @Difficulty_Breathing_N,
      "Difficulty Breathing Y" => @Difficulty_Breathing_Y,
      "Drug Abuse N" => @Drug_Abuse_N,
      "Drug Abuse Y" => @Drug_Abuse_Y,
      "Drugs_no" => @Drugs_no,
      "Drugs_yes" => @Drugs_yes,
      "Emphysema N" => @Emphysema_N,
      "Emphysema Y" => @Emphysema_Y,
      "Epilepsy N" => @Epilepsy_N,
      "Epilepsy Y" => @Epilepsy_Y,
      "Erythromycin N" => @Erythromycin_N,
      "Erythromycin Y" => @Erythromycin_Y,
      "Evaluated_no" => @Evaluated_no,
      "Evaluated_yes" => @Evaluated_yes,
      "Fever Blisters N" => @Fever_Blisters_N,
      "Fever Blisters Y" => @Fever_Blisters_Y,
      "Glaucoma N" => @Glaucoma_N,
      "Glaucoma Y" => @Glaucoma_Y,
      "Gums bleed_no" => @Gums_bleed_no,
      "Gums bleed_yes" => @Gums_bleed_yes,
      "Headaches N" => @Headaches_N,
      "Headaches Y" => @Headaches_Y,
      "Heart Attack N" => @Heart_Attack_N,
      "Heart Attack Y" => @Heart_Attack_Y,
      "Heart Murmur N" => @Heart_Murmur_N,
      "Heart Murmur Y" => @Heart_Murmur_Y,
      "Heart Surgery N" => @Heart_Surgery_N,
      "Heart Surgery Y" => @Heart_Surgery_Y,
      "Hemophilia N" => @Hemophilia_N,
      "Hemophilia Y" => @Hemophilia_Y,
      "Hepatitis N" => @Hepatitis_N,
      "Hepatitis Y" => @Hepatitis_Y,
      "HIV N" => @HIV_N,
      "HIV Y" => @HIV_Y,
      "Hospitalization N" => @Hospitalization_N,
      "Hospitalization Y" => @Hospitalization_Y,
      "Kidney N" => @Kidney_N,
      "Kidney Y" => @Kidney_Y,
      "Latex N" => @Latex_N,
      "Latex Y" => @Latex_Y,
      "Metals N" => @Metals_N,
      "Metals Y" => @Metals_Y,
      "Mouth breather_no" => @Mouth_breather_no,
      "Mouth breather_yes" => @Mouth_breather_yes,
      "Mouth" => @Mouth,
      "MVP N" => @MVP_N,
      "MVP Y" => @MVP_Y,
      "Nursing_no" => @Nursing_no,
      "Nursing_yes" => @Nursing_yes,
      "Orthocoverage_no" => @Orthocoverage_no,
      "OrthoCoverage_No2" => @OrthoCoverage_No2,
      "Orthocoverage_yes" => @Orthocoverage_yes,
      "OrthoCoverage_Yes2" => @OrthoCoverage_Yes2,
      "Other N" => @Other_N,
      "Other Y" => @Other_Y,
      "Penicillin N" => @Penicillin_N,
      "Penicillin Y" => @Penicillin_Y,
      "Persdoc_no" => @Persdoc_no,
      "Persdoc_yes" => @Persdoc_yes,
      "Phen-Fen_no" => @Phen_Fen_no,
      "Phen-Fen_yes" => @Phen_Fen_yes,
      "Phychiatric N" => @Phychiatric_N,
      "Phychiatric Y" => @Phychiatric_Y,
      "Physician_no" => @Physician_no,
      "Physician_yes" => @Physician_yes,
      "Pills_no" => @Pills_no,
      "Pills_yes" => @Pills_yes,
      "Pregnant_no" => @Pregnant_no,
      "Pregnant_yes" => @Pregnant_yes,
      "Previous problems_no" => @Previous_problems_no,
      "Teeth" => @Teeth,
      "While Asleep" => @While_Asleep,
      "While Awake" => @While_Awake,
      "Previous problems_yes" => @Previous_problems_yes,
      "Radiation N" => @Radiation_N,
      "Radiation Y" => @Radiation_Y,
      "Rheumatic Fever N" => @Rheumatic_Fever_N,
      "Rheumatic Fever Y" => @Rheumatic_Fever_Y,
      "Shingles N" => @Shingles_N,
      "Shingles Y" => @Shingles_Y,
      "Sickle Cell N" => @Sickle_Cell_N,
      "Sickle Cell Y" => @Sickle_Cell_Y,
      "Sinus N" => @Sinus_N,
      "Sinus Y" => @Sinus_Y,
      "Smile_no" => @Smile_no,
      "Smile_yes" => @Smile_yes,
      "TB N" => @TB_N,
      "TB Y" => @TB_Y,
      "Teeth_no" => @Teeth_no,
      "Teeth_yes" => @Teeth_yes,
      "Tetracycline N" => @Tetracycline_N,
      "Tetracycline Y" => @Tetracycline_Y,
      "TMJ_no" => @TMJ_no,
      "TMJ_yes" => @TMJ_yes,
      "Tobacco_no" => @Tobacco_no,
      "Tobacco_yes" => @Tobacco_yes,
      "Transfusion N" => @Transfusion_N,
      "Transfusion Y" => @Transfusion_Y,
      "Ulcers Y" => @Ulcer_Y,
      "Ulcers N" => @Ulcers_N,
      "Venereal Disease N" => @Venereal_Disease_N,
      "Venereal Disease Y" => @Venereal_Disease_Y,
      "You Female" => @You_Female,
      "You mail" => @You_mail,
      "Dental Health_fair" => @Dental_Health_fair,
      "Dental Health_good" => @Dental_Health_good,
      "Dental Health_Poor" => @Dental_Health_Poor,
      "Health_fair" => @Health_fair,
      "Health_good" => @Health_good,
      "Health_poor" => @Health_poor,
      "You Divorced" => @You_Divorced,
      "You Married" => @You_Married,
      "You Separated" => @You_Separated,
      "You Single" => @You_Single,
      "You Widowed" => @You_Widowed,
      "Allergic" => @Allergic,
      "Any serious medical conditions" => @Any_serious_medical_conditions,
      "Any speech problems" => @Any_speech_problems,
      "Are you taking any prescription  over-the-counter drugs" => @Please_list_all_drugs_that_your_child_is_currently_taking,
      "Billing Address" => @Billing_Address,
      "Date of last visit" => @Date_of_last_visit,
      "emergency_phone_hm" => @emergency_phone_hm,
      "emergency_phone_wk" => @emergency_phone_wk,
      "General Dentist" => @General_Dentist,
      "Group #  Plan, Local or Policy" => @Group_Plan_Local_or_Policy,
      "Group # Plan, Local or Policy2" => @Group_Plan_Local_or_Policy2,
      "His  Her Name_2" => @His_Her_Name_2,
      "Hm_areacode" => @Hm_areacode,
      "How long there" => @How_long_there,
      "I prefer to be called" => @I_prefer_to_be_called,
      "Ins_Relation_2" => @Ins_Relation_2,
      "InsBday_1" => @InsBday_1,
      "Insurance Co Address" => @Insurance_Co_Address,
      "Insurance Co Address_2" => @Insurance_Co_Address_2,
      "Insurance Co AreaCode" => @Insurance_Co_AreaCode,
      "Insurance Co Areacode_2" => @Insurance_Co_Areacode_2,
      "Insurance Co Name" => @Insurance_Co_Name,
      "Insurance Co Name_2" => @Insurance_Co_Name_2,
      "Insurance Co. Phone" => @Insurance_Co_Phone,
      "Insurance Co. Phone2" => @Insurance_Co_Phone2,
      "Insureds Employer" => @Insured_8217_s_Employer_1,
      "Insureds Employer_2" => @Insured_8217_s_Employer_2,
      "Insureds Name" => @Insured_8217_s_Name,
      "Insureds Name_2" => @Insured_8217_s_Name_2,
      "Insureds SS" => @Insured_8217_s_SS,
      "Insureds SS_2" => @Insured_8217_s_SS_2,
      "InsuredBday_" => @InsuredBday_2,
      "Last Visit Date" => @Last_Visit_Date,
      "Name" => @Name,
      "Occupation" => @Occupation,
      "Other family members seen by us" => @Other_family_members_seen_by_us,
      "Person Responsible for Account" => @Person_Responsible_for_Account,
      "Physician_areacode" => @Physician_areacode,
      "Physician_phone" => @Physician_phone,
      "Physicians Name" => @Physician_8217_s_Name,
      "Please explain" => @Please_explain,
      "Relation" => @Relation,
      "Relation_3" => @Relation_3,
      "Relation_4" => @Relation_4,
      "RespPerson_DL" => @RespPerson_DL,
      "RespPerson_Employer" => @RespPerson_Employer,
      "RespPerson_SS" => @RespPerson_SS,
      "RespPersonHm" => @RespPersonHm,
      "RespPersonHmAreacode" => @RespPersonHmAreacode,
      "RespPersonWk" => @RespPersonWk,
      "RespPersonWk_areacode" => @RespPersonWk_areacode,
      "RespPersonWkExt" => @RespPersonWkExt,
      "Spouse Birthdate" => @Spouse_Birthdate,
      "Spouse Employer" => @Spouse_Employer,
      "Spouse Name" => @Spouse_Name,
      "Spouse Wk Area Code" => @Spouse_Wk_Area_Code,
      "Spouse Wk Ext" => @Spouse_Wk_Ext,
      "Spouse Wk Phone" => @Spouse_Wk_Phone,
      "SpouseSS" => @SpouseSS,
      "Todays Date" => @Today_8217_s_Date,
      "Week#" => @Week,
      "What do you want" => @What_do_you_want,
      "When taken Phen-Fen" => @When_taken_Phen_Fen,
      "Where and when are best times to reach you" => @Where_amp_when_are_best_times_to_reach_you,
      "Whom may we Thank for referring you" => @Whom_may_we_Thank_for_referring_you,
      "Wk_areacode" => @Wk_areacode,
      "You Age" => @You_Age,
      "You Birthdate" => @You_Birthdate,
      "You City" => @You_City,
      "You Drivers License" => @You_Drivers_License,
      "You Employer" => @You_Employer,
      "You Employers Address" => @You_Employer_8217_s_Address,
      "You Ext" => @You_Ext,
      "You Hm" => @You_Hm,
      "You Hm Area Code" => @You_Hm_Area_Code,
      "You Home Address" => @You_Home_Address,
      "You Pager Other" => @You_Pager_Other,
      "You SS" => @You_SS,
      "You State" => @You_State,
      "You Wk" => @You_Wk,
      "You Wk Area Code" => @You_Wk_Area_Code,
      "You Zip" => @You_Zip,
      "Your E-Mail Address" => @Your_EMail_Address
    })
    iform_file = File.new(path, 'rb')
    iform.pdffile_path = iform_file.read()
    iform.save

    File.delete(path)
  end

  protected
  def childform_control_conditions(iform)
    @iform = iform
    @yes = "Yes"

    @Appt_ext = @iform.Person_Responsible_For_Making_Appointments_Phone_Work_Extension
    if !@iform.Person_Responsible_For_Making_Appointments_Phone_Work.blank? and @iform.Person_Responsible_For_Making_Appointments_Phone_Work.length == 10
      @Appt_phone = @iform.Person_Responsible_For_Making_Appointments_Phone_Work.slice(3, 3) + "-" + @iform.Person_Responsible_For_Making_Appointments_Phone_Work.slice(6, 4)
      @Appt_area_code = @iform.Person_Responsible_For_Making_Appointments_Phone_Work.slice(0, 3)
    end
    if !@iform.Person_Responsible_For_Making_Appointments_Phone_Home.blank? and @iform.Person_Responsible_For_Making_Appointments_Phone_Home.length == 10
      @Appt_phone_2 = @iform.Person_Responsible_For_Making_Appointments_Phone_Home.slice(3, 3) + "-" + @iform.Person_Responsible_For_Making_Appointments_Phone_Home.slice(6, 4)
      @Appt_area_code_2 = @iform.Person_Responsible_For_Making_Appointments_Phone_Home.slice(0, 3)
    end
    if !@iform.Person_Responsible_For_Account_Address2.empty?
      @Billing_Address_1 = @iform.Person_Responsible_For_Account_Address1 + ", " + @iform.Person_Responsible_For_Account_Address2
    else
      @Billing_Address_1 = @iform.Person_Responsible_For_Account_Address1
    end
    @Billing_City_2 = @iform.Person_Responsible_For_Account_City
    @Billing_State_2 = @iform.Person_Responsible_For_Account_State
    @Billing_Zipcode_2 = @iform.Person_Responsible_For_Account_Postal_Code
    if !@iform.Self_Home_Address2.empty?
      @Child_Address = @iform.Self_Home_Address1 + ", " + @iform.Self_Home_Address2
    else
      @Child_Address = @iform.Self_Home_Address1
    end
    unless @iform.Self_Birthdate.blank?
      @Child_Bday = @iform.Self_Birthdate.strftime("%m-%d-%Y")
    end
    @Child_CITY = @iform.Self_Home_City
    @Child_EMail_Address = @iform.Self_Email_Address
    @CHILD_FIRST = @iform.Self_Name_Last + ", " + @iform.Self_Name_First + " " + @iform.Self_Name_Middle
    @Child_Grade = @iform.Self_Grade
    @Child_Hobbies = @iform.Self_Hobbies
    @Child_Nickname = @iform.Self_Name_Preferred
    if !@iform.Self_Phone_Home.blank? and @iform.Self_Phone_Home.length == 10
      @Child_phone = @iform.Self_Phone_Home.slice(3, 3)+"-"+@iform.Self_Phone_Home.slice(6, 4)
      @Child_area_code = @iform.Self_Phone_Home.slice(0, 3)
    end
    @Child_School = @iform.Self_School
    if !@iform.Self_Social_Security_Number.blank? and @iform.Self_Social_Security_Number.length == 9
      @Child_SS = @iform.Self_Social_Security_Number.slice(0, 3)+"-"+@iform.Self_Social_Security_Number.slice(3, 2)+"-"+@iform.Self_Social_Security_Number.slice(5, 4)
    end
    @Child_STATE = @iform.Self_Home_State
    @Child_Zip = @iform.Self_Home_Postal_Code
    @Childs_Physician = @iform.Med_His_Personal_Physician_Name_First+" "+@iform.Med_His_Personal_Physician_Name_Last
    if !@iform.Med_His_Personal_Physician_Phone.blank? and @iform.Med_His_Personal_Physician_Phone.length == 10
      @Childs_Physician_phone = @iform.Med_His_Personal_Physician_Phone.slice(3, 3)+"-"+@iform.Med_His_Personal_Physician_Phone.slice(6, 4)
      @Childs_Physician_area_code = @iform.Med_His_Personal_Physician_Phone.slice(0, 3)
    end
    if !@iform.Father_Phone_Work.blank? and @iform.Father_Phone_Work.length == 10
      @Dad_area_code_1 = @iform.Father_Phone_Work.slice(0, 3)
      @Dad_phone_1 = @iform.Father_Phone_Work.slice(3, 3)+"-"+@iform.Father_Phone_Work.slice(6, 4)
    end
    unless @iform.Father_Birthdate.blank?
      @Dad_Bday = @iform.Father_Birthdate.strftime("%m-%d-%Y")
    end
    @Dad_DL_2 = @iform.Father_Drivers_License_State+" "+@iform.Father_Drivers_License_Number
    @Dad_employer = @iform.Father_Employer_Name
    @Dad_ext = @iform.Father_Phone_Work_Extension
    @Dad_How_Long_at_Current_Job_2 = @iform.Father_Length_Of_Employment
    @Dad_Job_Title_2 = @iform.Father_Job_Title
    @Dad_Name_3 = @iform.Father_Name_First+" "+@iform.Father_Name_Middle+" "+@iform.Father_Name_Last
    if !@iform.Father_Phone_Home.blank? and @iform.Father_Phone_Home.length == 10
      @Dad_area_code_2 = @iform.Father_Phone_Home.slice(0, 3)
      @Dad_phone_2 = @iform.Father_Phone_Home.slice(3, 3)+"-"+@iform.Father_Phone_Home.slice(6, 4)
    end
    if !@iform.Father_Social_Security_Number.blank? and @iform.Father_Social_Security_Number.length == 9
      @Dad_SS_3 = @iform.Father_Social_Security_Number.slice(0, 3) + "-" + @iform.Father_Social_Security_Number.slice(3, 2) + "-" + @iform.Father_Social_Security_Number.slice(5, 4)
    end
    unless @iform.Med_His_Personal_Physician_Date_Of_Last_Visit.blank?
      @Date_of_last_visit = @iform.Med_His_Personal_Physician_Date_Of_Last_Visit.strftime("%m-%d-%Y")
    end
    if !@iform.Neighbor_Or_Relative_Not_Living_With_You_Address2.empty?
      @Friend_Address = @iform.Neighbor_Or_Relative_Not_Living_With_You_Address1+ ", " +@iform.Neighbor_Or_Relative_Not_Living_With_You_Address2
    else
      @Friend_Address = @iform.Neighbor_Or_Relative_Not_Living_With_You_Address1
    end
    @Friend_City = @iform.Neighbor_Or_Relative_Not_Living_With_You_City
    @Friend_Name = @iform.Neighbor_Or_Relative_Not_Living_With_You_Name_First+ " " +@iform.Neighbor_Or_Relative_Not_Living_With_You_Name_Middle + " " + @iform.Neighbor_Or_Relative_Not_Living_With_You_Name_Last
    if !@iform.Neighbor_Or_Relative_Not_Living_With_You_Phone.blank? and @iform.Neighbor_Or_Relative_Not_Living_With_You_Phone.length == 10
      @Friend_area_code = @iform.Neighbor_Or_Relative_Not_Living_With_You_Phone.slice(0, 3)
      @Friend_phone = @iform.Neighbor_Or_Relative_Not_Living_With_You_Phone.slice(3, 3) + "-" + @iform.Neighbor_Or_Relative_Not_Living_With_You_Phone.slice(6, 4)
    end
    @Friend_State = @iform.Neighbor_Or_Relative_Not_Living_With_You_State
    @Friend_Zip = @iform.Neighbor_Or_Relative_Not_Living_With_You_Postal_Code
    @General_Dentist = @iform.Self_General_Dentist_Name
    @Ins_Co_1 = @iform.Insurance_Company_Primary_Name
    @Ins_Co_1_Group = @iform.Insurance_Company_Primary_Group_Plan_Local_Policy_Number
    @Ins_Co_1_Name = @iform.Insurance_Company_Primary_Insured_Name_First + " " + @iform.Insurance_Company_Primary_Insured_Name_Last
    if !@iform.Insurance_Company_Primary_Phone.blank? and @iform.Insurance_Company_Primary_Phone.length == 10
      @Ins_Co_1_area_code = @iform.Insurance_Company_Primary_Phone.slice(0, 3)
      @Ins_Co_1_phone = @iform.Insurance_Company_Primary_Phone.slice(3, 3) + "-" + @iform.Insurance_Company_Primary_Phone.slice(6, 4)
    end
    @Ins_Co_1_Relationship = @iform.Insurance_Company_Primary_Insured_Relationship
    @Ins_Co_2 = @iform.Insurance_Company_Secondary_Name
    @Ins_Co_Address_1 = @iform.Insurance_Company_Primary_Address1 + " " + @iform.Insurance_Company_Primary_Address2 + " " + @iform.Insurance_Company_Primary_City + " " + @iform.Insurance_Company_Primary_State + " " + @iform.Insurance_Company_Primary_Postal_Code
    @Ins_Co_Address_2 = @iform.Insurance_Company_Secondary_Address1 + " " + @iform.Insurance_Company_Secondary_Address2 + " " + @iform.Insurance_Company_Secondary_City + " " + @iform.Insurance_Company_Secondary_State + " " + @iform.Insurance_Company_Secondary_Postal_Code
    if !@iform.Insurance_Company_Secondary_Phone.blank? and @iform.Insurance_Company_Secondary_Phone.length == 10
      @Ins_Co_2__area_code = @iform.Insurance_Company_Secondary_Phone.slice(0, 3)
      @Ins_Co_Phone_2 = @iform.Insurance_Company_Secondary_Phone.slice(3, 3) + "-" + @iform.Insurance_Company_Secondary_Phone.slice(6, 4)
    end
    @Instruments_played = @iform.Dental_History_Play_Musical_Instruments
    unless @iform.Insurance_Company_Primary_Insured_Birthdate.blank?
      @Insured_1_Bday = @iform.Insurance_Company_Primary_Insured_Birthdate.strftime("%m-%d-%Y")
    end
    unless @iform.Self_General_Dentist_Date_Last_Appointment.blank?
      @Last_Dental_Date = @iform.Self_General_Dentist_Date_Last_Appointment.strftime("%m-%d-%Y")
    end
    @List_brothers__sisters_with_age_2 = @iform.Accompanying_Your_Child_Today_Siblings_And_Ages
    @Main_concerns = @iform.Dental_History_Orthodontic_Goals
    if !@iform.Mother_Phone_Work.blank? and @iform.Mother_Phone_Work.length == 10
      @Mom_area_code_1 = @iform.Mother_Phone_Work.slice(0, 3)
      @Mom_phone_1 = @iform.Mother_Phone_Work.slice(3, 3) + "-" + @iform.Mother_Phone_Work.slice(6, 4)
    end
    if !@iform.Mother_Phone_Home.blank? and @iform.Mother_Phone_Home.length == 10
      @Mom_area_code_2 = @iform.Mother_Phone_Home.slice(0, 3)
      @Mom_phone_2 = @iform.Mother_Phone_Home.slice(3, 3) + "-" + @iform.Mother_Phone_Home.slice(6, 4)
    end
    @Mom_DL = @iform.Mother_Drivers_License_State + " " + @iform.Mother_Drivers_License_Number
    @Mom_employer = @iform.Mother_Employer_Name
    @Mom_ext = @iform.Mother_Phone_Work_Extension
    @Mom_How_Long_at_Current_Job = @iform.Mother_Length_Of_Employment
    @Mom_Job_Title = @iform.Mother_Job_Title
    if !@iform.Mother_Social_Security_Number.blank? and @iform.Mother_Social_Security_Number.length == 9
      @Mom_SS_2 = @iform.Mother_Social_Security_Number.slice(0, 3) + "-" + @iform.Mother_Social_Security_Number.slice(3, 2) + "-" + @iform.Mother_Social_Security_Number.slice(5, 4)
    end
    unless @iform.Mother_Birthdate.blank?
      @Mother_BDay = @iform.Mother_Birthdate.strftime("%m-%d-%Y")
    end
    @Mother_Name_2 = @iform.Mother_Name_First + " " + @iform.Mother_Name_Middle + " " + @iform.Mother_Name_Last
    @My_method_of_payment_will_be = @iform.Person_Responsible_For_Account_Payment_Method
    @Please_discuss_any_medical_problems_that_your_child_has_had_3 = @iform.Med_His_Medical_Problems
    if !@iform.Med_His_Currently_Taking_Presc_Drugs_List.empty? and !@iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List.empty?
      @Please_list_all_drugs_that_your_child_is_currently_taking = @iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List+", "+@iform.Med_His_Currently_Taking_Presc_Drugs_List
    elsif @iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List.empty?
      @Please_list_all_drugs_that_your_child_is_currently_taking = @iform.Med_His_Currently_Taking_Presc_Drugs_List
    else
      @Please_list_all_drugs_that_your_child_is_currently_taking = @iform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List
    end

    @Please_list_all_drugsthings_that_your_child_is_allergic_to = @iform.Allergic_To_Drugs_List
    if !@iform.Insurance_Company_Primary_Insured_Social_Security_Number.blank? and @iform.Insurance_Company_Primary_Insured_Social_Security_Number.length == 9
      @Policy_1_SS = @iform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(0, 3) + "-" + @iform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(3, 2) + "-" + @iform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(5, 4)
    end
    @Policy_Owners_Employer_1 = @iform.Insurance_Company_Primary_Insured_Employer_Name
    if !@iform.Person_Responsible_For_Account_Previous_Address2.empty?
      @Previous_Address_1 = @iform.Person_Responsible_For_Account_Previous_Address1 + ", " + @iform.Person_Responsible_For_Account_Previous_Address2
    else
      @Previous_Address_1 = @iform.Person_Responsible_For_Account_Previous_Address1
    end
    @Previous_Address_State = @iform.Person_Responsible_For_Account_Previous_State
    @Previous_City = @iform.Person_Responsible_For_Account_Previous_City
    @Previous_Zip = @iform.Person_Responsible_For_Account_Previous_Postal_Code
    @Relation = @iform.Accompanying_Your_Child_Today_Relationship
    @Relation_Name = @iform.Accompanying_Your_Child_Today_Name_First+" "+@iform.Accompanying_Your_Child_Today_Name_Last
    @Relationsip_to_Patient_2 = @iform.Insurance_Company_Secondary_Insured_Relationship
    @Responsible_DL = @iform.Person_Responsible_For_Account_Drivers_License_State + " " + @iform.Person_Responsible_For_Account_Drivers_License_Number
    @Responsible_Employer = @iform.Person_Responsible_For_Account_Employer_Name
    @Responsible_ext = @iform.Person_Responsible_For_Account_Phone_Work_Extension
    @Responsible_Name = @iform.Person_Responsible_For_Account_Name_First + " " + @iform.Person_Responsible_For_Account_Name_Middle + " " + @iform.Person_Responsible_For_Account_Name_Last
    @Responsible_Person_to_make_Appointments = @iform.Person_Responsible_For_Making_Appointments_Name_First + " " + @iform.Person_Responsible_For_Making_Appointments_Name_Middle + " " + @iform.Person_Responsible_For_Making_Appointments_Name_Last
    if !@iform.Person_Responsible_For_Account_Phone_Home.blank? and @iform.Person_Responsible_For_Account_Phone_Home.length == 10
      @Responsible_area_code = @iform.Person_Responsible_For_Account_Phone_Home.slice(0, 3)
      @Responsible_phone = @iform.Person_Responsible_For_Account_Phone_Home.slice(3, 3) + "-" + @iform.Person_Responsible_For_Account_Phone_Home.slice(6, 4)
    end
    if !@iform.Person_Responsible_For_Account_Phone_Work.blank? and @iform.Person_Responsible_For_Account_Phone_Work.length == 10
      @Responsible_area_code_work = @iform.Person_Responsible_For_Account_Phone_Work.slice(0, 3)
      @Responsible_phone_work = @iform.Person_Responsible_For_Account_Phone_Work.slice(3, 3) + "-" + @iform.Person_Responsible_For_Account_Phone_Work.slice(6, 4)
    end
    @Responsible_Relation = @iform.Person_Responsible_For_Account_Relationship
    if !@iform.Person_Responsible_For_Account_Social_Security_Number.blank? and @iform.Person_Responsible_For_Account_Social_Security_Number.length == 9
      @Responsible_SS = @iform.Person_Responsible_For_Account_Social_Security_Number.slice(0, 3) + "-" + @iform.Person_Responsible_For_Account_Social_Security_Number.slice(3, 2) + "-" + @iform.Person_Responsible_For_Account_Social_Security_Number.slice(5, 4)
    end
    unless @iform.Insurance_Company_Secondary_Insured_Birthdate.blank?
      @Secondary_Ins_Birthdate = @iform.Insurance_Company_Secondary_Insured_Birthdate.strftime("%m-%d-%Y")
    end
    @Secondary_Ins_Employer_2 = @iform.Insurance_Company_Secondary_Insured_Employer_Name
    @Secondary_Ins_Group__2 = @iform.Insurance_Company_Secondary_Group_Plan_Local_Policy_Number
    @Secondary_Ins_Name_2 = @iform.Insurance_Company_Secondary_Insured_Name_First + " " + @iform.Insurance_Company_Secondary_Insured_Name_Last
    if !@iform.Insurance_Company_Secondary_Insured_Social_Security_Number.blank? and @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.length == 9
      @Secondary_Ins_SS = @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(0, 3) + "-" + @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(3, 2) + "-" + @iform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(5, 4)
    end
    @Todays_Date = @iform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider.strftime("%m-%d-%Y")
    @Whom_may_we_Thank_for_referring_you = @iform.Self_Referred_By

    case @iform.Accompanying_Your_Child_Today_Has_Legal_Custody_Of_Child
      when true
        @Custody_Yes = @yes
      when false
        @Custody_No = @yes
    end

    case @iform.Allergic_To_Any_Drugs
      when true
        @Drug_Allergies_Y = @yes
      when false
        @Drug_Allergies_N = @yes
    end

    case @iform.Allergic_To_Latex or @iform.Allergic_To_Metals
      when true
        @Latex_Allergies_Y = @yes
      when false
        @Latex_Allergies_N = @yes
    end

    case @iform.Allergic_To_Plastics
      when true
        @Plastic_Allergies_Y = @yes
      when false
        @Plastic_Allergies_N = @yes
    end

    case @iform.Dental_History_Any_Extra_Permanent_Teeth or @iform.Dental_History_Any_Missing_Teeth
      when true
        @Teeth__Yes = @yes
      when false
        @Teeth__No = @yes
    end

    case @iform.Dental_History_Brush_Teeth_Daily
      when true
        @Brush__Yes = @yes
      when false
        @Brush__No = @yes
    end

    case @iform.Dental_History_Floss_Teeth_Daily
      when true
        @Floss__Yes = @yes
      when false
        @Floss__No = @yes
    end

    case @iform.Dental_History_Injury_To_Chin or @iform.Dental_History_Injury_To_Face or @iform.Dental_History_Injury_To_Mouth or @iform.Dental_History_Injury_To_Teeth
      when true
        @Injuries__Yes = @yes
      when false
        @Injuries__No = @yes
    end

    case @iform.Dental_History_Previous_Orthodontic_Evaluation or @iform.Dental_History_Previous_Orthodontic_Treatment
      when true
        @Treated_before__Yes = @yes
      when false
        @Treated_before__No = @yes
    end

    case @iform.Dental_History_TMJ_TMD_Issues_Current or @iform.Dental_History_TMJ_TMD_Issues_Previous
      when true
        @TMJ__Yes = @yes
      when false
        @TMJ__No = @yes
    end

    case @iform.Dental_History_Tonsils_Removed
      when true
        @Tonsils__Yes = @yes
      when false
        @Tonsils__No = @yes
    end

    case @iform.Father_Stepfather_Or_Gaurdian
      when "guardian"
        @Guardian = @yes
      when "stepfather"
        @Step_Father = @yes
    end

    case @iform.Habits_Bottle or @iform.Habits_Nursing
      when true
        @Bottle_Y = @yes
      when false
        @Bottle_N = @yes
    end

    case @iform.Habits_Breast_Fed
      when true
        @Breast_Fed_Y = @yes
      when false
        @Breast_Fed_N = @yes
    end

    case @iform.Habits_Clenching_Or_Grinding_Teeth
      when true
        @Grinding_Y = @yes
      when false
        @Grinding_N = @yes
    end

    case @iform.Habits_Lip_Sucking_Or_Biting
      when true
        @Lip_Y = @yes
      when false
        @Lip_N = @yes
    end

    case @iform.Habits_Mouth_Breather
      when true
        @Mouth_Breather_Y = @yes
      when false
        @Mouth_Breather_N = @yes
    end

    case @iform.Habits_Nail_Biting
      when true
        @Nail_Biting_Y = @yes
      when false
        @Nail_Biting_N = @yes
    end

    case @iform.Habits_Speech_Problems
      when true
        @Speech_Y = @yes
      when false
        @Speech_N = @yes
    end

    case @iform.Habits_Thumb_Or_Finger_Sucking
      when true
        @Thumb_Y = @yes
      when false
        @THumb_N = @yes
    end

    case @iform.Habits_Tongue_Thrust
      when true
        @Tongue_Thrust_Y = @yes
      when false
        @Tongue_Thrust_N = @yes
    end

    case @iform.Insurance_Company_Primary_Dental_Coverage
      when true
        @Dentalcoverage_yes = @yes
      when false
        @Dentalcoverage_no = @yes
    end

    case @iform.Insurance_Company_Primary_Orthodontic_Coverage
      when true
        @Orthocoverage_yes = @yes
      when false
        @Orthocoverage_no = @yes
    end

    case @iform.Insurance_Company_Secondary_Dental_Coverage
      when true
        @Dental_2_Yes = @yes
      when false
        @Dental_2_No = @yes
    end

    case @iform.Insurance_Company_Secondary_Orthodontic_Coverage
      when true
        @Ortho_2_Yes = @yes
      when false
        @Ortho_2_No = @yes
    end

    case @iform.Med_His_Abnormal_Bleeding
      when true
        @Bleeding_Y = @yes
      when false
        @Bleeding_N = @yes
    end

    case @iform.Med_His_ADD or @iform.Med_His_ADHD
      when true
        @ADHD_Y = @yes
      when false
        @ADHD_N = @yes
    end

    case @iform.Med_His_AIDS or @iform.Med_His_HIV_Positive
      when true
        @HIV_Y = @yes
      when false
        @HIV_N = @yes
    end

    case @iform.Med_His_Any_Operations
      when true
        @Operations_Y = @yes
      when false
        @Operations_N = @yes
    end

    case @iform.Med_His_Artificial_Bones_Joints_Valves
      when true
        @Bones_Y = @yes
      when false
        @Bones_N = @yes
    end

    case @iform.Med_His_Asthma
      when true
        @Asthma_Y = @yes
      when false
        @Asthma_N = @yes
    end

    case @iform.Med_His_Cancer
      when true
        @Cancer_Y = @yes
      when false
        @Cancer_N = @yes
    end

    case @iform.Med_His_Congenital_Heart_Defect
      when true
        @Congenital_Heart_Defect_Y = @yes
      when false
        @Congenital_Heart_Deffect_N = @yes
    end

    case @iform.Med_His_Current_Physical_Health
      when "fair"
        @Health_Fair = @yes
      when "good"
        @Health_Good = @yes
      when "poor"
        @Health_Poor = @yes
    end

    case @iform.Med_His_Currently_Under_The_Care_Of_A_Physician
      when true
        @Dr__Yes = @yes
      when false
        @Dr__No = @yes
    end

    case @iform.Med_His_Diabetes
      when true
        @Diabetes_Y = @yes
      when false
        @Diabetes_N = @yes
    end

    case @iform.Med_His_Epilepsy
      when true
        @Epilepsy_Y = @yes
      when false
        @Epilepsy_N = @yes
    end

    case @iform.Med_His_Handicaps_Or_Disabilities
      when true
        @Handicaps_Y = @yes
      when false
        @Handicaps_N = @yes
    end

    case @iform.Med_His_Hearing_Impairment
      when true
        @Hearing_Y = @yes
      when false
        @Hearing_N = @yes
    end

    case @iform.Med_His_Heart_Murmur
      when true
        @Heart_Murmur_Y = @yes
      when false
        @Heart_Murmur_N = @yes
    end

    case @iform.Med_His_Hemophilia
      when true
        @Hemophilia_Y = @yes
      when false
        @Hemophilia_N = @yes
    end

    case @iform.Med_His_Hepatitis
      when true
        @Hepatitis_Y = @yes
      when false
        @Hepatitis_N = @yes
    end

    case @iform.Med_His_Hospitalized_For_Any_Reason
      when true
        @Hospital_Y = @yes
      when false
        @Hospital_N = @yes
    end

    case @iform.Med_His_Kidney_Problems
      when true
        @Kidney_Y = @yes
      when false
        @Kidney_N = @yes
    end

    case @iform.Med_His_Liver_Problems
      when true
        @Liver_Y = @yes
      when false
        @Liver_N = @yes
    end

    case @iform.Med_His_Lupus
      when true
        @Lupus_Y = @yes
      when false
        @Lupus_N = @yes
    end

    case @iform.Med_His_Menstruation_Begun
      when true
        @Menstruation__Yes = @yes
      when false
        @Menstruation__No = @yes
    end

    case @iform.Med_His_Puberty_Begun
      when true
        @Puberty__Yes = @yes
      when false
        @Puberty_No = @yes
    end

    case @iform.Med_His_Rheumatic_Fever or @iform.Med_His_Scarlet_Fever
      when true
        @Rheumatic_Fever_Y = @yes
      when false
        @Rheumatic_Fever_N = @yes
    end

    case @iform.Med_His_Sickle_Cell_Disease or @iform.Med_His_Sickle_Cell_Disease_Traits
      when true
        @Sickle_Cell_Y = @yes
      when false
        @Sickle_Cell_N = @yes
    end

    case @iform.Med_His_Tuberculosis
      when true
        @TB_Y = @yes
      when false
        @TB_N = @yes
    end

    case @iform.Mother_Stepmother_Or_Gaurdian
      when "guardian"
        @Guaradian = @yes
      when "stepmother"
        @Step_Mother = @yes
    end

    case @iform.Self_Marital_Status
      when "divorced"
        @Divorced = @yes
      when "married"
        @Married = @yes
      when "separated"
        @Separated = @yes
      when "single"
        @SIngle = @yes
      when "widowed"
        @Widowed = @yes
    end

    case @iform.Self_Sex
      when "m"
        @Child_Male = @yes
      when "f"
        @Child_Female = @yes
    end
  end

  protected
  def childform_controls_mapping(str, iform)
    pdftkpath = PDFTK_PATH
    pdffilepath = PDFFILES_PATH
    path = pdffilepath + "#{str}.pdf"
    @pdftk = PdftkForms::Wrapper.new(pdftkpath)
    formname_split = iform.formname.split(" ")
    if formname_split[2]
      @pdf_form = formname_split[0]+"_"+formname_split[1]+"_"+formname_split[2]
    else
      @pdf_form = formname_split[0]+"_"+formname_split[1]
    end

    @pdftk.fill_form(pdffilepath+"#{@pdf_form}.pdf", path, {
      "ADHD N" => @ADHD_N,
      "ADHD Y" => @ADHD_Y,
      "Appt area code 2" => @Appt_area_code_2,
      "Appt area code" => @Appt_area_code,
      "Appt ext" => @Appt_ext,
      "Appt phone 2" => @Appt_phone_2,
      "Appt phone" => @Appt_phone,
      "Asthma N" => @Asthma_N,
      "Asthma Y" => @Asthma_Y,
      "Billing Address 1" => @Billing_Address_1,
      "Billing City 2" => @Billing_City_2,
      "Billing State 2" => @Billing_State_2,
      "Billing Zipcode 2" => @Billing_Zipcode_2,
      "Bleeding N" => @Bleeding_N,
      "Bleeding Y" => @Bleeding_Y,
      "Bones N" => @Bones_N,
      "Bones Y" => @Bones_Y,
      "Bottle N" => @Bottle_N,
      "Bottle Y" => @Bottle_Y,
      "Breast Fed N" => @Breast_Fed_N,
      "Breast Fed Y" => @Breast_Fed_Y,
      "Brush - No" => @Brush__No,
      "Brush - Yes" => @Brush__Yes,
      "Cancer N" => @Cancer_N,
      "Cancer Y" => @Cancer_Y,
      "Child Address" => @Child_Address,
      "Child area code" => @Child_area_code,
      "Child Bday" => @Child_Bday,
      "Child CITY" => @Child_CITY,
      "Child E-Mail Address" => @Child_EMail_Address,
      "Child Female" => @Child_Female,
      "CHILD FIRST" => @CHILD_FIRST,
      "Child Grade" => @Child_Grade,
      "Child Hobbies" => @Child_Hobbies,
      "Child Male" => @Child_Male,
      "Child Nickname" => @Child_Nickname,
      "Child phone" => @Child_phone,
      "Child School" => @Child_School,
      "Child SS" => @Child_SS,
      "Child STATE" => @Child_STATE,
      "Child Zip" => @Child_Zip,
      "Child's Physician phone" => @Childs_Physician_phone,
      "Child's Physician" => @Childs_Physician,
      "Childs Age" => @You_Age,
      "Childs Physician area code" => @Childs_Physician_area_code,
      "Congenital Heart Defect Y" => @Congenital_Heart_Defect_Y,
      "Congenital Heart Deffect N" => @Congenital_Heart_Deffect_N,
      "Custody No" => @Custody_No,
      "Custody Yes" => @Custody_Yes,
      "Dad area code 1" => @Dad_area_code_1,
      "Dad area code 2" => @Dad_area_code_2,
      "Dad Bday" => @Dad_Bday,
      "Dad DL_2" => @Dad_DL_2,
      "Dad employer" => @Dad_employer,
      "Dad ext" => @Dad_ext,
      "Dad How Long at Current Job_2" => @Dad_How_Long_at_Current_Job_2,
      "Dad Job Title_2" => @Dad_Job_Title_2,
      "Dad Name_3" => @Dad_Name_3,
      "Dad phone 1" => @Dad_phone_1,
      "Dad phone 2" => @Dad_phone_2,
      "Dad SS_3" => @Dad_SS_3,
      "Date of Last Visit" => @Date_of_last_visit,
      "Dental_2 No" => @Dental_2_No,
      "Dental_2 Yes" => @Dental_2_Yes,
      "Dentalcoverage_no" => @Dentalcoverage_no,
      "Dentalcoverage_yes" => @Dentalcoverage_yes,
      "Diabetes N" => @Diabetes_N,
      "Diabetes Y" => @Diabetes_Y,
      "Divorced" => @Divorced,
      "Dr - No" => @Dr__No,
      "Dr - Yes" => @Dr__Yes,
      "Drug Allergies N" => @Drug_Allergies_N,
      "Drug Allergies Y" => @Drug_Allergies_Y,
      "Epilepsy N" => @Epilepsy_N,
      "Epilepsy Y" => @Epilepsy_Y,
      "Floss - No" => @Floss__No,
      "Floss - Yes" => @Floss__Yes,
      "Friend Address" => @Friend_Address,
      "Friend area code" => @Friend_area_code,
      "Friend City" => @Friend_City,
      "Friend Name" => @Friend_Name,
      "Friend phone" => @Friend_phone,
      "Friend State" => @Friend_State,
      "Friend Zip" => @Friend_Zip,
      "General Dentist" => @General_Dentist,
      "Grinding N" => @Grinding_N,
      "Grinding Y" => @Grinding_Y,
      "Guaradian" => @Guaradian,
      "Guardian" => @Guardian,
      "Handicaps N" => @Handicaps_N,
      "Handicaps Y" => @Handicaps_Y,
      "Health Fair" => @Health_Fair,
      "Health Good" => @Health_Good,
      "Health Poor" => @Health_Poor,
      "Hearing N" => @Hearing_N,
      "Hearing Y" => @Hearing_Y,
      "Heart Murmur N" => @Heart_Murmur_N,
      "Heart Murmur Y" => @Heart_Murmur_Y,
      "Hemophilia N" => @Hemophilia_N,
      "Hemophilia Y" => @Hemophilia_Y,
      "Hepatitis N" => @Hepatitis_N,
      "Hepatitis Y" => @Hepatitis_Y,
      "HIV N" => @HIV_N,
      "HIV Y" => @HIV_Y,
      "Hospital N" => @Hospital_N,
      "Hospital Y" => @Hospital_Y,
      "Injuries - No" => @Injuries__No,
      "Injuries - Yes" => @Injuries__Yes,
      "Ins Co Address_1" => @Ins_Co_Address_1,
      "Ins Co Address_2" => @Ins_Co_Address_2,
      "Ins Co Phone_2" => @Ins_Co_Phone_2,
      "Ins Co_1 area code" => @Ins_Co_1_area_code,
      "Ins Co_1 Group #" => @Ins_Co_1_Group,
      "Ins Co_1 Name" => @Ins_Co_1_Name,
      "Ins Co_1 phone" => @Ins_Co_1_phone,
      "Ins Co_1 Relationship" => @Ins_Co_1_Relationship,
      "Ins Co_1" => @Ins_Co_1,
      "Ins Co_2  area code" => @Ins_Co_2__area_code,
      "Ins Co_2" => @Ins_Co_2,
      "Instruments played" => @Instruments_played,
      "Insured_1 Bday" => @Insured_1_Bday,
      "Kidney N" => @Kidney_N,
      "Kidney Y" => @Kidney_Y,
      "Last Dental Date" => @Last_Dental_Date,
      "Latex Allergies N" => @Latex_Allergies_N,
      "Latex Allergies Y" => @Latex_Allergies_Y,
      "Lip N" => @Lip_N,
      "Lip Y" => @Lip_Y,
      "List brothers  sisters with age 2" => @List_brothers__sisters_with_age_2,
      "Liver N" => @Liver_N,
      "Liver Y" => @Liver_Y,
      "Lupus N" => @Lupus_N,
      "Lupus Y" => @Lupus_Y,
      "Main_concerns" => @Main_concerns,
      "Married" => @Married,
      "Menstruation - No" => @Menstruation__No,
      "Menstruation - Yes" => @Menstruation__Yes,
      "Mom area code 1" => @Mom_area_code_1,
      "Mom area code 2" => @Mom_area_code_2,
      "Mom DL" => @Mom_DL,
      "Mom employer" => @Mom_employer,
      "Mom ext" => @Mom_ext,
      "Mom How Long at Current Job" => @Mom_How_Long_at_Current_Job,
      "Mom Job Title" => @Mom_Job_Title,
      "Mom phone 1" => @Mom_phone_1,
      "Mom phone 2" => @Mom_phone_2,
      "Mom SS_2" => @Mom_SS_2,
      "Mother BDay" => @Mother_BDay,
      "Mother Name_2" => @Mother_Name_2,
      "Mouth Breather N" => @Mouth_Breather_N,
      "Mouth Breather Y" => @Mouth_Breather_Y,
      "My method of payment will be" => @My_method_of_payment_will_be,
      "Nail Biting N" => @Nail_Biting_N,
      "Nail Biting Y" => @Nail_Biting_Y,
      "Operations N" => @Operations_N,
      "Operations Y" => @Operations_Y,
      "Ortho_2 No" => @Ortho_2_No,
      "Ortho_2 Yes" => @Ortho_2_Yes,
      "Orthocoverage_no" => @Orthocoverage_no,
      "Orthocoverage_yes" => @Orthocoverage_yes,
      "Plastic Allergies N" => @Plastic_Allergies_N,
      "Plastic Allergies Y" => @Plastic_Allergies_Y,
      "Please discuss any medical problems that your child has had 3" => @Please_discuss_any_medical_problems_that_your_child_has_had_3,
      "Please list all drugs that your child is currently taking" => @Please_list_all_drugs_that_your_child_is_currently_taking,
      "Please list all drugsthings that your child is allergic to" => @Please_list_all_drugsthings_that_your_child_is_allergic_to,
      "Policy Owners Employer_1" => @Policy_Owners_Employer_1,
      "Policy_1 SS" => @Policy_1_SS,
      "Previous Address 1" => @Previous_Address_1,
      "Previous Address State" => @Previous_Address_State,
      "Previous City" => @Previous_City,
      "Previous Zip" => @Previous_Zip,
      "Puberty - Yes" => @Puberty__Yes,
      "Puberty- No" => @Puberty_No,
      "Relation Name" => @Relation_Name,
      "Relation" => @Relation,
      "Relationsip to Patient 2" => @Relationsip_to_Patient_2,
      "Responsible area code work" => @Responsible_area_code_work,
      "Responsible area code" => @Responsible_area_code,
      "Responsible DL" => @Responsible_DL,
      "Responsible Employer" => @Responsible_Employer,
      "Responsible ext" => @Responsible_ext,
      "Responsible Name" => @Responsible_Name,
      "Responsible Person to make Appointments" => @Responsible_Person_to_make_Appointments,
      "Responsible phone_work" => @Responsible_phone_work,
      "Responsible phone" => @Responsible_phone,
      "Responsible Relation" => @Responsible_Relation,
      "Responsible SS" => @Responsible_SS,
      "Rheumatic Fever N" => @Rheumatic_Fever_N,
      "Rheumatic Fever Y" => @Rheumatic_Fever_Y,
      "Secondary Ins Birthdate" => @Secondary_Ins_Birthdate,
      "Secondary Ins Employer_2" => @Secondary_Ins_Employer_2,
      "Secondary Ins Group #_2" => @Secondary_Ins_Group__2,
      "Secondary Ins Name_2" => @Secondary_Ins_Name_2,
      "Secondary Ins SS" => @Secondary_Ins_SS,
      "Separated" => @Separated,
      "Sickle Cell N" => @Sickle_Cell_N,
      "Sickle Cell Y" => @Sickle_Cell_Y,
      "SIngle" => @SIngle,
      "Speech N" => @Speech_N,
      "Speech Y" => @Speech_Y,
      "Step Father" => @Step_Father,
      "Step Mother" => @Step_Mother,
      "TB N" => @TB_N,
      "TB Y" => @TB_Y,
      "Teeth - No" => @Teeth__No,
      "Teeth - Yes" => @Teeth__Yes,
      "THumb N" => @THumb_N,
      "Thumb Y" => @Thumb_Y,
      "TMJ - No" => @TMJ__No,
      "TMJ - Yes" => @TMJ__Yes,
      "Todays Date" => @Todays_Date,
      "Tongue Thrust N" => @Tongue_Thrust_N,
      "Tongue Thrust Y" => @Tongue_Thrust_Y,
      "Tonsils - No" => @Tonsils__No,
      "Tonsils - Yes" => @Tonsils__Yes,
      "Treated before - No" => @Treated_before__No,
      "Treated before - Yes" => @Treated_before__Yes,
      "Whom may we Thank for referring you" => @Whom_may_we_Thank_for_referring_you,
      "Widowed" => @Widowed

    })
    iform_file = File.new(path, 'rb')
    iform.pdffile_path = iform_file.read()
    iform.save

    File.delete(path)

  end

  def iform_file_name(iform)
    time_now = Time.now.strftime("%Y%m%d%H%M%S")
    str = "#{iform.Self_Name_Last.gsub(' ', '-')}_#{@iform.Self_Name_First.gsub(' ', '-')}_#{time_now}"
    pathx = "#{str}"
  end
end
