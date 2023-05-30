class Review < ApplicationRecord
  belongs_to :user
  # belongs_to :transaction

  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true }
end
