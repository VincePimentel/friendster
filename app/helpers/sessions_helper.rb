module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def friend_request_count
    current_user.referenced_friendships.where(status: 0).size
  end
end
