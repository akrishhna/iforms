class ChildformsController < ApplicationController
  before_filter :is_admin?
  def new
    @childform = Childform.new
    session[:formname] = params[:name]
    session[:appointment_id] = params[:appointment_id]
  end
  def create
    @childformcheck = Childform.where("appointment_id = ? and formname = ?",session[:appointment_id], session[:formname]).first
    if !@childformcheck  
    @childform = Childform.new(params[:childform])
    #@age = Date.today.year - @iform.Self_Birthdate.year
    #@age -= 1 if Date.today < @iform.Self_Birthdate + age.years and birthdate.month > now.month #and birthdate.day > now.day
    time_now = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
    str = time_now+"_"+@childform.Self_Name_Last+"_"+@childform.Self_Name_First
    pathx = "/pdffiles/#{str}.pdf"
    @childform.path = pathx
    @childform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider = Date.today
    @childform.formname = session[:formname]
    respond_to do |format|

        if @childform.save!
           @childform.appointment_id = session[:appointment_id]
           @childform.save
           form_control_conditions(@childform)
           @appointment = Appointment.find(session[:appointment_id])
           @appointment.timereceived = Time.now
           @appointment.status = "Received"
           @appointment.save
           @form = Form.where("formname = ?", session[:formname]).first
           p "00000000000000000000"
           p @form.id
           @appformjoin = Appformjoin.where("appointment_id = ? and form_id = ?", session[:appointment_id], @form.id ).first  
           @appformjoin = Appformjoin.find(@appformjoin.id)
           @appformjoin.status = "submitted"
           p @appformjoin.formsubmittedtime = Time.now
           @appformjoin.childform_id = @childform.id
           @appformjoin.save
           form_controls_mapping(str)
           format.html { redirect_to(@childform, :notice => 'form was successfully submitted.') }
           format.xml  { render :xml => @childform, :status => :created, :location => @childform }
         else
           format.html { render :action => "new" }
           format.xml  { render :xml => @childform.errors, :status => :unprocessable_entity }
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

  def show
    session[:appointment_id_show] = params[:appointment_id]
    if session[:appointment_id_show]
    @appointment = Appointment.find(session[:appointment_id_show])
    @childform = @appointment.childform
    else
    session[:appointment_id_show]= nil
    @childform = Childform.find(params[:id])
    @appointment = Appointment.find(@childform.appointment_id)
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @childform }
    end
  end

  def edit
     @childform_id = Childform.find(params[:id])
      @appointment = Appointment.find(@childform_id.appointment_id)
      @childform = @appointment.childform
  end
  
  def update
    @childform = Childform.find(params[:id])

    respond_to do |format|
      if @childform.update_attributes(params[:childform])
        time_now = Time.now.strftime("%Y-%m-%d_%H:%M:%S")
         str = time_now+"_"+@childform.Self_Name_Last+ "_" +@childform.Self_Name_First
         pathx = "/pdffiles/#{str}.pdf"
         p "Dad_area_code_2 #{Dad_area_code_2}"
         p "Dad_area_code_2 #{Dad_phone_2}"
          
         @childform.path = pathx
         @childform.save
         form_control_conditions(@childform)
         form_controls_mapping(str)
        format.html { redirect_to(@childform, :notice => 'Form was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @childform.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  def form_control_conditions(childform)
    @yes = "Yes"
    @Appt_ext = @childform.Person_Responsible_For_Making_Appointments_Phone_Work_Extension
    unless @childform.Person_Responsible_For_Making_Appointments_Phone_Work.blank?
    #@Appt_phone = @childform.Person_Responsible_For_Making_Appointments_Phone_Work.slice(3,3) + "-" + @childform.Person_Responsible_For_Making_Appointments_Phone_Work.slice(6,4)
    @Appt_area_code = @childform.Person_Responsible_For_Making_Appointments_Phone_Work.slice(0,3)
    end
    unless @childform.Person_Responsible_For_Making_Appointments_Phone_Home.blank?
    #@Appt_phone_2 = @childform.Person_Responsible_For_Making_Appointments_Phone_Home.slice(3,3) + "-" + @childform.Person_Responsible_For_Making_Appointments_Phone_Home.slice(6,4)
    @Appt_area_code_2 = @childform.Person_Responsible_For_Making_Appointments_Phone_Home.slice(0,3)
    end
    @Billing_Address_1 = @childform.Person_Responsible_For_Account_Address1 + ", " + @childform.Person_Responsible_For_Account_Address2
    @Billing_City_2 = @childform.Person_Responsible_For_Account_City
    @Billing_State_2 = @childform.Person_Responsible_For_Account_State
    @Billing_Zipcode_2 = @childform.Person_Responsible_For_Account_Postal_Code
    @Child_Address = @childform.Self_Home_Address1 + ", " + @childform.Self_Home_Address2
    @Child_Bday = @childform.Self_Birthdate
    @Child_CITY = @childform.Self_Home_City
    @Child_EMail_Address = @childform.Self_Email_Address
    @CHILD_FIRST = @childform.Self_Name_First + " " + @childform.Self_Name_Middle + " " + @childform.Self_Name_Last
    @Child_Grade = @childform.Self_Grade
    @Child_Hobbies = @childform.Self_Hobbies
    @Child_Nickname = @childform.Self_Name_Preferred
    unless @childform.Self_Phone_Home.blank? 
    #@Child_phone = @childform.Self_Phone_Home.slice(3,3)+"-"+@childform.Self_Phone_Home.slice(6,4)
    @Child_area_code = @childform.Self_Phone_Home.slice(0,3)
    end
    @Child_School = @childform.Self_School
    unless @childform.Self_Social_Security_Number.blank?
    @Child_SS = @childform.Self_Social_Security_Number.slice(0,3)+"-"+@childform.Self_Social_Security_Number.slice(3,2)+" "+@childform.Self_Social_Security_Number.slice(5,4)
    end
    @Child_STATE = @childform.Self_Home_State
    @Child_Zip = @childform.Self_Home_Postal_Code
    #@Childs_Physician = @childform.Med_His_Personal_Physician_Name_First+" "+@childform.Med_His_Personal_Physician_Name_Last
    unless @childform.Med_His_Personal_Physician_Phone.blank?
    #@Childs_Physician_phone = @childform.Med_His_Personal_Physician_Phone.slice(3,3)+"-"+@childform.Med_His_Personal_Physician_Phone.slice(6,4)
    @Childs_Physician_area_code = @childform.Med_His_Personal_Physician_Phone.slice(0,3)
    end
    #@Childs_Age = @childform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider - @childform.Self_Birthdate
    unless @childform.Father_Phone_Work.blank?
    @Dad_area_code_1 = @childform.Father_Phone_Work.slice(0,3)
    @Dad_phone_1 = @childform.Father_Phone_Work.slice(3,3) + @childform.Father_Phone_Work.slice(6,4)
    end
    @Dad_Bday = @childform.Father_Birthdate
    @Dad_DL_2 = @childform.Father_Drivers_License_State+" "+@childform.Father_Drivers_License_Number
    @Dad_employer = @childform.Father_Employer_Name
    @Dad_ext = @childform.Father_Phone_Work_Extension
    @Dad_How_Long_at_Current_Job_2 = @childform.Father_Length_Of_Employment
    @Dad_Job_Title_2 = @childform.Father_Job_Title
    @Dad_Name_3 = @childform.Father_Name_First+" "+@childform.Father_Name_Middle+" "+@childform.Father_Name_Last
    unless @childform.Father_Phone_Home.blank?
    @Dad_area_code_2 = @childform.Father_Phone_Home.slice(0,3)
    @Dad_phone_2 = @childform.Father_Phone_Home.slice(3,3) + @childform.Father_Phone_Home.slice(6,4) 
    end
    @Dad_SS_3 = @childform.Father_Social_Security_Number
    @Date_of_last_visit = @childform.Med_His_Personal_Physician_Date_Of_Last_Visit

    @Friend_Address = @childform.Neighbor_Or_Relative_Not_Living_With_You_Address1+ ", " +@childform.Neighbor_Or_Relative_Not_Living_With_You_Address2
    @Friend_City = @childform.Neighbor_Or_Relative_Not_Living_With_You_City
    @Friend_Name = @childform.Neighbor_Or_Relative_Not_Living_With_You_Name_First+ " " +@childform.Neighbor_Or_Relative_Not_Living_With_You_Name_Middle + " " + @childform.Neighbor_Or_Relative_Not_Living_With_You_Name_Last
    unless @childform.Neighbor_Or_Relative_Not_Living_With_You_Phone.blank?
    @Friend_area_code = @childform.Neighbor_Or_Relative_Not_Living_With_You_Phone.slice(0,3)
    #@Friend_phone = @childform.Neighbor_Or_Relative_Not_Living_With_You_Phone.slice(3,3) + "-" + @childform.Neighbor_Or_Relative_Not_Living_With_You_Phone.slice(6,4)
    end
    @Friend_State = @childform.Neighbor_Or_Relative_Not_Living_With_You_State
    @Friend_Zip = @childform.Neighbor_Or_Relative_Not_Living_With_You_Postal_Code
    @General_Dentist = @childform.Self_General_Dentist_Name
    @Ins_Co_1 = @childform.Insurance_Company_Primary_Name
    @Ins_Co_1_Group = @childform.Insurance_Company_Primary_Group_Plan_Local_Policy_Number
    @Ins_Co_1_Name = @childform.Insurance_Company_Primary_Insured_Name_First + " " + @childform.Insurance_Company_Primary_Insured_Name_Last
    unless @childform.Insurance_Company_Primary_Phone.blank? 
    @Ins_Co_1_area_code = @childform.Insurance_Company_Primary_Phone.slice(0,3)
    #@Ins_Co_1_phone = @childform.Insurance_Company_Primary_Phone.slice(3,3) + "-" + @childform.Insurance_Company_Primary_Phone.slice(6,4)
    end
    @Ins_Co_1_Relationship = @childform.Insurance_Company_Primary_Insured_Relationship
    @Ins_Co_2 = @childform.Insurance_Company_Secondary_Name
    @Ins_Co_Address_1 = @childform.Insurance_Company_Primary_Address1 + " " + @childform.Insurance_Company_Primary_Address2 + " " + @childform.Insurance_Company_Primary_City + " " + @childform.Insurance_Company_Primary_State + " " + @childform.Insurance_Company_Primary_Postal_Code
    @Ins_Co_Address_2 = @childform.Insurance_Company_Secondary_Address1 + " " + @childform.Insurance_Company_Secondary_Address2 + " " + @childform.Insurance_Company_Secondary_City + " " + @childform.Insurance_Company_Secondary_State + " " + @childform.Insurance_Company_Secondary_Postal_Code
    unless @childform.Insurance_Company_Secondary_Phone.blank?
    @Ins_Co_2__area_code = @childform.Insurance_Company_Secondary_Phone.slice(0,3)
    #@Ins_Co_Phone_2 = @childform.Insurance_Company_Secondary_Phone.slice(3,3) + "-" + @childform.Insurance_Company_Secondary_Phone.slice(6,4)
    end
    @Instruments_played = @childform.Dental_History_Play_Musical_Instruments
    @Insured_1_Bday = @childform.Insurance_Company_Primary_Insured_Birthdate
    @Last_Dental_Date = @childform.Self_General_Dentist_Date_Last_Appointment
    @List_brothers__sisters_with_age_2 = @childform.Accompanying_Your_Child_Today_Siblings_And_Ages
    @Main_concerns = @childform.Dental_History_Orthodontic_Goals
    unless @childform.Mother_Phone_Work.blank?
    @Mom_area_code_1 = @childform.Mother_Phone_Work.slice(0,3)
    @Mom_phone_1 = @childform.Mother_Phone_Work.slice(3,3) + @childform.Mother_Phone_Work.slice(6,4)
    end
    unless @childform.Mother_Phone_Home.blank?
    @Mom_area_code_2 = @childform.Mother_Phone_Home.slice(0,3)
    @Mom_phone_2 = @childform.Mother_Phone_Home.slice(3,3) + @childform.Mother_Phone_Home.slice(6,4)
    end
    @Mom_DL = @childform.Mother_Drivers_License_State + " " + @childform.Mother_Drivers_License_Number
    @Mom_employer = @childform.Mother_Employer_Name
    @Mom_ext = @childform.Mother_Phone_Work_Extension
    @Mom_How_Long_at_Current_Job = @childform.Mother_Length_Of_Employment
    @Mom_Job_Title = @childform.Mother_Job_Title
    @Mom_SS_2 = @childform.Mother_Social_Security_Number
    @Mother_BDay = @childform.Mother_Birthdate
    @Mother_Name_2 = @childform.Mother_Name_First + " " + @childform.Mother_Name_Middle + " " + @childform.Mother_Name_Last
    @My_method_of_payment_will_be = @childform.Person_Responsible_For_Account_Payment_Method
    @Please_discuss_any_medical_problems_that_your_child_has_had_3 = @childform.Med_His_Medical_Problems
    #@Please_list_all_drugs_that_your_child_is_currently_taking = @childform.Med_His_Currently_Taking_Over_The_Counter_Drugs_List+", "+@childform.Med_His_Currently_Taking_Presc_Drugs_List
    @Please_list_all_drugsthings_that_your_child_is_allergic_to = @childform.Allergic_To_Any_Drugs
    unless @childform.Insurance_Company_Primary_Insured_Social_Security_Number.blank?
    @Policy_1_SS = @childform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(0,3) + "-" + @childform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(3,2) + "-" + @childform.Insurance_Company_Primary_Insured_Social_Security_Number.slice(5,4)
    end
    @Primary_Ins_Employer_1 = @childform.Insurance_Company_Primary_Insured_Employer_Name
    @Previous_Address_1 = @childform.Person_Responsible_For_Account_Previous_Address1 + ", " + @childform.Person_Responsible_For_Account_Previous_Address2
    @Previous_Address_State = @childform.Person_Responsible_For_Account_Previous_State
    @Previous_City = @childform.Person_Responsible_For_Account_Previous_City
    @Previous_Zip = @childform.Person_Responsible_For_Account_Previous_Postal_Code
    @Relation = @childform.Accompanying_Your_Child_Today_Relationship
    @Relation_Name = @childform.Accompanying_Your_Child_Today_Relationship
    @Relationsip_to_Patient_2 = @childform.Insurance_Company_Secondary_Insured_Relationship
    @Responsible_DL = @childform.Person_Responsible_For_Account_Drivers_License_State + " " + @childform.Person_Responsible_For_Account_Drivers_License_Number
    @Responsible_Employer = @childform.Person_Responsible_For_Account_Employer_Name
    @Responsible_ext = @childform.Person_Responsible_For_Account_Phone_Work_Extension
    @Responsible_Name = @childform.Person_Responsible_For_Account_Name_First + " " + @childform.Person_Responsible_For_Account_Name_Middle + " " + @childform.Person_Responsible_For_Account_Name_Last
    @Responsible_Person_to_make_Appointments = @childform.Person_Responsible_For_Making_Appointments_Name_First + " " + @childform.Person_Responsible_For_Making_Appointments_Name_Middle + " " + @childform.Person_Responsible_For_Making_Appointments_Name_Last
    unless @childform.Person_Responsible_For_Account_Phone_Home.blank?
    @Responsible_area_code = @childform.Person_Responsible_For_Account_Phone_Home.slice(0,3)
    @Responsible_phone = @childform.Person_Responsible_For_Account_Phone_Home.slice(3,3) + "-" + @childform.Person_Responsible_For_Account_Phone_Home.slice(6,4)
    end
    unless @childform.Person_Responsible_For_Account_Phone_Work.blank?
    @Responsible_area_code_work = @childform.Person_Responsible_For_Account_Phone_Work.slice(0,3)
    @Responsible_phone_work = @childform.Person_Responsible_For_Account_Phone_Work.slice(3,3) + "-" + @childform.Person_Responsible_For_Account_Phone_Work.slice(6,4)
    end
    @Responsible_Relation = @childform.Person_Responsible_For_Account_Relationship
    unless @childform.Person_Responsible_For_Account_Social_Security_Number.blank?
    @Responsible_SS = @childform.Person_Responsible_For_Account_Social_Security_Number.slice(0,3) + "-" + @childform.Person_Responsible_For_Account_Social_Security_Number.slice(3,2) + "-" + @childform.Person_Responsible_For_Account_Social_Security_Number.slice(5,4)
    end
    @Secondary_Ins_Birthdate = @childform.Insurance_Company_Secondary_Insured_Birthdate
    @Secondary_Ins_Employer_2 = @childform.Insurance_Company_Secondary_Insured_Employer_Name
    @Secondary_Ins_Group__2 = @childform.Insurance_Company_Secondary_Group_Plan_Local_Policy_Number
    @Secondary_Ins_Name_2 = @childform.Insurance_Company_Secondary_Insured_Name_First + " " + @childform.Insurance_Company_Secondary_Insured_Name_Last
    unless @childform.Insurance_Company_Secondary_Insured_Social_Security_Number.blank?
    @Secondary_Ins_SS = @childform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(0,3) + "-" + @childform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(3,2) + "-" + @childform.Insurance_Company_Secondary_Insured_Social_Security_Number.slice(5,4)
    end
    @Todays_Date = @childform.Date_Time_Form_Submitted_By_Consumer_To_Service_Provider
    @Whom_may_we_Thank_for_referring_you = @childform.Self_Referred_By

    case @childform.Accompanying_Your_Child_Today_Has_Legal_Custody_Of_Child
    when true
      @Custody_Yes = @yes
    when false
      @Custody_No = @yes
    end

    case @childform.Allergic_To_Any_Drugs
    when true
      @Drug_Allergies_Y = @yes
    when false
      @Drug_Allergies_N = @yes
    end

    case @childform.Allergic_To_Latex or @childform.Allergic_To_Metals
    when true
      @Latex_Allergies_Y = @yes
    when false
      @Latex_Allergies_N = @yes
    end

    case @childform.Allergic_To_Plastics
    when true
      @Plastic_Allergies_Y = @yes
    when false
      @Plastic_Allergies_N = @yes
    end

    case @childform.Dental_History_Any_Extra_Permanent_Teeth or @childform.Dental_History_Any_Missing_Teeth
    when true
      @Teeth__Yes = @yes
    when false
      @Teeth__No = @yes
    end

    case @childform.Dental_History_Brush_Teeth_Daily
    when true
      @Brush__Yes = @yes
    when false
      @Brush__No = @yes
    end

    case @childform.Dental_History_Floss_Teeth_Daily
    when true
      @Floss__Yes = @yes
    when false
      @Floss__No = @yes
    end

    case @childform.Dental_History_Injury_To_Chin or @childform.Dental_History_Injury_To_Face or @childform.Dental_History_Injury_To_Mouth or @childform.Dental_History_Injury_To_Teeth
    when true
      @Injuries__Yes = @yes
    when false
      @Injuries__No = @yes
    end

    case @childform.Dental_History_Previous_Orthodontic_Evaluation or @childform.Dental_History_Previous_Orthodontic_Treatment
    when true
      @Treated_before__Yes = @yes
    when false
      @Treated_before__No = @yes
    end

    case @childform.Dental_History_TMJ_TMD_Issues_Current or @childform.Dental_History_TMJ_TMD_Issues_Previous
    when true
      @TMJ__Yes = @yes
    when false
      @TMJ__No = @yes
    end

    case @childform.Dental_History_Tonsils_Removed
    when true
      @Tonsils__Yes = @yes
    when false
      @Tonsils__No = @yes
    end

    case @childform.Father_Stepfather_Or_Gaurdian
    when "guardian"
      @Guardian = @yes
    when "stepfather"
      @Step_Father = @yes
    end

    case @childform.Habits_Bottle or @childform.Habits_Nursing
    when true
      @Bottle_Y = @yes
    when false
      @Bottle_N = @yes
    end

    case @childform.Habits_Breast_Fed
    when true
      @Breast_Fed_Y = @yes
    when false
      @Breast_Fed_N = @yes
    end

    case @childform.Habits_Clenching_Or_Grinding_Teeth
    when true
      @Grinding_Y = @yes
    when false
      @Grinding_N = @yes
    end

    case @childform.Habits_Lip_Sucking_Or_Biting
    when true
      @Lip_Y = @yes
    when false
      @Lip_N = @yes
    end

    case @childform.Habits_Mouth_Breather
    when true
      @Mouth_Breather_Y = @yes
    when false
      @Mouth_Breather_N = @yes
    end

    case @childform.Habits_Nail_Biting
    when true
      @Nail_Biting_Y = @yes
    when false
      @Nail_Biting_N = @yes
    end

    case @childform.Habits_Speech_Problems
    when true
      @Speech_Y = @yes
    when false
      @Speech_N = @yes
    end

    case @childform.Habits_Thumb_Or_Finger_Sucking
    when true
      @Thumb_Y = @yes
    when false
      @THumb_N = @yes
    end

    case @childform.Habits_Tongue_Thrust
    when true
      @Tongue_Thrust_Y = @yes
    when false
      @Tongue_Thrust_N = @yes
    end

    case @childform.Insurance_Company_Primary_Dental_Coverage
    when true
      @Dentalcoverage_yes = @yes
    when false
      @Dentalcoverage_no = @yes
    end

    case @childform.Insurance_Company_Primary_Orthodontic_Coverage
    when true
      @Orthocoverage_yes = @yes
    when false
      @Orthocoverage_no = @yes
    end

    case @childform.Insurance_Company_Secondary_Dental_Coverage
    when true
      @Dental_2_Yes = @yes
    when false
      @Dental_2_No = @yes
    end

    case @childform.Insurance_Company_Secondary_Orthodontic_Coverage
    when true
      @Ortho_2_Yes = @yes
    when false
      @Ortho_2_No = @yes
    end

    case @childform.Med_His_Abnormal_Bleeding
    when true
      @Bleeding_Y = @yes
    when false
      @Bleeding_N = @yes
    end

    case @childform.Med_His_ADD or @childform.Med_His_ADHD
    when true
      @ADHD_Y = @yes
    when false
      @ADHD_N = @yes
    end

    case @childform.Med_His_AIDS or @childform.Med_His_HIV_Positive
    when true
      @HIV_Y = @yes
    when false
      @HIV_N = @yes
    end

    case @childform.Med_His_Any_Operations
    when true
      @Operations_Y = @yes
    when false
      @Operations_N = @yes
    end

    case @childform.Med_His_Artificial_Bones_Joints_Valves
    when true
      @Bones_Y = @yes
    when false
      @Bones_N = @yes
    end

    case @childform.Med_His_Asthma
    when true
      @Asthma_Y = @yes
    when false
      @Asthma_N = @yes
    end

    case @childform.Med_His_Cancer
    when true
      @Cancer_Y = @yes
    when false
      @Cancer_N = @yes
    end

    case @childform.Med_His_Congenital_Heart_Defect
    when true
      @Congenital_Heart_Deffect_N = @yes
    when false
      @Congenital_Heart_Defect_Y = @yes
    end

    case @childform.Med_His_Current_Physical_Health
    when "fair"
      @Health_Fair = @yes
    when "good"
      @Health_Good = @yes
    when "poor"
      @Health_Poor = @yes
    end

    case @childform.Med_His_Currently_Under_The_Care_Of_A_Physician
    when true
      @Dr__Yes = @yes
    when false
      @Dr__No = @yes
    end

    case @childform.Med_His_Diabetes
    when true
      @Diabetes_Y = @yes
    when false
      @Diabetes_N = @yes
    end

    case @childform.Med_His_Epilepsy
    when true
      @Epilepsy_Y = @yes
    when false
      @Epilepsy_N = @yes
    end

    case @childform.Med_His_Handicaps_Or_Disabilities
    when true
      @Handicaps_Y = @yes
    when false
      @Handicaps_N = @yes
    end

    case @childform.Med_His_Hearing_Impairment
    when true
      @Hearing_Y = @yes
    when false
      @Hearing_N = @yes
    end

    case @childform.Med_His_Heart_Murmur
    when true
      @Heart_Murmur_Y = @yes
    when false
      @Heart_Murmur_N = @yes
    end

    case @childform.Med_His_Hemophilia
    when true
      @Hemophilia_Y = @yes
    when false
      @Hemophilia_N = @yes
    end

    case @childform.Med_His_Hepatitis
    when true
      @Hepatitis_Y = @yes
    when false
      @Hepatitis_N = @yes
    end

    case @childform.Med_His_Hospitalized_For_Any_Reason
    when true
      @Hospital_Y = @yes
    when false
      @Hospital_N = @yes
    end

    case @childform.Med_His_Kidney_Problems
    when true
      @Kidney_Y = @yes
    when false
      @Kidney_N = @yes
    end

    case @childform.Med_His_Liver_Problems
    when true
      @Liver_Y = @yes
    when false
      @Liver_N = @yes
    end

    case @childform.Med_His_Lupus
    when true
      @Lupus_Y = @yes
    when false
      @Lupus_N = @yes
    end

    case @childform.Med_His_Menstruation_Begun
    when true
      @Menstruation__Yes = @yes
    when false
      @Menstruation__No = @yes
    end

    case @childform.Med_His_Puberty_Begun
    when true
      @Puberty_No = @yes
    when false
      @Puberty__Yes = @yes
    end

    case @childform.Med_His_Rheumatic_Fever or @childform.Med_His_Scarlet_Fever
    when true
      @Rheumatic_Fever_Y = @yes
    when false
      @Rheumatic_Fever_N = @yes
    end

    case @childform.Med_His_Sickle_Cell_Disease or @childform.Med_His_Sickle_Cell_Disease_Traits
    when true
      @Sickle_Cell_Y = @yes
    when false
      @Sickle_Cell_N = @yes
    end

    case @childform.Med_His_Tuberculosis
    when true
      @TB_Y = @yes
    when false
      @TB_N = @yes
    end

    case @childform.Mother_Stepmother_Or_Gaurdian
    when "guardian"
      @Guaradian = @yes
    when "stepmother"
      @Step_Mother = @yes
    end

    case @childform.Self_Marital_Status
    when "divorced"
      @Divorced = @yes
    when "married"
      @Married = @yes
    when "separated"
      @Separated = @yes
    when "single"
      @Single = @yes
    when "widowed"
      @Widowed = @yes
    end

    case @childform.Self_Sex
    when "male"
      @Child_Male = @yes
    when "female"
      @Child_Female = @yes
    end
  end
  
  protected
  def form_controls_mapping(str)

  pdftkpath = PDFTK_PATH
  pdffilepath = PDFFILES_PATH
  path = pdffilepath + "#{str}.pdf"        
  @pdftk = PdftkForms::Wrapper.new(pdftkpath)
  p "000000000000000000000000000"
  p pdf_form = session[:formname]

  @pdftk.fill_form(pdffilepath+"#{pdf_form}.pdf", path, {
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
              "Childs Age" => @Childs_Age,
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
              "Date of last visit" => @Date_of_last_visit,
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
              "List brothers sisters with age 2" => @List_brothers__sisters_with_age_2,
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
              "Policy Owner&#8217;s Employer_1" => @Primary_Ins_Employer_1,
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
              "Single" => @Single,
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
  end

end
