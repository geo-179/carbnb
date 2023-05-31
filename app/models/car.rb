class Car < ApplicationRecord
  belongs_to :user
  has_many :transactions, foreign_key: :car_id
  has_many :scheduled_users, -> { where(transactions: { status: 'scheduled' }) }, through: :transactions, source: :user
  has_many :in_progress_users, -> { where(transactions: { status: 'in progress' }) }, through: :transactions, source: :user
  has_many :completed_users, -> { where(transactions: { status: 'completed' }) }, through: :transactions, source: :user
  validates :price, presence: true, numericality: { only_integer: true }
  validates :location, presence: true, inclusion: { in: ['Los Angeles', 'Miami', 'Honolulu', 'Sydney', 'Shanghai', 'London'] }
  validates :model, presence: true
end
