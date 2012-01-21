class AppointmentsController < ApplicationController
  before_filter :is_doctor?, :except =>["show"]
  #before_filter :is_admin?, :only => ["show"]
  def new
    @appointment = Appointment.new
    #Form.create(:formname => "Bastrop_Child", :doctor_id => 2, :formpath => "http://50.57.138.165/iforms/new")
    #Form.create(:formname => "Steiner_Ranch_Adult", :doctor_id => 2, :formpath => "http://localhost:3000/iforms/new")
  end

  def create
    @appointment = Appointment.new(params[:appointment])
     respond_to do |format|
       @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
       @appointment.doctor_id = @doctor.id
       a=""
       @formids = params[:form_ids]
       if @formids
       @formids.each do |i|
         @form = Form.find(i) 
         a<<@form.formname+","
       end
       end
        @appointment.formname = a
        if !@appointment.time_hrs.empty? and !@appointment.AM_PM.empty? and !@appointment.time_min.empty?
           @appointment.appointment_time = @appointment.time_hrs+@appointment.AM_PM+@appointment.time_min
        end
      if @appointment.save 
       @user = User.all(:conditions => ['email = ?', @appointment.email]).first
       if @user
       @patient = Patient.all(:conditions => ['user_id = ?', @user.id]).first
       end
       #-- recent changes
       if @patient
       @appointment.patient_id = @patient.id
       end
       #changes end
       @i = @appointment.doctor
       @i.doctorname
       @appointment.doctorname = @i.doctorname
       @appointment.timesent = Time.now
       @appointment.save
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
       Notifier.appointment_confirmation_notification(@appointment).deliver
       format.html { redirect_to(doctors_path, :id => nil, :notice => "Appointment confirmation email sent successfully to #{@appointment.email}") }
       format.xml  { render :xml => @appointment, :status => :created, :location => @appointment }
      else
      format.html { render :action => "new" }
      format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
     end
  end
  end
      
  def index
   @appointments = Appointment.all
   respond_to do |format|
       format.html { redirect_to new_appointment_path }
       format.xml  { head :ok }
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
       Notifier.appointment_confirmation_notification(@appointment).deliver
       format.html { redirect_to(doctors_path, :notice => 'Appointment details resent successfully.') }
       format.xml  { head :ok }
     else
       format.html { render :action => "edit" }
       format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
     end
     end
  end
  
  def destroy
   @appointment = Appointment.find(params[:id])
  # @appointment.destroy
   respond_to do |format|
      format.html { redirect_to doctors_url }
      format.xml  { head :ok }
   end
  end
  
  
end
