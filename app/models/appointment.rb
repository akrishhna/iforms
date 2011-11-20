class Appointment < ActiveRecord::Base
  belongs_to :doctor
  has_one :iform
  validates_presence_of :firstname, :lastname, :email, :date, :time_hrs, :time_min, :AM_PM
  validates_format_of :firstname, :lastname, :with => /^[a-zA-Z]+$/ , :unless => "firstname.blank? or lastname.blank?"
  validates_format_of :email,:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i , :unless => "email.blank?"

  validate :validate_date
      def validate_date
        if !date.blank? and date <= Date.today
          errors.add(:date, "can't be in the past")
        end
      end
    
end
