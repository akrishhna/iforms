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
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true
  config.assets.enabled = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  #file paths
  config.after_initialize do
    # Configuration.pdftk_path = '/usr/bin/pdftk'
    #     Configuration.pdffiles_path = '/home/railsapps/iforms_staging/current/public/pdffiles/'
    #     Configuration.csvfiles_path = '/home/railsapps/iforms_staging/current/public/csvfiles/'
    #     Configuration.notifier_path = '50.57.138.165:8082'
  end

  PDFTK_PATH = '/usr/bin/pdftk'
  PDFFILES_PATH = '/home/railsapps/iforms_staging/current/public/pdffiles/'
  CSVFILES_PATH = '/home/railsapps/iforms_staging/current/public/csvfiles/'
  NOTIFIER_PATH = 'http://50.57.138.165:8082'

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "https://airwala.s3.amazonaws.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w(*.js *.css)

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  config.action_mailer.default_url_options = { :host => '50.57.138.165:8082' }

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end
