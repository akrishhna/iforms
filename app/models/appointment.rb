class Appointment < ActiveRecord::Base
  belongs_to :doctor
  has_many :iforms
  has_one :childform
  validates_presence_of :firstname, :lastname, :email , :responsible_party
  validates_presence_of :appointment_time, :message => "is not valid"
  validates_format_of :firstname, :lastname,:responsible_party, :with => /^[a-zA-Z\d\-&"']+$/, :unless => "firstname.blank? or lastname.blank?"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :unless => "email.blank?"


  validate :validate_date

  def validate_date
    if !date.blank? and date<Date.today
      errors.add(:date, "is not valid")
    end
  end

  validate :validate_time

  def validate_time
    if !date.blank? and date<Date.today
      if !appointment_time.blank?
        hrs = Time.now.strftime("%I")
        min = Time.now.strftime("%M")
        p time_hrs.to_i<hrs.to_i, time_min.to_i<min.to_i
        if time_hrs.to_i<hrs.to_i && time_min.to_i<min.to_i
          errors.add(:appointment_time, "can't be in past")
        else
          if time_hrs.to_i<=hrs.to_i && time_min.to_i<min.to_i
            errors.add(:appointment_time, "can't be in past")
          end
        end
      end
    end
  end

  def self.paging(page, id)
    paginate :per_page => 10, :page => page

  end

end
