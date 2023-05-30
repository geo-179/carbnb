class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @cars = policy_scope(Car)
    authorize @cars
  end

  def show
    @car = Car.find(params[:id])
    authorize @car
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car
    if @car.save
      redirect_to car_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @car
  end

  def update
    @car.update(car_params)
    authorize @car
    redirect_to car_path(@car)
  end

  def destroy
    @car.destroy
    redirect_to cars_path, data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :price, :location)
  end
end
