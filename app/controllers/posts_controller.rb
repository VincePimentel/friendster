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

    redirect_back(fallback_location: root_path)
  end

  def edit
    @user = current_user
    @post = current_user.posts.find_by(id: params[:id])
    @comment = Comment.new
  end

  def update
    post = current_user.posts.find_by(id: params[:id])

    post.update(post_params)

    redirect_to edit_post_path(post)
  end

  def destroy
    post = current_user.posts.find_by(id: params[:id])

    # @post.create_activity(:destroy, owner: current_user)

    post.destroy

    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:post).permit(:content, :link, :audience, :recipient_id)
    end
end
