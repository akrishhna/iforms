class DoctorsController < ApplicationController
  #before_filter :allow_doctors
  def index
    @iforms = Iform.all
    #@patients=Patient.all(:conditions => "doctor_id = $doctorid")
  end

  def new
    @doctor = Doctor.new
  end
  def create
    @doctor = Doctor.find(params[:doctor])
    $doctorid =@doctor.id
    if params[:doctor].present?
      redirect_to(@doctor)
    else
      render :text => "id not found"
    end
  end
  def show
    @doctor = Doctor.find(params[:id])
  end

end
