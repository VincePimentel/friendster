class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(
      relationship: "friend",
      friend_id: params[:friend_id]
      )

    @referenced_friendship = Friendship.where(
      friend_id: @friendship.user.id,
      user_id: @friendship.friend.id
      ).take

    if @friendship.save

      # If other user has added current user then
      # Set friendship status of both users to 1
      # (both users have added each other)
      # For use of users#show @requests variable
      if @referenced_friendship
        @friendship.update(status: 1)
        @referenced_friendship.update(status: 1)
      end
    else
      flash[:notice] = "Unable to add friend."
    end

    redirect_to users_path
  end

  def destroy
    # Current user's friendship with other user
    @friendship = current_user.friendships.find(params[:id])

    # Other user's friendship with current user
    @referenced_friendship = Friendship.where(
      friend_id: @friendship.user.id,
      user_id: @friendship.friend.id
      ).take

    # Destroy current user's friendship with other user
    @friendship.destroy

    # Destroy other user's friendship with current user
    # if other user has added current user prior to removal
    if @referenced_friendship
      @referenced_friendship.destroy
    end

    redirect_to users_path
  end
end
