class HomeController < ApplicationController

  def index
    # @activities = PublicActivity::Activity.order("created_at DESC")
    # @activities = PublicActivity::Activity.order("created_at desc")#.where(owner_id: current_user.friend_ids, owner_type: "User")
    @posts = Post.all#.where(post user is user's friend)
    @comment = Comment.new
  end
end
