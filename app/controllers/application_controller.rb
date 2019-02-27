require 'pry'

class ApplicationController < ActionController::Base
  include SessionsHelper
  include CommentsHelper
end
