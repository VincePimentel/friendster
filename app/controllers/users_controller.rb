class UsersController < ApplicationController

  def index
    @users = current_user.available_friends
    @pending = current_user.pending_requests
    @requests = current_user.friend_requests
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      user.update(avatar: "#{user.gravatar_url}&d=monsterid&size=175")

      session[:user_id] = user.id

      redirect_to user_path(user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @comment = Comment.new
    # @posts = @user.posts#.merge(Post.where("recipient_id = ?", @user.id)).order("created_at DESC")#.and also posts by friends on profile

    @posts = Post.where(recipient_id: @user).order("created_at DESC")

    @friends = @user.friends

    # Collect all pending friend requests
    @requests = @user.referenced_friendships.where(status: 0)

    #@friendship = current_user.friendships.find_by(friend_id: @user)

    @friendships = current_user.friendships
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy

  end

  private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation
        )
    end
end
