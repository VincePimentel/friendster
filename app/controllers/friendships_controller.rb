class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.find_by(
      user_id: current_user,
      friend_id: params[:friend_id])

    # Add check to avoid dupes

    if friendship.nil?
      friendship =
      current_user.friendships.build(
        relationship: "friends",
        friend_id: params[:friend_id]
        )
    end

    referenced_friendship =
      Friendship.find_by(
        friend_id: friendship.user,
        user_id: friendship.friend
        )

    if friendship.save

      # If other user has added current user then
      # Set friendship status of both users to 1
      # (both users have added each other)
      # To be used in users#show requests variable
      if referenced_friendship
        friendship.update(status: 1)
        referenced_friendship.update(status: 1)
      end
    else
      flash[:notice] = "Unable to add friend."
    end

    #binding.pry

    redirect_to user_path(params[:friend_id])
  end

  def edit
    @user = current_user
    #binding.pry
    @friendship = Friendship.find(params[:id])
  end

  def update
    friendship = Friendship.find(params[:id])

    friendship.update(friendship_params)

    redirect_to edit_friendship_path(friendship)
  end

  def destroy
    # Current user's friendship with other user
    friendship = current_user.friendships.find(params[:id])

    # Other user's friendship with current user
    referenced_friendship =
      Friendship.find_by(
        friend_id: friendship.user.id,
        user_id: friendship.friend.id
        )

    # Destroy current user's friendship with other user
    friendship.destroy

    # Destroy other user's friendship with current user
    # if other user has added current user prior to removal
    if referenced_friendship
      referenced_friendship.destroy
    end

    redirect_to users_path
  end

  private

    def friendship_params
      params.require(:friendship).permit(:relationship)
    end
end
