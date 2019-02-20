require 'pry'

class ApplicationController < ActionController::Base
  # include PublicActivity::StoreController
  include SessionsHelper
end
