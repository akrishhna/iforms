class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?

 protected
  def is_doctor?
    unless current_user.role=="doctor"
      flash[:notice]="unauthorized access"
      redirect_to :controller=> "deviseroles", :action=>"index"
      false
    end
  end
 protected 
  def is_patient?
    unless current_user.role=="patient"
      flash[:notice]="unauthorized access"
      redirect_to :controller=> "deviseroles", :action=>"index"
      false
    end
  end
  
  def admin?
    current_user.admin?
    #email == "ashwini.patlola@gmail.com" and current_user.role == "admin"
  end
 

end
