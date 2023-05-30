class ReviewsController < ApplicationController
  before_action :set_transaction, only: [:new, :create]

  # Did not add view page for index as I assume we will be displaying reviews on a users or cars page.
  def index
    @reviews = policy_scope(Review)
    authorize @reviews
  end

  def new
    @review = Review.new
    @review.user = current_user
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.transaction = @transaction
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to transaction_path(@transaction)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:transaction_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
