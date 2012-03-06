class Patient < ActiveRecord::Base
  belongs_to :user
  has_many :appointments

  validates_presence_of :firstname, :lastname
 # validates_format_of :firstname, :lastname, :with => /^[A-Za-z .-]+$/ , :unless => "firstname.blank? or lastname.blank?"

end
