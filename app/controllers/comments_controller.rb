class CommentsController < ApplicationController
  before_action :redirect_if_logged_out, only: [:create, :destroy]
  before_action :set_user, only: [:create, :destroy]
  before_action :set_post, only: [:create, :destroy]

  def create
    comment = @post.comments.build(comment_params)

    comment.user = @user

    if !comment.save
      flash[:danger] = "Comment cannot be blank."
    end

    session[:target_post] = @post.id

    redirect_to request.referrer + "#post_#{@post.id}"
  end

  def destroy
    comment = @post.comments.find(params[:id])

    comment.destroy

    session[:target_post] = @post.id

    redirect_to request.referrer + "#post_#{@post.id}"
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end
end
