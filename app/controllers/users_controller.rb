class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :redirect_if_logged_out
  before_action :redirect_if_unauthorized, only: [:edit, :update, :destroy]

  def index
    @users = current_user.available_friends
    @sent_requests = current_user.sent_requests
    @received_requests = current_user.received_requests
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
    @post = Post.new
    @comment = Comment.new

    # Retrieve all posts posted on @user's timeline
    @posts = Post.where(recipient_id: @user).order("created_at DESC")

    @friends = @user.current_friends

    @sent_requests = current_user.sent_requests
    @received_requests = current_user.received_requests
  end

  def edit; end

  def update
    current_user.update(user_params)

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user.destroy

    log_out

    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :username,
        :email,
        :password,
        :password_confirmation,
        :gender,
        :bio,
        :website,
        :instagram,
        :twitter
        )
    end

    def set_user
      @user = User.find(params[:id])
    end
end
