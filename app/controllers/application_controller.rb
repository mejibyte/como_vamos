# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'f84ae8064f394ae3e471e65ac81417b1'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password
  
  #This will make the current_user and current_user_session methods available in the application
  helper_method :current_user_session, :current_user, :logged_in?
  filter_parameter_logging :password, :password_confirmation

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  # This method will redirect the user to the login page if there's no current user.
  # It will keep guests out of some areas of the applicatoin
  def require_user
    unless current_user
      store_location
      flash[:error] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  # This method will redirect the user when he/she has already created an user_session
  # For example, an existing user can't access the login page
  def require_no_user
    if current_user
      store_location
      flash[:error] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end

  # This will store the user's location to redirect him back to it
  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default=root_path)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  protected

  #this is a before filter, so it redirects
  #def is_logged_in
  #  redirect_unauthorized(:back, "You must be logged in to perform this action.") unless logged_in?
  #end
  
  alias :is_logged_in :require_user
  alias :logged_in? :current_user

  # Redirect to the current controller path (or where) with a message in the
  # flash.
  def redirect_unauthorized(where = eval("#{params[:controller]}_path"),
    message = "You are not authorized to perform this action.")
    flash[:error] = message
    begin
      redirect_to where
    rescue
      redirect_to root_path
    end
  end
end



