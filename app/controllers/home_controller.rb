class HomeController < ApplicationController
  #include SessionsHelper

  # before_action :redirect_if_logged_out
  before_action :set_user, only: [:home]

  def home
    if logged_in?
      @post = Post.new
      @posts = Post.by_friends(@user)
      @comment = Comment.new
    else
      @user = User.new
      render 'users/_form'
    end
  end
end
