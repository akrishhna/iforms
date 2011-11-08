class Notifier < ActionMailer::Base
  default :from => "info.emailsender@gmail.com"
  def appointment_confirmation(appointment)
      @appointment = appointment
      mail(:to => @appointment.email, :subject => "Appointment confirmation")
  end
end
