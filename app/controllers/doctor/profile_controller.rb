class Doctor::ProfileController < DoctorController

  def index

  end

  def edit
    @doctor = doctor
    if @doctor.nil?
      d = Doctor.new
      d.user_id = current_user.id
      d.save(:validate => false)
      @doctor = d
    end

  end

  def update
    @doctor = doctor
    if @doctor.update_attributes(params[:doctor])
      flash[:success] = "Profile details updated successfully."
      redirect_to edit_doctor_profile_path
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
