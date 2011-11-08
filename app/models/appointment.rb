class Appointment < ActiveRecord::Base
  belongs_to :doctor
  has_one :iform
  validates_presence_of :firstname, :lastname, :email, :datetime
end
