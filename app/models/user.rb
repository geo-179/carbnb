class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :cars
  has_many :transactions
  has_many :scheduled_cars, -> { where(transactions: { status: 'scheduled' }) }, through: :transactions, source: :car
  has_many :in_progress_cars, -> { where(transactions: { status: 'in progress' }) }, through: :transactions, source: :car
  has_many :completed_cars, -> { where(transactions: { status: 'completed' }) }, through: :transactions, source: :car
  has_many :reviews
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
