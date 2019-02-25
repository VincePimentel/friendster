class PostsController < ApplicationController
  #include SessionsHelper

  before_action :redirect_if_logged_out
  before_action :set_user, except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    post = @user.posts.build(post_params)

    # If user posted on other user's profile

    post.save

    flash[:success] = "Post shared!"

    redirect_back(fallback_location: root_path)
  end

  def edit
    @post = @user.posts.find_by(id: params[:id])

    @comment = Comment.new
  end

  def update
    post = @user.posts.find_by(id: params[:id])

    post.update(post_params)

    flash[:info] = "Changes successfully saved."

    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = @user.posts.find_by(id: params[:id])

    post.destroy

    flash[:success] = "Post successfully deleted."

    redirect_to root_path
  end

  private

    def post_params
      params.require(:post).permit(:content, :link, :audience, :recipient_id)
    end
end
