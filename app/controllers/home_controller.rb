class HomeController < ApplicationController

  def index
    @user = current_user
    @post = Post.new
    # Get all ID's of user and user's friends

    if logged_in?
      ids = current_user.friends.pluck(:id) << current_user.id
    end

    # Get all posts of user and user's friends
    @posts = Post.where(user_id: ids).where(audience: 1).order("created_at DESC")

    @comment = Comment.new
  end

  def test

  end
end
