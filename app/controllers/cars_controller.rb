class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :landing]

  def landing
    @cars = Car.all
    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {car: car})
      }
    end
  end

  def index
    @cars = policy_scope(Car)
    if params[:model].present? || params[:location].present?
      @cars = @cars.search_by_model_and_location(params[:model], params[:location])
    end

    if params[:start_date].present? && params[:end_date].present?
      @cars = @cars.available_within_range(params[:start_date], params[:end_date])
    end
    authorize @cars
  end

  def show
    @car = Car.find(params[:id])
    @user = Car.find(params[:id]).owner

    @review = Review.new
    @review.user = current_user

    @average_rating = 3
    @average_cleanliness = 3
    @average_maintenence = 3
    @average_accuracy = 3
    if @car.transactions.count > 0
      @average_rating = 0
      @average_cleanliness = 0
      @average_maintenence = 0
      @average_accuracy = 0
      @car.transactions.each do |t|
        counter = 0
        if t.review.rating
          counter += 1
          @average_rating += t.review.rating
          @average_cleanliness += t.review.cleanliness_rating
          @average_maintenence += t.review.maintenence_rating
          @average_accuracy += t.review.accuracy_rating
        end
      end
      @average_rating /= counter
      @average_cleanliness /= counter
      @average_maintenence /= counter
      @average_accuracy /= counter
    end

    authorize @car
  end

  def new
    @car = Car.new
    authorize @car
    if @car.rating.nil?
      @car.rating = 5
    end
  end

  def create
    @car = Car.new(car_params)
    @car.owner = current_user
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
    authorize @car
    @car.destroy
    redirect_to cars_path, data: { turbo_method: :delete, turbo_confirm: "Are you sure?" }
  end

  private

  def set_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :price, :location, :rating, photos: [])
  end
end
