class HomeController < ApplicationController
  before_action :set_user, only: [:home]

  def home
    if logged_in?
      @post = Post.new
      @posts = Post.by_friends(@user)
      @comment = Comment.new
    else
      @user = User.new
      render :welcome
    end
  end

  def welcome; end
end
