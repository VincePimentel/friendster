class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    @post.save

    redirect_to user_path(@post.user_id)
  end

  private

    def post_params
      params.require(:post).permit(:content, :link)
    end
end
