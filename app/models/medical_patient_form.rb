class MedicalPatientForm < ActiveRecord::Base
  belongs_to :medical_appointment
end
