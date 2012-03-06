class Admin::DoctorsController < AdminController

  def index
    @doctors = Doctor.includes(:user).all
  end

  def new
    @user = User.new
    @user.build_doctor
  end

  def create
    @user = User.new(params[:user])
    @user.build_doctor(params[:user][:doctor_attributes])

    if @user.save
      UserRole.create({:user_id => @user.id, :role_id => 2})
      flash[:success] = 'New doctor is created successfully.'
      redirect_to admin_doctors_path
    else
      flash[:error] = 'Something wrong while creating new doctor, Please try again.'
      render :action => :new
    end
  end
end
