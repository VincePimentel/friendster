class FriendshipsController < ApplicationController
  def create
    friendship =
      Friendship.find_by(
        user_id: current_user,
        friend_id: params[:friend_id]
        )

    if friendship.nil?
      friendship =
        current_user.friendships.build(
          friend_id: params[:friend_id]
          )
    end

    if friendship.save
      referenced_friendship =
        Friendship.find_by(
          friend_id: friendship.user,
          user_id: friendship.friend
          )

      if referenced_friendship
        friendship.update(status: 1)
        referenced_friendship.update(status: 1)
      end
    end

    # If the other user has added the current user
    # via referenced_friendship, then,
    # both users have added each other,
    # set friendship status of both users to 1.
    # To be used in users#show requests variable

    redirect_back(fallback_location: users_path)
  end

  def edit
    @user = current_user
    @friendship = Friendship.find(params[:id])
  end

  def update
    friendship = Friendship.find(params[:id])

    friendship.update(friendship_params)

    redirect_to edit_friendship_path(friendship)
  end

  def destroy
    # Current user's friendship with other user
    friendship = Friendship.find(params[:id])

    # Other user's friendship with current user
    referenced_friendship =
      Friendship.find_by(
        friend_id: friendship.user.id,
        user_id: friendship.friend.id
        )

    # Destroy current user's friendship with other user
    friendship.destroy

    # Destroy other user's friendship with current user
    # if other user has added current user prior to deletion
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
