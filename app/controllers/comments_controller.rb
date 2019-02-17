class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])

    @comment = post.comments.build(comment_params)

    @comment.save

    redirect_to root_path
  end

  def destroy

  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
