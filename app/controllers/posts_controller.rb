class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Ensure you use the correct method name here which should be `post_params` rather than `params`
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
