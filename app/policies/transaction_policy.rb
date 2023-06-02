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
    end
  end
end
