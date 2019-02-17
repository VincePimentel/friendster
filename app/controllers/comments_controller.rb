class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])

    comment = post.comments.build(comment_params)

    binding.pry

    comment.save

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
      params.require(:comment).permit(:content, :commenter_id)
    end
end
