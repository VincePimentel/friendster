module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?
    current_user == @user
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_logged_out
    flash[:notice] = "Please log in before you continue."

    redirect_to login_path if !logged_in?
  end

  def redirect_if_logged_in
    redirect_back(fallback_location: root_path) if logged_in?
  end

  # def redirect_if_unauthorized
  #   flash[:alert] = "You are not authorized to perform this action."

  #   redirect_back(fallback_location: root_path) if !current_user?
  # end

  def set_user
    @user = current_user
  end

  def log_out
    reset_session

    @current_user = nil

    flash[:notice] = "You have successfully logged out."

    redirect_to login_path
  end
end
