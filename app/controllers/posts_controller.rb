class PostsController < ApplicationController

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)

    # If user posted on other user's profile

    post.save

    # @post.create_activity(:create, owner: current_user)

    redirect_to user_path(current_user)
  end

  def edit
    @user = current_user
    @post = current_user.posts.find(params[:id])
  end

  def update
    post = current_user.posts.find(params[:id])

    post.update(post_params)

    redirect_to edit_post_path(post)
  end

  def destroy
    post = current_user.posts.find(params[:id])

    # @post.create_activity(:destroy, owner: current_user)

    post.destroy

    redirect_to user_path(current_user)
  end

  private

    def post_params
      params.require(:post).permit(:content, :link, :audience, :recipient_id)
    end
end
