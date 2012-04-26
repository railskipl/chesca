# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!

config.action_mailer.delivery_method = :sendmail

# Replace this with actual Paypal data once ready for production!
config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test

  ::PAYPAL_API_USERNAME = 'pfayol_1253680422_biz_api1.gmail.com'
  ::PAYPAL_API_PASSWORD = '1253680432'
  ::PAYPAL_API_SIGNATURE = 'AGeouGp0LqMfyxD.FlHOOW06N-EQACWVENZhyHZ1rXoZUqpVrPqR.ifY'
end
GENERATE_WEBGAINS_CODE = true

ADMIN_PASSWORD = 's80838'
#delivery options
ENV['next_day'] =  '6.5'
ENV['euro_ireland'] = '11'
ENV['euro_mainland'] = '15'
ENV['austratia'] = '30'

ENV["fb_app_id"] = "114662605303475"
ENV["fb_app_admin_id"] = "645941888"

