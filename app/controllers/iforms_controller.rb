class IformsController < ApplicationController
 before_filter :authenticate_user!, :except => [:index]

  # GET /iforms
  # GET /iforms.xml
  def index
    # @iforms = Iform.all
    #     respond_to do |format|
    #       format.html # index.html.erb
    #       format.xml  { render :xml => @iforms }
    #     end
  end

  # GET /iforms/1
  # GET /iforms/1.xml
  def show
    @iform = Iform.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iform }
    end
  end

  # GET /iforms/new
  # GET /iforms/new.xml
  def new
    @iform = Iform.new
    session[:formname] = params[:name]
    session[:appointment_id] = params[:appointment_id]
    #session[:iform_params] ||= {}
    #@iform = Iform.new(session[:iform_params])
   #@iform.current_step = session[:iform_step]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iform }
    end
  end


  # GET /iforms/1/edit
  def edit
    @iform = Iform.find(params[:id])
  end

  # POST /iforms
  # POST /iforms.xml
  def create
  #submit_form()
     
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
    
  @iform = Iform.new(params[:iform])
  @age = Date.today.year - @iform.Self_Birthdate.year
  @age -= 1 if Date.today < @iform.Self_Birthdate + age.years and birthdate.month > now.month #and birthdate.day > now.day
  str = @iform.Self_Name_Honorific + "_" + @iform.Self_Name_First
  pathx = "/pdffiles/#{str}.pdf"
  @iform.path = pathx
  
  respond_to do |format|
            
      if @iform.save!
         @iform.appointment_id = session[:appointment_id]
         @while_awake = params[:while_awake]
         @while_sleep = params[:while_sleep]
         @iform.Dental_History_Breath_Through_Mouth_While_Awake = @while_awake
         @iform.Dental_History_Breath_Through_Mouth_While_Sleep = @while_sleep
         @injury_mouth = params[:injury_mouth]
         @injury_teeth = params[:injury_teeth]
         @injury_chin = params[:injury_chin]
         @iform.Dental_History_Injury_To_Mouth = @injury_mouth
         @iform.Dental_History_Injury_To_Teeth = @injury_teeth
         @iform.Dental_History_Injury_To_Chin = @injury_chin
         @iform.save
         #------------------------------------------------------------------ 
            form_control_conditions(@iform)                                
            
         #--------------------------------------------------------------------------------
          
          @appointment = Appointment.find(session[:appointment_id])
          @appointment.timereceived = Time.now
          @appointment.status = "Received"
          @appointment.save
          @form = Form.where("formname = ?", session[:formname]).first
          @form_id = @form.id
          @appformjoin = Appformjoin.where("appointment_id = ? and form_id = ?", session[:appointment_id], @form_id ).first  
          @appformjoin_id = @appformjoin.id
          @appformjoin = Appformjoin.find(@appformjoin_id)
          @appformjoin.status = "submitted"
          @appformjoin.formsubmittedtime = Time.now
          @appformjoin.iform_id = @iform.id
          @appformjoin.save
        
        pdftkpath = "#{Configuration.pdftk_path}"
        pdffilepath = "#{Configuration.pdffiles_path}"
        path = pdffilepath + "#{str}.pdf"        
        @pdftk = PdftkForms::Wrapper.new(pdftkpath)
        
        # @pfields = @pdftk.fields(pdffilepath + 'iform.pdf')
        #   @pfields.each do |pff|
        #     #if pff.name == 'You Female' 
        #     #You Female check_box 0 nil Off Yes
        #     # print pff.name, pff.field_type, pff.flags, pff.value, pff.options
        #     #end 
        #   end
      
   
 
        @yes = "yes"
        @no = "no"  
        @self_home_address = @iform.Self_Home_Address1+ " "+@iform.Self_Home_Address2
        @self_employer_address = @iform.Self_Employer_Address1+ " "+@iform.Self_Employer_Address2+" "+@iform.Self_Employer_City+" "+@iform.Self_Employer_State+" "+@iform.Self_Employer_Postal_Code
        @spouse_name = @iform.Spouse_Name_First+" "+@iform.Spouse_Name_Last
        @insurance_company_primary_address = @iform.Insurance_Company_Primary_Address1+" "+ @iform.Insurance_Company_Primary_Address2+" "+ @iform.Insurance_Company_Primary_City+" "+@iform.Insurance_Company_Primary_State+" "+@iform.Insurance_Company_Primary_Postal_Code
        @insurance_company_secondary_address = @iform.Insurance_Company_Secondary_Address1+" "+@iform.Insurance_Company_Secondary_Address2+" "+@iform.Insurance_Company_Secondary_City+" "+@iform.Insurance_Company_Secondary_State+" "+@iform.Insurance_Company_Secondary_Postal_Code
        pdf_form = session[:formname]
  
        @pdftk.fill_form(pdffilepath+"#{pdf_form}.pdf", path, {
          "Your E-Mail Address" => @iform.Self_Email_Address,
          'Name'=> @iform.Self_Name_Honorific+ "  " + @iform.Self_Name_First+ "  " + @iform.Self_Name_Middle,
          'MS' => @iform.Self_Prefix,
          "You #{@sex}"=> "Yes",
          "You Age" => @iform.Self_Age,
          "You SS" => @iform.Self_Social_Security_Number,       
          "You Home Address" => @self_home_address,
          "You State" => @iform.Self_Home_State,
          "You Zip" => @iform.Self_Home_Postal_Code,
          "You #{@marital_status}" => "Yes",
          "You Hm Area Code" => @iform.Self_Phone_Home.slice(0,3),
          "You Hm" => @iform.Self_Phone_Home.slice(3,9),
          "You Wk Area Code" => @iform.Self_Phone_Work.slice(0,3),
          "You Wk" => @iform.Self_Phone_Work.slice(3,9),
          "You Ext" => @iform.Self_Phone_Work_Extension,
          "You Pager Other" => @iform.Self_Phone_Mobile,
          "You Drivers License" => @iform.Self_Driver_License_Number,
          "You Employer" => @iform.Self_Employer_Name,
          "You Employer&#8217;s Address" => @self_employer_address,
          "You Birthdate" => @iform.Self_Birthdate,
          #spouse information
          "Spouse Name" => @spouse_name,
          "Spouse Employer" => @iform.Spouse_Employer_Name,
          "Spouse Wk Phone" => @iform.Spouse_Phone_Work.slice(3,9),
          "SpouseSS" => @iform.Spouse_Social_Security_Number,
          "Spouse Wk Ext" => @iform.Spouse_Phone_Work_Extension,
          "Spouse Birthdate" => @iform.Spouse_Birthdate,
          "RespPersonWk_areacode" => @iform.Person_Responsible_For_Account_Phone_Work.slice(0,3),
          "Spouse Wk Area Code" => @iform.Spouse_Phone_Work.slice(0,3),
          "RespPersonWk" => @iform.Person_Responsible_For_Account_Phone_Work.slice(3,9),
          "RespPersonHmAreacode" => @iform.Person_Responsible_For_Account_Phone_Home.slice(0,3),
          "RespPersonHm" => @iform.Person_Responsible_For_Account_Phone_Home.slice(3,9),
          "RespPerson_Employer" => @iform.Person_Responsible_For_Account_Employer_Name,
          "RespPerson_SS" => @iform.Person_Responsible_For_Account_Social_Security_Number,
          "RespPerson_DL" => @iform.Person_Responsible_For_Account_Drivers_License,
          #orthodontic insurance
          "Orthocoverage_#{@orthocoverage_primary}" => "Yes",
          "Dentalcoverage_#{@dentalcoverage_primary}" => "Yes",
          "Insurance Co Name" => @iform.Insurance_Company_Primary_Name,
          "Insurance Co Address" =>@insurance_company_primary_address,
          "Insurance Co AreaCode" => @iform.Insurance_Company_Primary_Phone.slice(0,3),
          "Insurance Co. Phone" => @iform.Insurance_Company_Primary_Phone.slice(3,9),
          "Group #  Plan, Local or Policy" => @iform.Insurance_Company_Primary_Group_Plan_Local_Policy_Number,
          "Insured&#8217;s Name" => @iform.Insurance_Company_Primary_Insured_Name_First+ " " + @iform.Insurance_Company_Primary_Insured_Name_Last,
          "Ins_Relation_2" => @iform.Insurance_Company_Primary_Insured_Relationship,
          "InsBday_1" => @iform.Insurance_Company_Primary_Insured_Birthdate,
          "Insured&#8217;s SS" => @iform.Insurance_Company_Primary_Insured_Social_Security_Number,
          "Insured&#8217;s Employer" => @iform.Insurance_Company_Primary_Insured_Employer_Name,
          #secondary
          "OrthoCoverage_#{@orthocoverage_secondary}2" => "Yes",
          "DentalCoverage_#{@dentalcoverage_secondary}2" => "Yes",
          "Insurance Co Name_2" => @iform.Insurance_Company_Secondary_Name,
          "Insurance Co Address_2" => @insurance_company_secondary_address,
          "Insurance Co Areacode_2" => @iform.Insurance_Company_Secondary_Phone.slice(0,3),
          "Insurance Co. Phone2" => @iform.Insurance_Company_Secondary_Phone.slice(3,9),
          "Group # Plan, Local or Policy2" => @iform.Insurance_Company_Secondary_Group_Plan_Local_Policy_Number,
          "Insured&#8217;s Name_2" => @iform.Insurance_Company_Secondary_Insured_Name_First+ " " + @iform.Insurance_Company_Secondary_Insured_Name_Last,
          "Relation_3" => @iform.Insurance_Company_Secondary_Insured_Relationship,
          "InsuredBday_" => @iform.Insurance_Company_Secondary_Insured_Birthdate,
          "Insured&#8217;s SS_2" => @iform.Insurance_Company_Secondary_Insured_Social_Security_Number,
          "Insured&#8217;s Employer_2" => @iform.Insurance_Company_Secondary_Insured_Employer_Name,
          "His  Her Name_2" => @iform.Emergency_Contact_Name_First+" "+ @iforms.Emergency_Contact_Name_Last,
          "Relation_4" => @iform.Emergency_Contact_Relationship,
          "Wk_areacode" => @iform.Emergency_Contact_Phone_Work.slice(0,3),
          "emergency_phone_wk" => @iform.Emergency_Contact_Phone_Work.slice(3,9),
          "Hm_areacode" => @iform.Emergency_Contact_Phone_Home.slice(0,3),
          "emergency_phone_hm" => @iform.Emergency_Contact_Phone_Home.slice(3,9),
          #medical history
          #"Physician_yes" =>

          "Physician&#8217;s Name" => @iform.Med_His_Personal_Physician_Name_First+" "+@iform.Med_His_Personal_Physician_Name_Last,
          "Physician_areacode" => @iform.Med_His_Personal_Physician_Phone.slice(0,3),
          "Physician_phone" => @iform.Med_His_Personal_Physician_Phone.slice(3,9),
          "Date of last visit" => @iform.Med_His_Personal_Physician_Date_Of_Last_Visit,
          "Health_#{@current_physical_health}" => "Yes",
          "Physician_#{@currently_under_physician}" => "Yes",
          "Please explain" => @iform.Med_His_Currently_Under_The_Care_Of_A_Physician_Desc,
          "Drugs_#{@currently_under_prescription}" => "Yes",
          "Are you taking any prescription  over-the-counter drugs" => @iform.Med_His_Currently_Taking_Presc_Or_Over_The_Counter_Drugs_List,
          "Pills_#{@Currently_Taking_Birth_Control_Pills}" => "Yes",
          "Pregnant_#{@Currently_Pregnant}" => "Yes",
          "Week#" => @iform.Med_His_Weeks_Pregnant,
          "Nursing_#{@Currently_Nursing}" =>  "Yes",
          "Bleeding #{@Abnormal_Bleeding}" => "Yes",
          "Anemia #{@Anemia}" => "Yes",
          "Bones #{@Bones_Joints_Valves}" => "Yes",
          "Asthma #{@Asthma}" => "Yes",
          "Transfusion #{@Blood_Transfusion}" => "Yes",
          "Cancer #{@Cancer}" => "Yes",
          "Congenital Heart Deffect #{@Congenital_Heart_Defect}" => "Yes",
          "Diabetes #{@Diabetes}" => "Yes",
          "Difficulty Breathing #{@Difficulty_Breathing}" => "Yes",
          "Drug Abuse #{@Drug_Abuse}" => "Yes",
          "Emphysema #{@Emphysema}" => "Yes",
          "Epilepsy #{@Epilepsy}" => "Yes",
          "Fever Blisters #{@Fever_Blisters}" => "Yes",
          "Glaucoma #{@Glaucoma}" => "Yes",
          "Heart Attack #{@Heart_Attack_Or_Stroke}" => "Yes",
          "Heart Murmur #{@Heart_Murmur}" => "Yes",
          "Heart Surgery #{@Heart_Surgery_Or_Pacemaker}" => "Yes",
          "Hemophilia #{@Hemophilia}" => "Yes",
          "Hepatitis #{@Hepatitis}" => "Yes",
          "Blood Pressure #{@High_Or_Low_Blood_Pressure}" => "Yes",
          "HIV #{@HIV_or_AIDS}" => "Yes",
          "Hospitalization #{@Hospitalized_For_Any_Reason}" => "Yes",
          "Kidney #{@Kidney_Problems}" => "Yes",
          "MVP #{@Mitral_Valve_Prolapse}" => "Yes",
          "Phychiatric #{@Psychiatric_Problems}" => "Yes",
          "Radiation #{@Radiation_Treatment}" => "Yes",
          "Rheumatic Fever #{@Rheumatic_Fever_Or_Scarletfever}" => "Yes",
          "Headaches #{@Frequent_Headaches}" => "Yes",
          "Shingles #{@Shingles}" => "Yes",
          "Sickle Cell #{@Sickle_Cell_Disease_Or_Traits}" => "Yes",
          "Sinus #{@Sinus_Problems}" => "Yes",
          "TB #{@Tuberculosis}" => "Yes",
          "Ulcer #{@Ulcers}" => "Yes",
          "Venereal Disease #{@Venereal_Disease}" => "Yes",
          "Any serious medical conditions" => @iform.Med_His_Serious_Medical_Issues,
          "Aspirin #{@Aspirin}" => "Yes",
          "Metals #{@Metals_Or_Plastics}" => "Yes",
          "Codeine #{@Codeine}" => "Yes",
          "Anesthetics #{@Dental_Anesthetics}" => "Yes",
          "Erythromycin #{@Erythromycin}" => "Yes",
          "Latex #{@Latex}" => "Yes",
          "Penicillin #{@Penicillin}" =>"Yes",
          "Tetracycline #{@Tetracycline}" => "Yes",
          "Other #{@Other}" => "Yes",
          "Allergic" => @iform.Allergic_To_Other_Detail,
          #dental history
          "What do you want" => @iform.Dental_History_Concerns_Tobe_Accomplished_By_Orthodontics,
          "Evaluated_#{@Orthodontic_Evaluation}" => "Yes",
          "Previous problems_#{@Previous_Dental_Work_Issues}" => "Yes",
          "TMJ_#{@TMJ_TMD_Issues}" => "Yes",
          "Dental Health_#{@current_dental_health}" => "Yes",
          "Smile_#{@Like_Smile}" => "Yes",
          "Gums bleed_#{@Bleeding_Gums}" => "Yes",
          "Mouth" => @mouth,
          "Teeth" => @teeth,
          "Chin" => @chin,
          "Any speech problems" => @iform.Dental_History_Currently_Have_Speech_Problems,
          "Mouth breather_#{@Breath_Through_Mouth}" => "Yes",
          "While #{@Mouth_While_Awake_Or_Sleep}" => "Yes",
          "Teeth_#{@Extra_Permanent_Teeth}" => "Yes",
          "Phen-Fen_#{@Ever_Taken_PhenFen}" => "Yes",
          "When taken Phen-Fen" => @iform.Dental_History_When_Taken_PhenFen_Redux_Pondimin,
          "Tobacco_#{@Tobacco_Smoke}" => "Yes"
          # "Relation" => @iform.responsibleperson_relation,

})
       
        format.html { redirect_to(@iform, :notice => 'form was successfully submitted.') }
        format.xml  { render :xml => @iform, :status => :created, :location => @iform }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @iform.errors, :status => :unprocessable_entity }
      end
  end
  end
  

  # PUT /iforms/1
  # PUT /iforms/1.xml
  def update
    @iform = Iform.find(params[:id])

    respond_to do |format|
      if @iform.update_attributes(params[:iform])
        format.html { redirect_to(@iform, :notice => 'Iform was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iform.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iforms/1
  # DELETE /iforms/1.xml
  def destroy
    @iform = Iform.find(params[:id])
    @iform.destroy

    respond_to do |format|
      format.html { redirect_to(iforms_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def submit_form
    if session[:formname] == "testform1"
      @iform = Iform.new(params[:iform])
      @iform.appointment_id = session[:appointment_id]
      if @iform.save
        @forms = Form.where("formname = ?", session[:formname])
        @forms.each do |i|
          @form_id = i.id
        end
        @appformjoins = Appformjoin.where("appointment_id = ? and form_id = ?", session[:appointment_id], @form_id )
        @appformjoins.each do |i|  
          @appformjoin_id = i.id
        end
        @appformjoin = Appformjoin.find(@appformjoin_id)
        @appformjoin.status = "submitted"
        @appformjoin.formsubmittedtime = Time.now
        @appformjoin.iform_id = @iform.id
        @appformjoin.save
        redirect_to(@iform)
      else
        render "new"
      end
    end
  end

  # method below -- to check conditions to assign to form controls
  def form_control_conditions(iform)
    @iform = iform
    if @iform.Self_Sex == 'female'
      @sex = 'Female'
    end
    if @iform.Self_Sex == 'male'
      @sex = 'mail'
    end

    marital_status = ["single", "married", "divorced", "widowed", "seperated"]
    marital_status.each do |i|
      if @iform.Self_Marital_Status == i
        @marital_stauts = i.capitalize
      end
    end

    case @iform.Insurance_Company_Primary_Orthodontic_Coverage
    when true 
      @orthocoverage_primary = "yes"
    when false
      @orthocoverage_primary = "no"
    end

    case @iform.Insurance_Company_Primary_Dental_Coverage
    when true
      @dentalcoverage_primary = "yes"
    when false
      @dentalcoverage_primary = "no"
    end

    case @iform.Insurance_Company_Secondary_Orthodontic_Coverage
    when true
      @orthocoverage_secondary = "Yes"
    when false
      @orthocoverage_secondary = "No"
    end

    case @iform.Insurance_Company_Secondary_Dental_Coverage
    when true
      @dentalcoverage_secondary = "Yes"
    when false
      @dentalcoverage_secondary = "No"
    end

    current_physical_health = ["good", "fair","poor"]
    current_physical_health.each do |i|
      if @iform.Med_His_Current_Physical_Health == i
        @current_physical_health = i
      end
    end

    case @iform.Med_His_Currently_Under_The_Care_Of_A_Physician
    when true
      @currently_under_physician = "yes"
    when false
      @currently_under_physician = "no"
    end

    case @iform.Med_His_Currently_Taking_Presc_Or_Over_The_Counter_Drugs
    when true
      @currently_under_prescription = "yes"
    when false
      @currently_under_prescription = "no"
    end

    case @iform.Med_His_Currently_Taking_Birth_Control_Pills
    when true
      @Currently_Taking_Birth_Control_Pills = "yes"
    when false
      @Currently_Taking_Birth_Control_Pills = "no"
    end

    case @iform.Med_His_Currently_Pregnant
    when true
      @Currently_Pregnant = "yes"
    when false
      @Currently_Pregnant = "no"
    end

    case @iform.Med_His_Currently_Nursing
    when true
      @Currently_Nursing = "yes"
    when false
      @Currently_Nursing = "no"
    end

    case @iform.Med_His_Abnormal_Bleeding
    when true
      @Abnormal_Bleeding = "Y"
    when false
      @Abnormal_Bleeding = "N"
    end

    case @iform.Med_His_Anemia
    when true
      @Anemia = "Y"
    when false
      @Anemia = "N"
    end

    case @iform.Med_His_Artificial_Bones_Joints_Valves
    when true
      @Bones_Joints_Valves = "Y"
    when false
      p "bones false"
      @Bones_Joints_Valves = "N"
    end

    case @iform.Med_His_Asthma
    when true
      @Asthma = "Y"
    when false
      @Asthma = "N"
    end

    case @iform.Med_His_Blood_Transfusion
    when true
      @Blood_Transfusion = "Y"
    when false
      @Blood_Transfusion = "N"
    end

    case @iform.Med_His_Cancer
    when true
      @Cancer = "Y"
    when false
      @Cancer = "N"
    end

    case @iform.Med_His_Congenital_Heart_Defect
    when true
      @Congenital_Heart_Defect = "Y"
    when false
      @Congenital_Heart_Defect = "N"
    end

    case @iform.Med_His_Diabetes
    when true
      @Diabetes = "Y"
    when false
      @Diabetes = "N"
    end

    case @iform.Med_His_Difficulty_Breathing
    when true
      @Difficulty_Breathing = "Y"
    when false
      @Difficulty_Breathing = "N"
    end

    case @iform.Med_His_Drug_Abuse
    when true
      @Drug_Abuse = "Y"
    when false
      @Drug_Abuse = "N"
    end

    case @iform.Med_His_Emphysema
    when true
      @Emphysema = "Y"
    when false
      @Emphysema = "N"
    end

    case @iform.Med_His_Epilepsy
    when true
      @Epilepsy = "Y"
    when false
      @Epilepsy = "N"
    end

    case @iform.Med_His_Fever_Blisters
    when true
      @Fever_Blisters = "Y"
    when false
      @Fever_Blisters = "N"
    end

    case @iform.Med_His_Glaucoma
    when true
      @Glaucoma = "Y"
    when false
      @Glaucoma = "N"
    end

    case @iform.Med_His_Heart_Attack_Or_Stroke
    when true
      @Heart_Attack_Or_Stroke = "Y"
    when false
      @Heart_Attack_Or_Stroke = "N"
    end

    case @iform.Med_His_Heart_Murmur
    when true
      @Heart_Murmur = "Y"
    when false
      @Heart_Murmur = "N"
    end

    case @iform.Med_His_Heart_Surgery_Or_Pacemaker
    when true
      @Heart_Surgery_Or_Pacemaker = "Y"
    when false
      @Heart_Surgery_Or_Pacemaker = "N"
    end

    case @iform.Med_His_Hemophilia
    when true
      @Hemophilia = "Y"
    when false
      @Hemophilia = "N"
    end

    case @iform.Med_His_Hepatitis
    when true
      @Hepatitis = "Y"
    when false
      @Hepatitis = "N"
    end

    case @iform.Med_His_High_Or_Low_Blood_Pressure
    when true
      @High_Or_Low_Blood_Pressure = "Y"
    when false
      @High_Or_Low_Blood_Pressure = "N"
    end

    case @iform.Med_His_AIDS
    when true
      @HIV_or_AIDS = "Y"
    when false
      @HIV_or_AIDS = "N"
    end

    case @iform.Med_His_Hospitalized_For_Any_Reason
    when true
      @Hospitalized_For_Any_Reason = "Y"
    when false
      @Hospitalized_For_Any_Reason = "N"
    end

    case @iform.Med_His_Kidney_Problems
    when true
      @Kidney_Problems = "Y"
    when false
      @Kidney_Problems = "N"
    end

    case @iform.Med_His_Mitral_Valve_Prolapse
    when true
      @Mitral_Valve_Prolapse = "Y"
    when false
      @Mitral_Valve_Prolapse = "N"
    end

    case @iform.Med_His_Psychiatric_Problems
    when true
      @Psychiatric_Problems = "Y"
    when false
      @Psychiatric_Problems = "N"
    end

    case @iform.Med_His_Radiation_Treatment
    when true
      @Radiation_Treatment = "Y"
    when false
      @Radiation_Treatment = "N"
    end

    case @iform.Med_His_Rheumatic_Fever_Or_Scarletfever
    when true
      @Rheumatic_Fever_Or_Scarletfever = "Y"
    when false
      @rheumatic_or_scarletfever = "N"
    end

    case @iform.Med_His_Frequent_Headaches
    when true
      @Frequent_Headaches = "Y"
    when false
      @Frequent_Headaches = "N"
    end

    case @iform.Med_His_Shingles
    when true
      @Shingles = "Y"
    when false
      @Shingles = "N"
    end

    case @iform.Med_His_Sickle_Cell_Disease_Or_Traits
    when true
      @Sickle_Cell_Disease_Or_Traits = "yes"
    when false
      @Sickle_Cell_Disease_Or_Traits = "no"
    end

    case @iform.Med_His_Sinus_Problems
    when true
      @Sinus_Problems = "Y"
    when false
      @Sinus_Problems = "N"
    end

    case @iform.Med_His_Tuberculosis
    when true
      @Tuberculosis = "Y"
    when false
      @Tuberculosis = "N"
    end

    case @iform.Med_His_Ulcers
    when true
      @Ulcers = "Y"
    when false
      @Ulcers = "N"
    end

    case @iform.Med_His_Venereal_Disease
    when true
      @Venereal_Disease = "Y"
    when false
      @Venereal_Disease = "N"
    end

    case @iform.Allergic_To_Aspirin
    when true
      @Aspirin = "Y"
    when false
      @Aspirin = "N"
    end

    case @iform.Allergic_To_Metals_Or_Plastics
    when true
      @Metals_Or_Plastics = "Y"
    when false
      @Metals_Or_Plastics = "N"
    end

    case @iform.Allergic_To_Codeine
    when true
      @Codeine = "Y"
    when false
      @Codeine = "N"
    end

    case @iform.Allergic_To_Dental_Anesthetics
    when true
      @Dental_Anesthetics = "Y"
    when false
      @Dental_Anesthetics = "N"
    end

    case @iform.Allergic_To_Erythromycin
    when true
      @Erythromycin = "Y"
    when false
      @Erythromycin = "N"
    end

    case @iform.Allergic_To_Latex
    when true
      @Latex = "Y"
    when false
      @Latex = "N"
    end

    case @iform.Allergic_To_Penicillin
    when true
      @Penicillin = "Y"
    when false
      @Penicillin = "N"
    end

    case @iform.Allergic_To_Tetracycline
    when true
      @Tetracycline = "Y"
    when false
      @Tetracycline = "N"
    end

    case @iform.Allergic_To_Other
    when true
      @Other = "Y"
    when false
      @Other = "N"
    end

    case @iform.Dental_History_Previous_Orthodontic_Evaluation
    when true
      @Orthodontic_Evaluation = "yes"
    when false
      @Orthodontic_Evaluation = "no"
    end

    case @iform.Dental_History_Previous_Dental_Work_Issues
    when true
      @Previous_Dental_Work_Issues = "yes"
    when false
      @Previous_Dental_Work_Issues = "no"
    end

    case @iform.Dental_History_TMJ_TMD_Issues
    when true
      @TMJ_TMD_Issues = "yes"
    when false
      @TMJ_TMD_Issues = "no"
    end

    current_dental_health = ["good", "fair","poor"]
    current_dental_health.each do |i|
      if @iform.Dental_History_Current_Dental_Health == i
        @current_dental_health = i
      end
    end

    case @iform.Dental_History_Like_Smile
    when true
      @Like_Smile = "yes"
    when false
      @Like_Smile = "no"
    end

    case @iform.Dental_History_Bleeding_Gums
    when true
      @Bleeding_Gums = "yes"
    when false
      @Bleeding_Gums = "no"
    end

    if @iform.Dental_History_Injury_To_Mouth == "mouth"
      @mouth = "Yes"
    end
    if @iform.Dental_History_Injury_To_Teeth == "teeth"
      @teeth = "Yes"
    end
    if @iform.Dental_History_Injury_To_Chin == "chin"
      @chin = "Yes"
    end

    case @iform.Dental_History_Breath_Through_Mouth
    when true
      @Breath_Through_Mouth = "yes"
    when false
      @Breath_Through_Mouth = "no"
    end

    if @iform.Dental_History_Breath_Through_Mouth_While_Awake == "while_awake"
      @Mouth_While_Awake_Or_Sleep = "Awake"
    end
    if @iform.Dental_History_Breath_Through_Mouth_While_Sleep == "while_sleep"
      @Mouth_While_Awake_Or_Sleep = "Asleep"
    end

    case @iform.Dental_History_Any_Extra_Permanent_Teeth
    when true
      @Extra_Permanent_Teeth = "yes"
    when false
      @Extra_Permanent_Teeth = "no"
    end

    case @iform.Dental_History_Ever_Taken_PhenFen_Redux_Pondimin
    when true
      @Ever_Taken_PhenFen = "yes"
    when false
      @Ever_Taken_PhenFen = "no"
    end

    case @iform.Dental_History_Tobacco_Smoke
    when true
      @Tobacco_Smoke = "yes"
    when false
      @Tobacco_Smoke = "no"
    end
  end
    
end