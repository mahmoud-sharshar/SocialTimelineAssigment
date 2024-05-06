class ReviewsController < ApplicationController

  # GET /posts/:post_id/reviews
  def index
    page = params[:page] || 1
    limit = params[:limit] || 10
    query = Review.where(post_id: params[:post_id])
    @reviews = query.paginate(page: page, per_page: limit)
    @total_count = query.count
    render json: { reviews: @reviews, total_count: @total_count }
  end

  # POST /posts/:post_id/reviews
  def create
    @post = Post.find_by_id(params[:post_id])
    if !@post
      render json: { message: "Post not found" }, status: :bad_request
      return
    end
    @review = Review.new(review_params)
    @review.post_id = params[:post_id]
    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:rating, :comment, :user_id)
  end
end
