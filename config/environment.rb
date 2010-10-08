# Be sure to restart your server when you modify this file

# ENV['RAILS_ENV'] ||= 'production'

RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
   config.time_zone = 'Bogota'

   # Your secret key for verifying cookie session data integrity.
   # If you change this key, all old sessions will become invalid!
   config.action_controller.session = {
     :session_key => '_como_vamos_session',
     :secret      => 'b1cde27ebf941bed2de522a16279a616c9a81a816d3895a023bffa143421a035971560493ba79337e5e90976af04c8e06e368ffb86598025d6c81c7bb6dde9a2'
  }

  config.gem "authlogic"
end


ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "mail.server.com",
  :port => 25,
  :domain => "server.com",
  :authentication => :plain,
  :user_name => "noreply@server.com",
  :password => "th4_l33t_p4zZw0rd"
}
