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
    redirect_to login_path if !logged_in?
  end

  def redirect_if_logged_in
    redirect_back(fallback_location: root_path) if logged_in?
  end

  # def redirect_if_unauthorized
  #   flash[:danger] = "You are not authorized to perform this action."

  #   redirect_back(fallback_location: root_path) if !current_user?
  # end

  def set_user
    @user = current_user
  end

  def log_out
    reset_session

    @current_user = nil

    flash[:info] = "You have been logged out. See you soon!"

    redirect_to login_path
  end

  def facebook_login
    facebook_p + facebook_link_to
  end

  def facebook_p
    tag.p("- OR -", class: "text-center my-2")
  end

  def facebook_link_to
    link_to "/auth/facebook" do
      image_tag "https://i.imgur.com/F5UeJ1T.png", id: "fb-button", class: "img-fluid"
    end
  end
end
