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
  helper_method :current_user_session, :current_user, :logged_in?, :deliver_email
  
  filter_parameter_logging :password, :password_confirmation
  
  def build_hoptoad_notification exception, aditional_data={}
    important_data = {}
    important_data[:referer] = request.referer unless request.nil?
    important_data[:logged_in] = current_user.nil? unless current_user.nil?
    important_data[:user_info] = current_user.inspect unless current_user.nil?
    important_data.reverse_merge!(aditional_data)
    important_data.reverse_merge!(params)

    notify_hoptoad(
      :error_class    => exception.class,
      :error_message  => exception.message,
      :session        => session,
      :request        => request,
      :parameters     => important_data,
      :backtrace      => caller
    )
  end
  
  private
  
  def deliver_email objct = nil
    unless block_given?
      raise Exceptions::NoBlockGiven
    end
    begin
      yield
    rescue Exception => e
      flash[:error] = "There was an error dispatching notification emails (This is not your fault!)"
      build_hoptoad_notification e
      logger.error("\n\n\n*************** Error: Emails#deliver! ***************")
      logger.error("Exception rescued while trying to dispatch notification emails")
      logger.error("Exception message: #{e.message}\n")
      logger.error("*************** End of error log ***************\n\n\n")
    end
  end
  
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



