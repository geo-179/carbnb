class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_one :review

  validates :start_date, :end_date, presence: true
  validates :status, presence: true, inclusion: { in: ["scheduled", "in progress", "completed"] }
end
