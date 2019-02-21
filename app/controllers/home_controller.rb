class HomeController < ApplicationController

  def index
    if logged_in?
      @user = current_user
      @post = Post.new
      @posts = Post.by_friends(current_user)# if logged_in?
      @comment = Comment.new
    else
      redirect_to login_path
    end
  end

  def test; end
end
