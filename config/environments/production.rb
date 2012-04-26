# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
config.log_level = :warn

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
  ActiveMerchant::Billing::Base.mode = :production

  ::PAYPAL_API_USERNAME = 'dominic.green_api1.chesca1424.co.uk'
  ::PAYPAL_API_PASSWORD = 'HQS2F7639R8YW5RC'
  ::PAYPAL_API_SIGNATURE = 'A0CQcI5i7aolcJc-BNZ.5w3el3MBAqPKRJSg6BhoDdjIB0uVooo-qiV.'
end


# You can't have booleans in ENV apparently, so use a constant instad
#ENV['GENERATE_WEBGAINS_CODE'] = true

GENERATE_WEBGAINS_CODE = true
ENV['GOOGLE_ANALYTICS_TRACKING_CODE'] = 'UA-4274159-4'
ENV['COMPANY'] = "Chesca"
ENV['CITY'] = "City"
ENV['STATE_OR_PROVINCE'] =  ""
ENV['COUNTRY'] = "USA"

#delivery options
ENV['next_day'] =  '6.5'
ENV['euro_ireland'] = '11'
ENV['euro_mainland'] = '15'
ENV['austratia'] = '30'

ADMIN_PASSWORD = 's80838'

ENV["fb_app_id"] = "190961040976819"
ENV["fb_app_admin_id"] = "100001432701169"
