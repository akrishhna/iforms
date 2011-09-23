class Patient < ActiveRecord::Base
  belongs_to :doctor
end
