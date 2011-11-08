class Doctor < ActiveRecord::Base
  belongs_to :user
  has_many :forms
  has_many :patients
  has_many :appointments
  
  validates_presence_of :firstname, :lastname
end
