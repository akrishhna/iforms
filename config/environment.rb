# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Iforms::Application.initialize!

ENV['RECAPTCHA_PUBLIC_KEY'] = '6LdtBswSAAAAAPSp0BW9SJa7WkB5o1SVATcXCLf9'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6LdtBswSAAAAAOhw8Wtd1aHFEqAblE6cxrmosiXV'


# Girl Scouts Paths
CENTRAL_TEXAS_FORM_PATH = "#{PDFFILES_PATH}Central_Texas_Form.pdf"
CENTRAL_TEXAS_READ_ONLY_FORM_PATH = "#{PDFFILES_PATH}Central_Texas_Read_Only.pdf"

DIAMONDS_FORM_PATH = "#{PDFFILES_PATH}Diamonds_Form.pdf"
DIAMONDS_READ_ONLY_FORM_PATH = "#{PDFFILES_PATH}Diamonds_Read_Only.pdf"

ALASKA_FORM_PATH = "#{PDFFILES_PATH}Alaska_Form.pdf"
ALASKA_READ_ONLY_PATH = "#{PDFFILES_PATH}Alaska_Read_Only.pdf"

ARIZONA_CACTUS_PINE_FORM_PATH = "#{PDFFILES_PATH}Arizona_Cactus_Pine_Form.pdf"
ARIZONA_CACTUS_PINE_READ_ONLY_PATH = "#{PDFFILES_PATH}Arizona_Cactus_Pine_Read_Only.pdf"

BLACK_DIAMOND_FORM_PATH = "#{PDFFILES_PATH}Black_Diamond.pdf"
BLACK_DIAMOND_READ_ONLY_PATH = "#{PDFFILES_PATH}Black_Diamond_Read_Only.pdf"


CALIFORNIA_CENTRAL_COAST_FORM_PATH = "#{PDFFILES_PATH}California's_Central_Coast_Form.pdf"
CALIFORNIA_CENTRAL_COAST_READ_ONLY_PATH = "#{PDFFILES_PATH}California's_Central_Coast_Read_Only.pdf"


# End  Girl Scouts Paths

CAPITAL_MEDICAL_CLINIC_FORM_PATH = "#{PDFFILES_PATH}Capital_Medical_Clinic.pdf"
CAPITAL_MEDICAL_CLINIC_READ_ONLY_FORM_PATH = "#{PDFFILES_PATH}Capital_Medical_Clinic_Read_Only.pdf"

BOY_SCOUTS_ACTIVITY_CONSENT_FORM_PATH = "#{PDFFILES_PATH}Boy_Scouts_Activity_Consent_From.pdf"
BOY_SCOUTS_ACTIVITY_CONSENT_READ_ONLY_FORM_PATH = "#{PDFFILES_PATH}Boy_Scouts_Activity_Consent_From_Read_Only.pdf"

RISING_STARS_PEDIATRIC_DENTISTRY_FORM_PATH  = "#{PDFFILES_PATH}Rising_Stars_Pediatric_Dentistry.pdf"
RISING_STARS_PEDIATRIC_DENTISTRY_READ_ONLY_FORM_PATH  = "#{PDFFILES_PATH}Rising_Stars_Pediatric_Dentistry_Read_Only.pdf"


