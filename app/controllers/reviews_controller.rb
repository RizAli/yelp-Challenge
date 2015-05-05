class ReviewsController < ApplicationController

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review current_user, review_params

    if @review.save
      redirect_to restaurants_path
    else
      flash[:notice] = "You have already reviewed this restaurant"
      redirect_to restaurants_path
    end
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def index
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
