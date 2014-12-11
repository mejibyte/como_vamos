# Be sure to restart your server when you modify this file

# ENV['RAILS_ENV'] ||= 'production'

RAILS_GEM_VERSION = '2.3.18' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
   config.time_zone = 'Bogota'

   config.gem "googlecharts"
   # config.gem 'hoptoad_notifier'

   # Your secret key for verifying cookie session data integrity.
   # If you change this key, all old sessions will become invalid!
   config.action_controller.session = {
     :session_key => '_como_vamos_session',
     :secret      => 'b1cde27ebf941bed2de522a16279a616c9a81a816d3895a023bffa143421a035971560493ba79337e5e90976af04c8e06e368ffb86598025d6c81c7bb6dde9a2'
  }
end

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = HashWithIndifferentAccess.new(YAML::load(File.open("#{RAILS_ROOT}/config/smtp.yml"))[RAILS_ENV])
