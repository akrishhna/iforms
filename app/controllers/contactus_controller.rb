class ContactusController < ApplicationController
  def new
    @contactus = Contactus.new
  end
  
  def create
    @contactus = Contactus.new(params[:contactus])
    respond_to do |format|
    if @contactus.save and verify_recaptcha
      format.html { redirect_to(deviseroles_path, :id => nil, :notice => 'Profile saved successfully.') }
      format.xml  { render :xml => @contactus, :status => :created, :location => @contactus }
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @contactus.errors, :status => :unprocessable_entity }
    end
  end
  end
  
  def index
    respond_to do |format|
         format.html { redirect_to '/contact' }
         format.xml  { head :ok }
    end
  end

end
