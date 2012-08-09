class Form < ActiveRecord::Base
  belongs_to :doctor

  validates_presence_of :doctor_id, :formname
  validates_uniqueness_of :formname, :scope => [:doctor_id]
end
