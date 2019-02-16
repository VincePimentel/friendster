class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)

    @post.save

    @post.create_activity(:create, owner: current_user)

    redirect_to user_path(current_user)
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    # @post.create_activity(:destroy, owner: current_user)

    @post.destroy


    redirect_to user_path(current_user)
  end

  private

    def post_params
      params.require(:post).permit(:content, :link)
    end
end
