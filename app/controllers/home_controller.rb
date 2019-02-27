class HomeController < ApplicationController
  before_action :set_user, only: [:home]
  before_action :new_comment, only: [:home, :top]

  def welcome; end

  def home
    if logged_in?
      @post = Post.new
      @posts = Post.by_friends(@user)

    else
      @user = User.new
      render :welcome
    end
  end

  def top
    @user = User.friendliest
    @post = Post.trending
  end
end
