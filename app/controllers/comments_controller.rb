class CommentsController < ApplicationController
  #include SessionsHelper

  before_action :redirect_if_logged_out
  before_action :set_user, only: [:create, :destroy]
  before_action :set_post, only: [:create, :destroy]

  def create
    comment = @post.comments.build(comment_params)

    comment.user = @user

    comment.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = @post.comments.find(params[:id])

    comment.destroy

    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end
end
