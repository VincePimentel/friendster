class HomeController < ApplicationController

  def index
    # Get all ID's of user and user's friends
    ids = current_user.friends.pluck(:id) << current_user.id

    # Get all posts of user and user's friends
    @posts = Post.where(user_id: ids).order("created_at DESC")

    @comment = Comment.new
  end

  def test

  end
end
