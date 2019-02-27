class HomeController < ApplicationController
  before_action :set_user, only: [:home]

  def welcome; end

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

  def top
    @user = User.friendliest
    @post = Post.trending
    @comment = Comment.new
  end

end
