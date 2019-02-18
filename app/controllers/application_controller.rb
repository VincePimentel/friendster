require 'pry'

class ApplicationController < ActionController::Base
  # include PublicActivity::StoreController
  include SessionsHelper

  def redirect_if_logged_out
    redirect_to new_session_path if !logged_in?
  end
end
