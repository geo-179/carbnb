class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @cars = policy_scope(Car)
    authorize @cars
  end

  def show
    authorize @car
  end

  def new
    @cars = Car.new
  end

  def create
    @cars = Car.new(car_params)
    if @cars.save
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
    authorize
    redirect_to cars_path, status: :see_other
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :price, :location)
  end
end
