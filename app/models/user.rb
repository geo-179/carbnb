class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :cars
  has_many :transactions
  has_many :rented_cars, through: :transactions, source: :car
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
