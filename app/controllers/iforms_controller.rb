class IformsController < ApplicationController
 before_filter :authenticate_user!, :except => [:index]
  # GET /iforms
  # GET /iforms.xml
  def index
    # @iforms = Iform.all
# 
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
puts session[:appointment_id] = params[:appointment_id]
    # session[:iform_params] ||= {}
     #     @iform = Iform.new(session[:iform_params])
  #      @iform.current_step = session[:iform_step]
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
  submit_form()
     #session[:iform_params].deep_merge!(params[:iform]) if params[:iform]
     #@iform = Iform.new(session[:iform_params])
      #@iform.current_step = session[:iform_step]
       #  if @iform.valid?
        #     if params[:back_button]
        #       @iform.previous_step
         #    elsif @iform.last_step?
         #      @iform.save if @iform.all_valid?
          #   else
          #     @iform.next_step
           #  end
           #  session[:iform_step] = @iform.current_step
        # end
        # if @iform.new_record?
         #    render "new"
         #  else
          #   session[:iform_step] = session[:iform_params] = nil
           #  flash[:notice] = "iform saved!"
           #  redirect_to @iform
         #end
 if session[:formname] == "testform"
    @iform = Iform.new(params[:iform])
  str = @iform.lastname + "_" + @iform.firstname
   pathx = "/pdffiles/#{str}.pdf"
    @iform.path = pathx
    
    respond_to do |format|
      
      
      if @iform.save
         @iform.appointment_id = session[:appointment_id]
         @iform.save
          # @appointment = Appointment.find(session[:appointment_id])
          #           @appointment.timereceived = Time.now
          #           @appointment.status = "Received"
          #           @appointment.save
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
        namestr = @iform.lastname << "  " + @iform.firstname + "  " + @iform.middlename
        pdftkpath = "#{Configuration.pdftk_path}"
        pdffilepath = "#{Configuration.pdffiles_path}"
        path = pdffilepath + "#{str}.pdf"
        
        @pdftk = PdftkForms::Wrapper.new(pdftkpath)
        @pfields = @pdftk.fields(pdffilepath + 'iform.pdf')
       @pfields.each do |pff|
          #if pff.name == 'You Female' 
          #You Female check_box 0 nil Off Yes
           # print pff.name, pff.field_type, pff.flags, pff.value, pff.options
          #end 
        end
      if @iform.sex == 'female'
        @sex = 'Female'
      else
        @sex = 'mail'
      end
     
  relationship = ["single", "married", "divorced", "widowed", "seperated"]
      
      relationship.each do |i|
      if @iform.relationshipstatus == i
     # puts "00000000000000000000000000"
      @relationshipstatus = i.capitalize
      end
      end
   
   if @iform.orthocoverage == "y"
   	 @orthocoverage = "yes"
   else
     @orthocoverage = "no"
   end

   if @iform.dentalcoverage == "y"
   	 @dentalcoverage = "yes"
   else
     @dentalcoverage = "no"
   end

   if @iform.orthocoverage_sec == "y"
   	 @orthocoverage2 = "yes"
   else
     @orthocoverage2 = "no"
   end

   if @iform.dentalcoverage_sec == "y"
   	 @dentalcoverage2 = "yes"
   else
     @dentalcoverage2 = "no"
   end
   
   phyhealth = ["good", "fair","poor"]
   phyhealth.each do |i|
      if @iform.current_physicalhealth == i
      @cur_phyhealth = i
      end
      end

   if  @iform.currently_underphysician == "y"
   	 @underphysician = "yes"
   else
     @underphysician = "no"
   end
   
   if  @iform.currently_underprescription == "y"
   	 @drugs = "yes"
   else
     @drugs = "no"
   end
 
   if @iform.birthcontrolpills == "y"
   	  @pills = "yes"
   else
     @pills = "no"
   end


   if @iform.pregnant == "y"
   	  @pregnant = "yes"
   else
     @pregnant = "no"
   end
   
   if @iform.nursing == "y"
   	  @nursing = "yes"
   else
     @nursing = "no"
   end


   if @iform.abnormalbleeding == "y"
   	  @abnormalbleeding = "Y"
   else
     @abnormalbleeding = "N"
   end


   if @iform.anemia == "y"
   	  @anemia = "Y"
   else
     @anemia = "N"
   end


    if @iform.artificialbones_or_joints_or_valves == "y"
   	  @bones = "Y"
   else
     @bones = "N"
   end


    if @iform.asthama_or_arthritis == "y"
   	  @asthama_or_arthritis = "Y"
   else
     @asthama_or_arthritis = "N"
   end



    if @iform.bloodtransfusion == "y"
   	  @bloodtransfusion = "Y"
   else
     @bloodtransfusion = "N"
   end


    if @iform.cancer_or_chemotherepy == "y"
   	  @cancer_or_chemotherepy = "Y"
   else
     @cancer_or_chemotherepy = "N"
   end
   
    if @iform.congenital_heartdefect == "y"
   	  @congenital_heartdefect = "Y"
   else
     @congenital_heartdefect = "N"
   end
   
    if @iform.diabetes == "y"
   	  @diabetes = "Y"
   else
     @diabetes = "N"
   end
   
     if @iform.difficultybreathing == "y"
   	  @difficultybreathing = "Y"
   else
     @difficultybreathing = "N"
   end
   
     if @iform.drug_or_alcoholabuse == "y"
   	  @drug_or_alcoholabuse = "Y"
   else
     @drug_or_alcoholabuse = "N"
   end
   
     if @iform.emphysema == "y"
   	  @emphysema = "Y"
   else
     @emphysema = "N"
   end

     if @iform.epilepsy_or_seizures_or_fainting == "y"
   	  @epilepsy_or_seizures_or_fainting = "Y"
   else
     @epilepsy_or_seizures_or_fainting = "N"
   end

     if @iform.feverblisters_or_herpes == "y"
   	  @feverblisters_or_herpes = "Y"
   else
     @feverblisters_or_herpes = "N"
   end

     if @iform.glaucoma == "y"
   	  @glaucoma = "Y"
   else
     @glaucoma = "N"
   end
 
     if @iform.heartattack_or_stroke == "y"
   	  @heartattack_or_stroke = "Y"
   else
     @heartattack_or_stroke = "N"
   end
   
     if @iform.heartmurmur == "y"
   	  @heartmurmur = "Y"
   else
     @heartmurmur = "N"
   end
   
   if @iform.heartsurgery_or_pacemaker == "y"
   	  @heartsurgery_or_pacemaker = "Y"
   else
     @heartsurgery_or_pacemaker = "N"
   end
   
   
  if @iform.hemophilia == "y"
   	  @hemophilia = "Y"
   else
     @hemophilia = "N"
   end
 
 if @iform.hepatitis == "y"
   	  @hepatitis = "Y"
   else
     @hepatitis = "N"
   end
   
   if @iform.high_or_lowbloodpressure == "y"
   	  @high_or_lowbloodpressure = "Y"
   else
     @high_or_lowbloodpressure = "N"
   end

 if @iform.HIV_or_AIDS == "y"
   	  @HIV_or_AIDS = "Y"
   else
     @HIV_or_AIDS = "N"
   end

 if @iform.hospitalized_reason == "y"
   	  @hospitalized_reason = "Y"
   else
     @hospitalized_reason = "N"
   end

 if @iform.kidneyproblems == "y"
   	  @kidneyproblems = "Y"
   else
     @kidneyproblems = "N"
   end

  if @iform.mitralvalveprolapse == "y"
   	  @mitralvalveprolapse = "Y"
   else
     @mitralvalveprolapse = "N"
   end

  if @iform.psychiatricproblems == "y"
   	  @psychiatricproblems = "Y"
   else
     @psychiatricproblems = "N"
   end

    if @iform.radiationtreatment == "y"
   	  @radiationtreatment = "Y"
   else
     @radiationtreatment = "N"
   end

 if @iform.rheumatic_or_scarletfever == "y"
   	  @rheumatic_or_scarletfever = "Y"
   else
     @rheumatic_or_scarletfever = "N"
   end


 if @severe_or_frequentheadaches == "Y"
   else
     @severe_or_frequentheadaches = "N"
   end

    if @iform.shingles == "y"
   	  @shingles = "Y"
   else
     @shingles = "N"
   end
    
    if @iform.sicklecelldisease_or_traits == "y"
 	  @sicklecelldisease_or_traits = "yes"
   else
     @sicklecelldisease_or_traits = "no"
   end

   if @iform.sinusproblems == "y"
   	  @sinusproblems = "Y"
   else
     @sinusproblems = "N"
   end

     if @iform.tuberculosis == "y"
   	  @tuberculosis = "Y"
   else
     @tuberculosis = "N"
   end

 if @iform.ulcers_or_colitis == "y"
   	  @ulcers_or_colitis = "Y"
   else
     @ulcers_or_colitis = "N"
   end

    if @iform.venerealdisease == "y"
   	  @venerealdisease = "Y"
   else
     @venerealdisease = "N"
   end
   
   
  if @iform.aspirin == "y"
   	  @aspirin = "Y"
   else
     @aspirin = "N"
   end
   

  if @iform.anymetals_or_plastics == "y"
   	  @anymetals_or_plastics = "Y"
   else
     @anymetals_or_plastics = "N"
   end

  if @iform.codeine == "y"
   	  @codeine = "Y"
   else
     @codeine = "N"
   end
   

  if @iform.dentalanesthetics == "y"
   	  @dentalanesthetics = "Y"
   else
     @dentalanesthetics = "N"
   end
   

  if @iform.erythromycin == "y"
   	  @erythromycin = "Y"
   else
     @erythromycin = "N"
   end
 
  if @iform.latex == "y"
   	  @latex = "Y"
   else
     @latex = "N"
   end
   

  if @iform.penicillin == "y"
   	  @penicillin = "Y"
   else
     @penicillin = "N"
   end
   
 if @iform.tetracycline == "y"
   	  @tetracycline = "Y"
   else
     @tetracycline = "N"
   end
 
  if @iform.other == "y"
   	  @other = "Y"
   else
     @other = "N"
   end
   

if @iform.undogone_orthodontictreatment == "y"
   	  @undogone_orthodontictreatment = "yes"
   else
     @undogone_orthodontictreatment = "no"
   end


if @iform.problemwith_previousdentalwork == "y"
   	  @problemwith_previousdentalwork = "yes"
   else
     @problemwith_previousdentalwork = "no"
   end


if @iform.pain_jawjoint == "y"
   	  @pain_jawjoint = "yes"
   else
     @pain_jawjoint = "no"
   end

   denhealth = ["good", "fair","poor"]
   denhealth.each do |i|
      if @iform.current_dentalhealth == i
      @current_dentalhealth = i
      end
      end


if @iform.likeyoursmile == "y"
   	  @likeyoursmile = "yes"
   else
     @likeyoursmile = "no"
   end


if @iform.gumsbleed == "y"
   	  @gumsbleed = "yes"
   else
     @gumsbleed = "no"
   end

if @iform.breaththrumouth == "y"
   	  @breaththrumouth = "yes"
   else
     @breaththrumouth = "no"
   end


   # if @iform.breaththrumouth_awake_sleep == "y"
#    	  @breaththrumouth_awake_sleep = "yes"
#    else
#      @breaththrumouth_awake_sleep = "no"
#    end

   if @iform.missing_or_extra_permanantteeth == "y"
   	  @missing_or_extra_permanantteeth = "yes"
   else
     @missing_or_extra_permanantteeth = "no"
   end


   if @iform.evertaken_phenfen == "y"
   	  @evertaken_phenfen = "yes"
   else
     @evertaken_phenfen = "no"
   end

  if @iform.smoke_or_usetobacco == "y"
   	  @smoke_or_usetobacco = "yes"
   else
     @smoke_or_usetobacco = "no"
   end

   
       @pdftk.fill_form(pdffilepath + 'iform.pdf', path, {'MS' => @iform.prefix,
       
         'Name'=>namestr,
         "You #{@sex}"=> "Yes",
         "Your E-Mail Address" => @iform.email,
"You mail" => @iform.relationshipstatus,
"You Female" => @iform.relationshipstatus,
"You Birthdate" => @iform.birthdate,
"You Age" => @iform.age,
"You SS" => @iform.SSN,
"You Home Address" => @iform.homeadd,
"You State" => @iform.state,
"You Zip" => @iform.zip,
"You #{@relationshipstatus}" => "Yes",
"You Hm Area Code" => @iform.homeph,
"You Wk Area Code" => @iform.workph,
"You Hm" => @iform.homeph,
"You Wk" => @iform.workph,
"You Pager Other" => @iform.pager,
"You Drivers License" => @iform.DL,
"You Ext" => @iform.workext,
"You Employer" => @iform.employer,
"You Employer&#8217;s Address" => @iform.empadd,
"Spouse Name" => @iform.spousename,
"Spouse Employer" => @iform.spouse_employer,
"Spouse Wk Phone" => @iform.spouse_wkphone,
"SpouseSS" => @iform.spouse_SSN,
"Spouse Wk Ext" => @iform.spouse_wkext,
"Spouse Birthdate" => @iform.spouse_birthdate,
"RespPersonWk_areacode" => @iform.responsibleperson_wkph,
"Spouse Wk Area Code" => @iform.spouse_wkphone,
"RespPersonWk" => @iform.responsibleperson_wkph,
"RespPersonHmAreacode" => @iform.responsibleperson_hmph,
"RespPersonHm" => @iform.responsibleperson_hmph,
"RespPerson_Employer" => @iform.responsibleperson_employer,
"RespPerson_SS" => @iform.responsibleperson_SSN,
"RespPerson_DL" => @iform.responsibleperson_DL,
"Orthocoverage_#{@orthocoverage}" => "Yes",
"Dentalcoverage_#{@dentalcoverage}" => "Yes",
"Insurance Co AreaCode" => @iform.insurancecompany_ph,
"Insurance Co. Phone" => @iform.insurancecompany_ph,
"Insurance Co. Phone2" => @iform.insurancecompany_ph_sec,
"Ins_Relation_2" => @iform.insureds_relation_sec,
"Orthocoverage_#{@orthocoverage2}2" => "Yes",
"Dentalcoverage_#{@dentalcoverage2}2" => "Yes",

"Insurance Co Areacode_2" => @iform.insurancecompany_ph_sec,
"Group # Plan, Local or Policy2" => @iform.group_sec,
"InsuredBday_" => @iform.insureds_birthdate,
"InsBday_1" => @iform.insureds_birthdate_sec,
"Wk_areacode" => @iform.emergencyperson_wkph,
"emergency_phone_wk" => @iform.emergencyperson_wkph,
"emergency_phone_hm" => @iform.emergencyperson_hmph,
"Hm_areacode" => @iform.emergencyperson_hmph,
"Persdoc_yes" => @iform,
"Persdoc_no" => @iform,
"Physician_areacode" => @iform.physicians_ph,
"Physician_phone" => @iform.physicians_ph,
"Today&#8217;s Date" => @iform.todaydate,
"Insurance Co Name" => @iform.insurancecompany,
"I prefer to be called" => @iform.preferredname,
"Insurance Co Address" => @iform.insurancecompany_add,
"Group #  Plan, Local or Policy" => @iform.group,
"Insured&#8217;s Name" => @iform.insureds_name,
"Insured&#8217;s SS" => @iform.insureds_SSN,
"Insured&#8217;s Employer" => @iform.insureds_employer,
"Insurance Co Name_2" => @iform.insurancecompany_sec,
"How long there" => @iform.empduration,
"Occupation" => @iform.occupation,
"Insurance Co Address_2" => @iform.insurancecompany_add_sec,
"Where &amp; when are best times to reach you" => @iform.besttime_reachyou,
"Whom may we Thank for referring you" => @iform.personreferredyou,
"Other family members seen by us" => @iform.familyvisited,
"General Dentist" => @iform.generaldentist,
"Insured&#8217;s Name_2" => @iform.insureds_name_sec,
"Relation_3" => @iform,
"Last Visit Date" => @iform.lastvisitdate,
"Insured&#8217;s SS_2" => @iform.insureds_SSN_sec,
"Insured&#8217;s Employer_2" => @iform.insureds_employer_sec,
"His  Her Name_2" => @iform.nursing,
"Relation_4" => @iform,
"Person Responsible for Account" => @iform.responsibleperson_name,
"Billing Address" => @iform.responsibleperson_billingadd,
"Physician&#8217;s Name" => @iform.physicians_name,
"Relation" => @iform.responsibleperson_relation,
"Date of last visit" => @iform.physician_lastvisitdate,
"Health_#{@cur_phyhealth}" => "Yes",
"Physician_#{@underphysician}" => "Yes",
"Please explain" => @iform.why_underphysician,
"Drugs_#{@drugs}" => "Yes",

"Are you taking any prescription  over-the-counter drugs" => @iform.prescriptionlist,
"Pills_#{@pills}" => "Yes",
"Pregnant_#{@pregnant}" => "Yes",
"Week#" => @iform.pregnancyweek,
"Nursing_#{@nursing}" =>  "Yes",
"Bleeding #{@abnormalbleeding}" => "Yes",
"Anemia #{@anemia}" => "Yes",
"Bones #{@bones}" => "Yes",
"Asthma #{@asthama_or_arthritis}" => "Yes",
"Transfusion #{@bloodtransfusion}" => "Yes",
"Cancer #{@cancer_or_chemotherepy}" => "Yes",
"Congenital Heart Defect #{@congenital_heartdefect}" => "Yes",
"Diabetes #{@diabetes}" => "Yes",
"Difficulty Breathing #{@difficultybreathing}" => "Yes",
"Drug Abuse #{@drug_or_alcoholabuse}" => "Yes",
"Emphysema #{@emphysema}" => "Yes",
"Epilepsy #{@epilepsy_or_seizures_or_fainting}" => "Yes",
"Fever Blisters #{@feverblisters_or_herpes}" => "Yes",
"Glaucoma #{@glaucoma}" => "Yes",
"Heart Attack #{@heartattack_or_stroke}" => "Yes",
"Heart Murmur #{@heartmurmur}" => "Yes",
"Heart Surgery #{@heartsurgery_or_pacemaker}" => "Yes",
"Hemophilia #{@hemophilia}" => "Yes",
"Hepatitis #{@hepatitis}" => "Yes",
"Blood Pressure #{@high_or_lowbloodpressure}" => "Yes",
"HIV #{@HIV_or_AIDS}" => "Yes",
"Hospitalization #{@hospitalized_reason}" => "Yes",
"Kidney #{@kidneyproblems}" => "Yes",
"MVP #{@mitralvalveprolapse}" => "Yes",
"Phychiatric #{@psychiatricproblems}" => "Yes",
"Radiation #{@radiationtreatment}" => "Yes",
"Rheumatic Fever #{@rheumatic_or_scarletfever}" => "Yes",
"Headaches #{@severe_or_frequentheadaches}" => "Yes",
"Shingles #{@shingles}" => "Yes",
"Sickle Cell #{@sicklecelldisease_or_traits}" => "Yes",
"Sinus #{@sinusproblems}" => "Yes",
"TB #{@tuberculosis}" => "Yes",
"Ulcer #{@ulcers_or_colitis}" => "Yes",
"Venereal Disease #{@venerealdisease}" => "Yes",

"Any serious medical conditions" => @iform.serious_medicalconditions,
"Aspirin #{@aspirin}" => "Yes",
"Metals #{@venerealdisease}" => "Yes",
"Codeine #{@aspirin}" => "Yes",
"Anesthetics #{@dentalanesthetics}" => "Yes",
"Erythromycin #{@erythromycin}" => "Yes",
"Latex #{@latex}" => "Yes",
"Penicillin #{@penicillin}" =>"Yes",
"Tetracycline #{@tetracycline}" => "Yes",
"Other #{@other}" => "Yes",
"Allergic" => @iform.drugslist_allergicto,
"What do you want" => @iform.concerns_accomplished_byorthodontics,
"Evaluated_#{@undogone_orthodontictreatment}" => "Yes",
"Previous problems_#{@problemwith_previousdentalwork}" => "Yes",
"TMJ_#{@pain_jawjoint}" => "Yes",


"Dental Health_#{@current_dentalhealth}" => "Yes",
"Smile_#{@likeyoursmile}" => "Yes",
"Gums bleed_#{@gumsbleed}" => "Yes",
"Mouth" => @iform,
"Teeth" => @iform,
"Chin" => @iform,
"Any speech problems" => @iform.speechproblems,
"Mouth breather_#{@breaththrumouth}" => "Yes",
#"While Awake" => @iform.breaththrumouth_awake_sleep,
#"While Asleep" => @iform.breaththrumouth_awake_sleep,
"Teeth_#{@missing_or_extra_permanantteeth}" => "Yes",
"Phen-Fen_#{@evertaken_phenfen}" => "Yes",
"When taken Phen-Fen" => @iform.when_phenfen,
"Tobacco_#{@smoke_or_usetobacco}" => "Yes",
"You City" => @iform.city
})


        format.html { redirect_to(@iform, :notice => 'form was successfully submitted.') }
        format.xml  { render :xml => @iform, :status => :created, :location => @iform }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @iform.errors, :status => :unprocessable_entity }
      end
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
    
end