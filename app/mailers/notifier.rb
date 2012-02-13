class Notifier < ActionMailer::Base
  default :from => "iforms-noreply@ifor.ms"
  def appointment_confirmation_notification(appointment, doctor)
      @appointment = appointment
      @doctor = doctor
      mail(:to => @appointment.email, :subject => "Appointment confirmation")
  end
  
  def form_submission_notification(appointment, formname, iform)
      @appointment = appointment
      @formname = formname
      @iform = iform
      @doctor = @appointment.doctor
      @user = User.find(@doctor.user_id)
      mail(:to => @user.email, :subject => "Form received from #{@appointment.firstname} #{@appointment.lastname}")
  end
  
  def edit_form_submission_notification(appointment, formname, iform)
      @appointment = appointment
      @formname = formname
      @iform = iform
      @doctor = @appointment.doctor
      @user = User.find(@doctor.user_id)
      mail(:to => @user.email, :subject => "Form edited by #{@appointment.firstname} #{@appointment.lastname}")
  end
  
  def contactus_form_notification(name, email, subject, body)
    @name = name
    @email = email
    @subject = subject
    @message = body
    mail(:to => "michael.whitworth@ifor.ms", :subject => @subject)
  end
  
  def confirmation_instructions_notification(user)
    @user = user
    mail(:to => @user.email, :subject => "Confirmation Instructions")
  end
  
  def resend_confirmation_notification(user)
  @user = user
  mail(:to => @user.email, :subject => "Resending Confirmation Instructions")
  end
end
