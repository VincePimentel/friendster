class PostsController < ApplicationController
  before_action :redirect_if_logged_out, except: [:index, :show]
  before_action :set_user, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    # Index for posts located in root_path
    redirect_to root_path
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post shared!"

      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.new

    if !@post
      flash[:danger] = "Post does not exist. Please try again"

      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @post.update(post_params)

    if @post.valid?
      flash[:info] = "Changes successfully saved."

      redirect_back(fallback_location: root_path)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    flash[:success] = "Post successfully deleted."

    redirect_to root_path
  end

  private

    def post_params
      params.require(:post).permit(:content, :link, :audience, :recipient_id)
    end

    def set_post
      @post = @user.posts.find_by(id: params[:id])
    end
end
