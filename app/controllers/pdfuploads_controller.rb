class PdfuploadsController < ApplicationController
  require 'fastercsv'
  def index
    @pdfuploads = Pdfupload.all
  end

  def new
    @pdfupload = Pdfupload.new
  end
  
  def create
    @pdfupload = Pdfupload.new(params[:pdfupload])
    file_data = @pdfupload.file
     respond_to do |format|
    if @pdfupload.save
      if file_data.respond_to?(:path)
        pdftkpath = "#{Configuration.pdftk_path}"
        pdffilepath = "#{Configuration.pdffiles_path}"
        
        @pdftk = PdftkForms::Wrapper.new(pdftkpath)
        @pfields = @pdftk.fields(file_data.path)
        puts @pfields.length
        @pfields.each do |pff|
           Control.create(:name => pff.name, :controltype => pff.field_type, :pdfupload_id => @pdfupload.id)
            puts pff.name, pff.field_type
        end
      end
    flash[:notice]= 'file saved succusfully'
    format.html {redirect_to(@pdfupload)}
    else
    format.html {render :action => "new"}
    end
     end
   end

  def show
    @pdfupload = Pdfupload.find(params[:id])
    @controls = Control.paging(params[:page], params[:id])
  end

end
