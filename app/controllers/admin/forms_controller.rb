class Admin::FormsController < AdminController

  def index
    @forms = Form.includes(:doctor).all
    @doctors = @forms.group_by { |f| f.doctor.doctorname }
  end

  def new
    @form = Form.new
    @doctors = Doctor.all
  end

  def create
    @form = Form.new(params[:form])
    @doctors = Doctor.all

    if @form.save
      flash[:success] = "Form is created successfully."
      redirect_to admin_forms_path
    else
      flash[:error] = "Something wrong while creating form, Please try again."
      render :action => :new
    end

  end
end
