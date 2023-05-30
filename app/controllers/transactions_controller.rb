class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :destroy]

  def index
    @transactions = Transaction.all
  end

  def show
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @user = User.find(params[:user_id])
    @car = Car.find(params[:car_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.user = @user
    @transaction.car = @car
    if @transaction.save
      redirect_to transaction_path(@transaction)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
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
