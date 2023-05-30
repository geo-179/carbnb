class Car < ApplicationRecord
  belongs_to :user
  validates :price, presence: true, numericality: { only_integer: true }
  validates :model, :location, presence: true, inclusion: { in: ['Los Angeles', 'Miami', 'Honolulu', 'Sydney', 'Shanghai', 'London'] }
end
