class SessionsController < ApplicationController
  include SessionsHelper

  before_action :redirect_if_logged_in, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(username: params[:session][:username])

    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id

      redirect_to user_path(user)
    else
      render :new
    end
  end

  def destroy
    log_out

    redirect_to login_path
  end
end
