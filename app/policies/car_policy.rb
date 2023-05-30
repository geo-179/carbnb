class CarPolicy < ApplicationPolicy
  def create
    return user
  end

  def show
    true
  end

  def update
    # test
    record.user == user
  end

  def destroy
    record.user == user
  end

  class Scope < Scope
    def resolve

      puts "======================="
      puts user
      puts "======================="

      scope.all # If users can see all restaurants
      # scope.where(user: user) # If users can only see their restaurants
      # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
      # ...
    end
  end
end
