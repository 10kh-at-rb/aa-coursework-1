class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :admin?

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def admin?
    return current_user.admin if logged_in?
    false
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to user_url(user)
  end

  def redirect_if_not_logged_in
    redirect_to bands_url unless logged_in?
  end

  def redirect_if_not_admin
    render text: "403 FORBIDDEN" unless admin?
  end
end
