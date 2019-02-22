module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?
    @user == current_user
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_logged_out
    redirect_to login_path if !logged_in?
  end

  def redirect_if_logged_in
    redirect_back(fallback_location: root_path) if logged_in?
  end

  def log_out
    reset_session
    @current_user = nil
  end
end
