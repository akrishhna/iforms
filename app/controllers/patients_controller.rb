class PatientsController < ApplicationController
  #before_filter :allow_patients
  def index
  end

  def new
    @patient = Patient.new
  end
  def create
    #@patient =Patient.new(params[:patient])
    @doctor = Doctor.find(params[:doctor])
    Patient.create(:doctor_id=>@doctor.id)
    if params[:doctor].present?
      redirect_to(@doctor)
    end
  end
  def show
    @patient = Patient.find(params[:id])
  end

end
