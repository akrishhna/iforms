class Patient < ActiveRecord::Base
  belongs_to :doctor 
  validates_presence_of :firstname, :lastname
  validates_format_of :firstname, :lastname, :with => /^[A-Za-z .-]+$/ , :unless => "firstname.blank? or lastname.blank?"
  #has_many :appointments
end
