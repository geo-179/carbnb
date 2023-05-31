class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_one :review

  validate :check_owner_not_same_as_user
  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: ["scheduled", "in progress", "completed"] }

  private

  def check_owner_not_same_as_user
    if car.user_id == user.id
      errors.add(:base, "The owner of the car cannot be the same as the user")
    end
  end
end
