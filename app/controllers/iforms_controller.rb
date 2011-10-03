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
       
        namestr = @iform.lastname << "  " + @iform.firstname + "  " + @iform.middlename
        pdftkpath = "#{Configuration.pdftk_path}"
        pdffilepath = "#{Configuration.pdffiles_path}"
        path = pdffilepath + "#{str}.pdf"
        
        @pdftk = PdftkForms::Wrapper.new(pdftkpath)
        @pfields = @pdftk.fields(pdffilepath + 'iform.pdf')
        @pfields.each do |pff|
            puts pff.name, pff.field_type, pff.flags
        end
       @pdftk.fill_form(pdffilepath + 'iform.pdf', path, {'MS' => @iform.prefix,
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
  
  
  def createFDF(info)
      data = "%FDF-1.2\x0d%\xe2\xe3\xcf\xd3\x0d\x0a"; # header
      data += "1 0 obj\x0d<< " # open the Root dictionary
      data += "\x0d/FDF << " # open the FDF dictionary
      data += "/Fields [ " # open the form Fields array

        info.each { |key,value|
            if value.class == Hash
                value.each { |sub_key,sub_value|
                    data += '<< /T (' + key + '_' + sub_key + ') /V '
                    data += '(' + sub_value.to_s.strip + ') /ClrF 2 /ClrFf 1 >> '
                }
            else
                data += '<< /T (' + key + ') /V (' + value.to_s.strip + ') /ClrF 2 /ClrFf 1 >> '
            end
        }

      data += "] \x0d" # close the Fields array
      data += ">> \x0d" # close the FDF dictionary
      data += ">> \x0dendobj\x0d" # close the Root dictionary

      # trailer note the "1 0 R" reference to "1 0 obj" above
      data += "trailer\x0d<<\x0d/Root 1 0 R \x0d\x0d>>\x0d" 
      data += "%%EOF\x0d\x0a" 
      afile = File.new("/pdffiles/rails_" + rand.to_s, "w") << data
      afile.close
      return afile
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
