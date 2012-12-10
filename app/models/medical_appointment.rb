class MedicalAppointment < ActiveRecord::Base

  belongs_to :doctor
  belongs_to :user
  has_many :medical_patient_forms
  validates_presence_of :firstname, :lastname, :email,:location
  validates_presence_of :appointment_date_time, :message => "is not valid"
  validates_format_of :firstname, :lastname, :with => /^[a-zA-Z\d\s\-&"']+$/, :unless => "firstname.blank? or lastname.blank?"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :unless => "email.blank?"

  validate :validate_date

   def self.paging(page, id)
    paginate :per_page => 10, :page => page
   end

  def validate_date

    if !appointment_date_time.blank? and appointment_date_time < Date.today and appointment_date_time != Date.today
      errors.add(:appointment_date_time, "is not valid")
    end
  end
end
