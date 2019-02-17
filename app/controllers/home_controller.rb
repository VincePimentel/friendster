class HomeController < ApplicationController

  def index
    @activities = PublicActivity::Activity.order("created_at desc")
    #@activities = PublicActivity::Activity.order("created_at desc")#.where(owner_id: current_user.friend_ids, owner_type: "User")
    @comment = Comment.new
  end
end
