# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'f84ae8064f394ae3e471e65ac81417b1'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password

  protected
  def is_logged_in
    if current_user.nil?
      unauthorized("You must be logged in to perform this action.", :back)
      return false
    else
      return true
    end
  end


  def unauthorized(message, where)
    flash[:error] = message
    redirect_to where
  end
end
