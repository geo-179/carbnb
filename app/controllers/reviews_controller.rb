class ReviewsController < ApplicationController

  # Did not add view page for index as I assume we will be displaying reviews on a users or cars page.
  def index
    @reviews = Reviews.all
  end

  def new
    @review = Review.new
  end

  def create
    @transaction = Transaction.find(params[:transaction_id])
    @review = Review.new(review_params)
    @review.transaction = @transaction
    if @review.save
      redirect_to transaction_path(@transaction)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
