class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :destroy]

  def index
    @transactions = policy_scope(Transaction)
    # @transactions = Transaction.all
    authorize @transactions
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
