class DeviserolesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @@patientname = nil
    @@doctorname = nil
     case current_user.role
       when 'patient'
       @patient = Patient.all(:conditions => ['user_id = ?', current_user.id]).first
       @@patientname = @patient.firstname
       if @@patientname.blank?
         redirect_to :controller=>"patients", :action=>"new"
       else
         redirect_to :controller=>"patients", :action=>"index"
       end
       
       when 'doctor'
       @doctor = Doctor.all(:conditions => ['user_id = ?', current_user.id]).first
       @@doctorname = @doctor.firstname
       if @@doctorname.blank?
         redirect_to :controller=>"doctors", :action=>"new"
       else
         redirect_to :controller=>"doctors", :action=>"index"
       end 
       
       when 'admin'
       redirect_to :controller=>"admin", :action => "index"
     else
       render :text => "some error"
     end
  end
      
end
