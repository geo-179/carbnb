class ReviewsController < ApplicationController
  before_action :set_transaction_user, only: [:new, :create]

  # Did not add view page for index as I assume we will be displaying reviews on a users or cars page.
  def index
    @reviews = Reviews.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.transaction = @transaction
    @review.user = @user
    if @review.save
      redirect_to transaction_path(@transaction)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:transaction_id])
    @user = User.find(params[:user_id])
  end
  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
