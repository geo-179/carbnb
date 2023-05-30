class Car < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :price, presence: true, numericality: { only_integer: true }
  validates :location, presence: true, inclusion: { in: ['Los Angeles', 'Miami', 'Honolulu', 'Sydney', 'Shanghai', 'London'] }
  validates :model, presence: true
end
