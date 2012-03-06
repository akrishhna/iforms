class Patient::ProfileController < PatientController

  def index

  end

  def edit
    @patient = patient
  end

  def update
    @patient = patient
    if @patient.update_attributes(params[:patient])
      flash[:success] = "Profile details updated successfully."
      redirect_to edit_patient_profile_path
    else
      flash[:error] = "Something wrong while updating the record, Please try again."
      render :action => :edit
    end
  end

  def change_password

  end

  def update_password
    @user = current_user
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      flash[:notice] = "Your Password has been updated!"
      redirect_to root_path
    else
      flash[:error] = "Failed to update password please try again"
      render :action => :change_password
    end

  end
end
