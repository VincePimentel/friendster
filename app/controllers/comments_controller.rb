class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])

    @post_comment = post.comments.build(comment_params)
    @user_comment = current_user.comments.build(comment_params)

    # Add activity

    @post_comment.save
    @user_comment.save

    redirect_to root_path
  end

  def destroy
    post = Post.find(params[:post_id])

    @comment = post.comments.find(params[:id])

    @comment.destroy

    redirect_to root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
