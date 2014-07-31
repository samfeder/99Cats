class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    @current_user = user
    session[:session_token] = user.session_token
    redirect_to user_url(user)
  end

  def logout!
    session[:session_token] = nil
  end

  def current_user
    return nil if session[:session_token].nil?
    @priv_current_user ||= User.find_by_session_token(session[:session_token])
  end

  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end
end
