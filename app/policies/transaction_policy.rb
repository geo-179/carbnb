class TransactionPolicy < ApplicationPolicy
  def show
    record.user == user
  end

  def create
    user.present?
  end

  def destroy
    record.user_id == user.id
  end

  class Scope < Scope
    # Scope becomes Transaction
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: user.id)
      # cars_array = Car.where(user_id: user.id)
      # cars_array.each do |car|
      #   id_array << car.id
      # end
      # scope.where(user_id: user.id).or(scope.where(car_id: id_array))
    end
  end
end
