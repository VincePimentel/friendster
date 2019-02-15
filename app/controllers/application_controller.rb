require 'pry'

class ApplicationController < ActionController::Base

  def current_user
    session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def redirect_if_logged_out
    redirect_to new_session_path if !logged_in?
  end
end
