class IformsController < ApplicationController
  # GET /iforms
  # GET /iforms.xml
  def index
    @iforms = Iform.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iforms }
    end
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
    @iform = Iform.new(params[:iform]) 
            
   str = @iform.lastname + "_" + @iform.firstname
   pathx = "/pdffiles/#{str}.pdf"
    @iform.path = pathx
    respond_to do |format|
      if @iform.save
        path = "/home/railsapps/iforms/public/pdffiles/#{str}.pdf"
        namestr = @iform.lastname << "  " + @iform.firstname + "  " + @iform.middlename
        @pdftk = PdftkForms::Wrapper.new('/usr/bin/pdftk')
        @pfields = @pdftk.fields('/home/railsapps/iforms/public/pdffiles/iform.pdf')
               #@pfields.each do |pff|
                 #puts pff.name
       @pdftk.fill_form('/home/railsapps/iforms/public/pdffiles/iform.pdf', path, {'MS' => @iform.prefix,
         'Name'=>namestr,
         'You Female'=>@iform.sex,
         'Your E-Mail Address'=> @iform.email,
         'You Birthdate'=> @iform.birthdate,
         'You Age'=>@iform.age,
         'You SS'=>@iform.ssn,
         'You Home Address'=>@iform.homeadd,
         'You State'=>@iform.state,
         'You Zip'=>@iform.zip})
        format.html { redirect_to(@iform, :notice => 'Iform was successfully created.') }
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
end
