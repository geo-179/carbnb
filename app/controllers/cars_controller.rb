class CarsController < ApplicationController
  before_action :set_car, only [:show]

  def index
    @cars = Cars.all
  end

  def show
  end

  def new
  end

  def create
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
end
