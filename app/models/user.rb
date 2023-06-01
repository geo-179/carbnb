class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :owned_cars, class_name: "Car", inverse_of: :owner
  has_many :transactions, foreign_key: :user_id

  has_many :scheduled_transactions, -> { where(status: 'scheduled') }, class_name: 'Transaction', foreign_key: :user_id
  has_many :in_progress_transactions, -> { where(status: 'in progress') }, class_name: 'Transaction', foreign_key: :user_id
  has_many :completed_transactions, -> { where(status: 'completed') }, class_name: 'Transaction', foreign_key: :user_id

  has_many :scheduled_cars, -> { where(transactions: { status: 'scheduled' }) }, through: :transactions, source: :car
  has_many :in_progress_cars, -> { where(transactions: { status: 'in progress' }) }, through: :transactions, source: :car
  has_many :completed_cars, -> { where(transactions: { status: 'completed' }) }, through: :transactions, source: :car
  has_many :reviews
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
