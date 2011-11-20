class AppointmentsController < ApplicationController
  def new
    @appointment = Appointment.new
    #Form.create(:formname => "Steiner_Ranch_Adult", :doctor_id => 1, :formpath => "http://localhost:3000/iforms/new")
  end

  def create
    @appointment = Appointment.new(params[:appointment])
     respond_to do |format|
       @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
       @appointment.doctor_id = @doctor.id
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
       @formids = params[:form_ids]
       @formids.each do |i|
       @form = Form.find(i)
       Appformjoin.create(:appointment_id => @appointment.id, :form_id => i, :formname => @form.formname)
       end   
       @appointment.save
       Notifier.appointment_confirmation(@appointment).deliver
       format.html { redirect_to(doctors_path, :id => nil, :notice => "appointment mail sent successfully to #{@appointment.firstname}") }
       format.xml  { render :xml => @appointment, :status => :created, :location => @appointment }
      else
      format.html { render :action => "new" }
      format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
     end
      end
  end
      
  def index
   @appointments = Appointment.all 
  end

  def show
    @appointment = Appointment.find(params[:id])
    @appformjoins = Appformjoin.where("appointment_id = ?", params[:id])
    @appformjoins.each do |i|
     @formsubmittedtime = time_conversion(i)
    end
  end
  
  def destroy
   @appointment = Appointment.find(params[:id])
   @appointment.destroy
   respond_to do |format|
      format.html { redirect_to doctors_url }
      format.xml  { head :ok }
   end
  end
  
  def time_conversion(i) 
   if i.formsubmittedtime
   formsubmittedtime_date = i. formsubmittedtime.strftime("%Y-%m-%d")
   formsubmittedtime_hrs = i.formsubmittedtime.strftime("%H")
   formsubmittedtime_min = i.formsubmittedtime.strftime("%M")
   formsubmittedtime_hrs_int = formsubmittedtime_hrs.to_i 
   var = 12
   if var<=formsubmittedtime_hrs_int
   formsubmittedtime_hrs = (formsubmittedtime_hrs_int - var).to_s
   am_pm = "PM"
   formsubmittedtime = formsubmittedtime_date+" "+formsubmittedtime_hrs+":"+formsubmittedtime_min+" "+am_pm 
   else 
   am_pm = "AM" 
   formsubmittedtime = formsubmittedtime_date+" "+formsubmittedtime_hrs+":"+formsubmittedtime_min+" "+am_pm 
   end 
   end 
   return formsubmittedtime 
  end 
  
end
