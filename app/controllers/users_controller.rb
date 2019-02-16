class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.build(link: "")
    @posts = @user.posts.order("created_at desc")
    @requests = current_user.referenced_friendships.where(status: 0)
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
