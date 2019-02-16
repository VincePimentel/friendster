require 'pry'

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def logged_in?
    !!session[:user_id]
  end

  def redirect_if_logged_out
    redirect_to new_session_path if !logged_in?
  end
end
