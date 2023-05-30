class CarsController < ApplicationController
  before_action :set_car, only: [:show]

  def index
    @cars = Car.all
  end

  def show
  end

  def new
    @cars = Car.new
  end

  def create
    @cars = Car.new(car_params)
    @cars.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :price, :location)
  end
end
