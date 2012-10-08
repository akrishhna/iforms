Iforms::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  ActionMailer::Base.delivery_method = :smtp
  #ActionMailer::Base.perform_deliveries = true
  #ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
      :enable_starttls_auto => true,
      :address => 'smtpout.secureserver.net',
      :port => 80,
      :domain => 'ifor.ms', #you can also use google.com
      :authentication => :plain,
      :user_name => 'iforms-noreply@ifor.ms',
      :password => 'wK7W5cd6'
  }

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # filepaths
  config.after_initialize do
    # Configuration.pdftk_path = '/usr/local/bin/pdftk'
    #     Configuration.pdffiles_path = "#{Rails.root}/public/pdffiles/"
    #     Configuration.csvfiles_path = '/Users/ashwinipatlola/railsapps/iforms/public/csvfiles/'
    #     Configuration.notifier_path = 'http://localhost:3000'
  end
    PDFTK_PATH = '/usr/local/bin/pdftk'
    PDFFILES_PATH = "#{Rails.root}/public/pdffiles/"
    CSVFILES_PATH = '/Users/ashwinipatlola/railsapps/iforms/public/csvfiles/'
    NOTIFIER_PATH = 'http://localhost:3000'
  

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
