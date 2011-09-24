class DeviserolesController < ApplicationController
  before_filter :authenticate_user!
  def index
     case current_user.role
          when 'patient'
            redirect_to :controller=>"patients", :action=>"index"
          when 'doctor'
            redirect_to :controller=>"doctors", :action=>"index"
          when 'admin'
            redirect_to :controller=>"admin", :action => "index"
          else
          render :text => "some error"
     end

  end
    
end
