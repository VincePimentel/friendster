class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
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
    @posts = @user.posts.merge(Post.where("recipient_id = ?", @user.id)).order("created_at DESC")#.and also posts by friends on profile

    binding.pry

    @friends = @user.friends

    # Collect all pending friend requests
    @requests = @user.referenced_friendships.where(status: 0)
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
