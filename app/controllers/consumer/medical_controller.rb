class Consumer::MedicalController < ApplicationController
  def index
    session["consumer_tab_index"] = 5
    @appointments = ''
   render :layout => false if request.xhr?
  end

  def edit_medical_form
    session["consumer_tab_index"] = 5

    @medical = MedicalPatientForm.find_by_id(params[:id])
  end

  def update

  end
end
