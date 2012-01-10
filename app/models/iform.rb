class Iform < ActiveRecord::Base
 belongs_to :appointment
 # after_save :update_appformjoin
 #  
 # def self.update_appformjoin(appformjoin)
 #  @appformjoin = appformjoin 
 # end
 # 
 # def update_appformjoin
 # if @appformjoin.status == "pending"
 #    @appformjoin.status = ""
 #    @appformjoin.save
 # end
 # end
 #attr_writer :current_step
 
 #validates_presence_of :Self_Name_First, :Self_Name_Last #:if => lambda { |o| o.current_step == "aboutyou" }
 #validates_presence_of :spousename, :spouse_employer, :if => lambda { |o| o.current_step == "spouseinformation" }
 
 
 # def current_step
#      @current_step || steps.first
#  end
#   
#    def steps
#      %w[aboutyou spouceinformation orthodonticinsurance medicalhistory dentalhistory]
#    end
#    def next_step
#     self.current_step = steps[steps.index(current_step)+1]
#    end
# 
#    def previous_step
#      self.current_step = steps[steps.index(current_step)-1]
#    end
#    def first_step?
#      current_step == steps.first
#    end
# 
#    def last_step?
#      current_step == steps.last
#    end
# 
#    def all_valid?
#      steps.all? do |step|
#        self.current_step = step
#        valid?
#      end
#      
#    end
  
 
  # validates_presence_of :email, :firstname, :lastname, :middlename, :prefix, :sex, :ssn, :homeadd, :state, :zip, :birthdate
  #   validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  #  validates_format_of :firstname, :lastname, :middlename, :preferredname, :city, :state, :occupation, :referal, :familyvisited, :with => /^[a-zA-Z]+$/ 
  # validates_format_of :zip, :with => /^\d{5}(-?\d{4})?$/ 
  # validates_format_of :homeph, :workph, :with => /^\d{10}(-?\d{9})?$/
  # validates_format_of :workext, :with => /^\d{4}(-?\d{3})?$/
   #validate :Self_Birthdate
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
  # def selfbirthdate
  #       if selfbirthdate >= Date.today
  #         errors.add(:Self_Birthdate, "please enter valid date")
  #       end 
  #   end
  # 
   #validates_presence_of :Self_Name_First, :Self_Name_Honorific
  # validates_format_of :Self_Name_First, :Self_Name_Honorific, :with => /^[A-Za-z]+$/ , :unless => "Self_Name_First.blank? or Self_Name_Honorific.blank?"
  # validate :validate_Self_Birthdate
  #     def validate_Self_Birthdate
  #       if !Self_Birthdate.blank? and Self_Birthdate >= Date.today
  #         errors.add(:Self_Birthdate)
  #       end
  #     end
end
