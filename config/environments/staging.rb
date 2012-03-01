Iforms::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  ActionMailer::Base.delivery_method = :smtp
  #ActionMailer::Base.perform_deliveries = true
  #ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,  
    :address            => 'smtpout.secureserver.net',
    :port               => 80,
    :domain             => 'ifor.ms', #you can also use google.com
    :authentication     => :plain,
    :user_name          => 'iforms-noreply@ifor.ms',
    :password           => 'wK7W5cd6'
 }
  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = false

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"
  #file paths
  config.after_initialize do 
    Configuration.pdftk_path = '/usr/bin/pdftk'
    Configuration.pdffiles_path = '/home/railsapps/iforms_staging/current/public/pdffiles/'
    Configuration.csvfiles_path = '/home/railsapps/iforms_staging/current/public/csvfiles/'
    Configuration.notifier_path = '50.57.138.165:8082'
  end 

  
  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  #config.active_support.deprecation = :notify
  
      config.action_view.debug_rjs             = true
   
      config.action_mailer.default_url_options = { :host => '50.57.138.165:8082' }
      
      # Don't care if the mailer can't send
      config.action_mailer.raise_delivery_errors = false

      # Print deprecation notices to the Rails logger
      config.active_support.deprecation = :log

      # Only use best-standards-support built into browsers
      config.action_dispatch.best_standards_support = :builtin
end
