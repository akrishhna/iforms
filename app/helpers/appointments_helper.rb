module AppointmentsHelper
  def link(f)
    render "appointments/checkbox", :f => f
  end
end
