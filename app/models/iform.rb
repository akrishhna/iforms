class Iform < ActiveRecord::Base
 
  # validates_presence_of :email, :firstname, :lastname, :middlename, :prefix, :sex, :ssn, :homeadd, :state, :zip, :birthdate
  #   validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  #  validates_format_of :firstname, :lastname, :middlename, :preferredname, :city, :state, :occupation, :referal, :familyvisited, :with => /^[a-zA-Z]+$/ 
  # validates_format_of :zip, :with => /^\d{5}(-?\d{4})?$/ 
  # validates_format_of :homeph, :workph, :with => /^\d{10}(-?\d{9})?$/
  # validates_format_of :workext, :with => /^\d{4}(-?\d{3})?$/
  # validate :validate_birthdate
  # validate :validate_lastvisitdate
  # validate :validate_todaydate
  # validate :validate_age
  # 
  # def validate_age
  #   age = Date.today.year - birthdate.year
  #   age -= 1 if Date.today < birthdate + age.years # birthdate.month > now.month and birthdate.day > now.day
  #   self.age = age
  # end
  # def validate_todaydate
  # if !todaydate == Date.today
  #   errors.add(:todaydate, "please enter valid date")
  # end
  # end
  # def validate_lastvisitdate
  #   if lastvisitdate >= Date.today
  #     errors.add(:lastvisitdate, "please enter valid date")
  #   end 
  # end
  # def validate_birthdate
  #   if birthdate > Date.today
  #     errors.add(:birthdate, "please enter valid date")
  #   end 
  # end
end
