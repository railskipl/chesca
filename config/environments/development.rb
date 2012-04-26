# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
end

PAYPAL_API_USERNAME = 'pfayol_1253680422_biz_api1.gmail.com'
PAYPAL_API_PASSWORD = '1253680432'
PAYPAL_API_SIGNATURE = 'AGeouGp0LqMfyxD.FlHOOW06N-EQACWVENZhyHZ1rXoZUqpVrPqR.ifY'

ADMIN_PASSWORD = ''
#delivery options
ENV['next_day'] =  '6.5'
ENV['euro_ireland'] = '11'
ENV['euro_mainland'] = '15'
ENV['austratia'] = '30'

ENV["fb_app_id"] = "114662605303475"
ENV["fb_app_admin_id"] = "645941888"

#GENERATE_WEBGAINS_CODE = "asdasda"
