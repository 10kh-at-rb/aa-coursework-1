class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to user_url(user)
  end

  def logged_in?
    !!current_user
  end

  def log_out_user!(user)
    session[:session_token] = nil
    current_user.reset_session_token!
    redirect_to new_session_url
  end

  def redirect_if_logged_in
    redirect_to user_url(current_user) if logged_in?
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end

end
