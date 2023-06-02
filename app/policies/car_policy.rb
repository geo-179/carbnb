class CarPolicy < ApplicationPolicy
  def create
    user.present?
  end

  def show
    true
  end

  # def edit
  #   record.owner == user
  # end

  def update
    # test
    record.user_id == user.id
  end

  def destroy
    record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.all # If users can see all restaurants
      # scope.where(user: user) # If users can only see their restaurants
      # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
      # ...
    end
  end
end
