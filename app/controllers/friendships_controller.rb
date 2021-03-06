class FriendshipsController < ApplicationController
  before_action :redirect_if_logged_out
  before_action :set_user, only: [:create, :edit]
  before_action :set_friendship, only: [:edit, :update, :destroy]
  before_action :redirect_if_no_friendship, only: [:edit, :update, :destroy]

  def create
    # Retrieve any existing friendship to avoid duplicates
    # when another user has already added current user.
    friendship =
      Friendship.find_by(
        user_id: @user,
        friend_id: params[:friend_id]
        )

    friend = User.find_by(id: params[:friend_id])

    # If no record exists, create a new one for current user.
    if !friendship
      friendship =
        @user.friendships.build(
          friend_id: params[:friend_id]
          )

      flash[:info] = "Friend request sent to #{friend.first_name}."
    end

    # If the other user has added the current user
    # via referenced_friendship, then,
    # both users have added each other,
    # set friendship status of both users to 1.
    if friendship.save
      referenced_friendship =
        Friendship.find_by(
          friend_id: friendship.user,
          user_id: friendship.friend
          )

      if referenced_friendship
        friendship.update(status: 1)
        referenced_friendship.update(status: 1)

        flash[:info] = "You and #{friend.first_name} are now friends. Hooray!"
      end
    end

    redirect_back(fallback_location: users_path)
  end

  def edit
    if @user.friendships.find_by(id: @friendship)
      @friend = @user.friends.find_by(id: @friendship.friend_id)
    else
      flash[:danger] = "You are not authorized to perform this action."

      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friendship.update(friendship_params)

    if @friendship.valid?
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Invalid relationship. Please try again."

      render :edit
    end
  end

  def destroy
    # Other user's friendship with current user
    referenced_friendship =
      Friendship.find_by(
        friend_id: @friendship.user.id,
        user_id: @friendship.friend.id
        )

    # Destroy other user's friendship with current user
    # if other user has added current user prior to deletion
    if referenced_friendship
      referenced_friendship.destroy

      friend = User.find_by(id: @friendship.friend_id)

      flash[:info] = "You and #{friend.first_name} are no longer friends."
    end

    # Destroy current user's friendship with other user
    @friendship.destroy

    redirect_to users_path
  end

  private

    def friendship_params
      params.require(:friendship).permit(:relationship)
    end

    def set_friendship
      @friendship = Friendship.find_by(id: params[:id])
    end

    def redirect_if_no_friendship
      if !@friendship
        flash[:danger] = "Friendship does not exist. Please try again."

        redirect_back(fallback_location: root_path)
      end
    end
end
