class PostsController < ApplicationController
  before_action :set_post, only: %i[ update ]

  # GET /users/:user_id/posts
  def index
    page = params[:page] || 1
    limit = params[:limit] || 10
    query = Post.where(user_id: params[:user_id])
    @posts = query.paginate(page: page, per_page: limit)
    @total_count = query.count
    render json: { posts: @posts, total_count: @total_count }
  end

  # GET /top_posts
  def top_posts
    page = params[:page] || 1
    limit = params[:limit] || 10
    @posts = Post.top_posts.paginate(page: page, per_page: limit)
    render json: @posts
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = params[:user_id]
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
