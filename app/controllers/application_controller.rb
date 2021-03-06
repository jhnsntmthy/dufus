# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Rack::OAuth::Methods

  helper :all
  helper_method :current_user_session, :current_user, :oauth_login_path
  filter_parameter_logging :password, :password_confirmation
  
  
  
  
  private
    helper_method :logged_into_twitter?
    def logged_into_twitter?
      get_access_token.present?
    end

    helper_method :current_twitter_user
    def current_twitter_user
      @twit = current_user.twit if current_user
      @twit = Twit.find_by_twitter_user_id(get_access_token.params["user_id"]) if @twit.nil?
      @twit
    end

    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
