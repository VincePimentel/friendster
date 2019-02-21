class HomeController < ApplicationController

  def index
    @user = current_user
    @post = Post.new
    @posts = Post.by_friends_of(current_user)
    @comment = Comment.new
  end

  def test; end
end
