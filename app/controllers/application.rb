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

  #this is a before filter, so it redirects
  def is_logged_in
    if !logged_in?
      redirect_unauthorized(:back, "You must be logged in to perform this action.")
    end
  end

  # Redirect to the current controller path (or where) with a message in the
  # flash.
  def redirect_unauthorized(where = eval("#{params[:controller]}_path"),
                            message = "You are not authorized to perform this action.")
    flash[:error] = message
    begin
      redirect_to where
    rescue
      redirect_to("/")
    end
  end
end



