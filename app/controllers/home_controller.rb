class HomeController < ApplicationController
  include SessionsHelper

  before_action :redirect_if_logged_out
  before_action :set_user, only: [:index]

  def index
    @post = Post.new
    @posts = Post.by_friends(@user)
    @comment = Comment.new
  end

  def test; end
end
