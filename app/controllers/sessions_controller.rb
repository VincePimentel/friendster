class SessionsController < ApplicationController
  # before_action :redirect_if_logged_in, only: [:new, :create]

  def new; end

  def create
    if auth
      user =
        User.find_or_create_by(uid: auth[:uid]) do |u|
          u.first_name = auth[:info][:name].split[0]
          u.last_name = auth[:info][:name].split[-1]
          u.username = "#{u.first_name}_#{u.last_name}"
          u.email = auth[:info][:email]
          u.password = SecureRandom.base64(8)
          u.password_confirmation = u.password
          u.avatar = auth[:info][:image] || "#{u.gravatar_url}&d=robohash&size=175"
        end

      session[:user_id] = user.id

      redirect_to root_path
    else
      @user = User.find_by(username: params[:session][:username].downcase)

      if @user&.authenticate(params[:session][:password])
        session[:user_id] = @user.id

        redirect_to root_path
      else
        flash[:danger] = "Username or password is incorrect. Please try again."

        redirect_to login_path
      end
    end
  end

  def destroy
    log_out
  end

  private

    def auth
      request.env['omniauth.auth']
    end
end
