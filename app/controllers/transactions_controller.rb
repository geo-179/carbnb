class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :destroy]

  def index
    @transactions = policy_scope(Transaction)
    @owned_transactions = current_user.owned_transactions


    if params[:status].present?
      if params[:status] == "scheduled"
        @transactions = current_user.scheduled_transactions
        @owned_transactions = current_user.scheduled_cars
      elsif params[:status] == "in-progress"
        @transactions = current_user.in_progress_transactions
        @owned_transactions = current_user.in_progress_cars
      elsif params[:status] == "completed"
        @transactions = current_user.completed_transactions
        @owned_transactions = current_user.completed_cars
      end
    end

    if params[:role].present?
      @owned_transactions = [] if params[:role] == "user"
      @transactions = [] if params[:role] == "owner"
    end


    authorize @transactions if @transactions.count > 0
  end

  def show
    authorize @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    # Figure out later what the parameter naming is in the POST body
    @transaction.car = Car.find(params[:id])
    @transaction.status = "scheduled"
    authorize @transaction
    if @transaction.save
      redirect_to transaction_path(@transaction)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @transaction
    @transaction.destroy
    redirect_to transactions_path, { turbo_method: :delete, turbo_confirm: "Are you sure?" }
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:start_date, :end_date, :status)
  end
end
