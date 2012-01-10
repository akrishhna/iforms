# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Iforms::Application.initialize!

#config.action_controller.session_store = :active_record_store
 ENV['RECAPTCHA_PUBLIC_KEY'] =  '6LdtBswSAAAAAPSp0BW9SJa7WkB5o1SVATcXCLf9'
 ENV['RECAPTCHA_PRIVATE_KEY'] = '6LdtBswSAAAAAOhw8Wtd1aHFEqAblE6cxrmosiXV'