class Car < ApplicationRecord
  belongs_to :owner, class_name: "User", inverse_of: :owned_cars, foreign_key: "user_id"
  has_many :transactions, -> { order(created_at: :desc) }, foreign_key: :car_id

  has_many :scheduled_transactions, -> { where(status: 'scheduled') }, class_name: 'Transaction', foreign_key: :car_id
  has_many :in_progress_transactions, -> { where(status: 'in progress') }, class_name: 'Transaction', foreign_key: :car_id
  has_many :completed_transactions, -> { where(status: 'completed') }, class_name: 'Transaction', foreign_key: :car_id

  has_many :scheduled_users, -> { where(transactions: { status: 'scheduled' }) }, through: :transactions, source: :user
  has_many :in_progress_users, -> { where(transactions: { status: 'in progress' }) }, through: :transactions, source: :user
  has_many :completed_users, -> { where(transactions: { status: 'completed' }) }, through: :transactions, source: :user
  has_many_attached :photos

  validates :price, presence: true, numericality: { only_integer: true }
  validates :location, presence: true, inclusion: { in: ['Los Angeles', 'Miami', 'Honolulu', 'Sydney', 'Shanghai', 'London'] }
  validates :model, presence: true


  include PgSearch::Model

  pg_search_scope :search_without_transactions_within_range,
    against: [:model, :location],
    associated_against: {
      transactions: [:start_date, :end_date]
    },
    using: {
      tsearch: { prefix: true }
    },
    conditions: ->(search_term, query) {
      query.where.not(id: Transaction.where('start_date <= ? AND end_date >= ?', search_term, search_term).select(:car_id))
    }

    scope :available_within_range, ->(start_date, end_date) {
      joins("LEFT OUTER JOIN transactions ON cars.id = transactions.car_id")
        .where('transactions.start_date IS NULL OR transactions.start_date > ?', end_date)
        .or(where('transactions.end_date IS NULL OR transactions.end_date < ?', start_date))
        .distinct
    }

    scope :search_by_model_and_location, ->(model, location) {
      where("model ILIKE ? AND location ILIKE ?", "%#{model}%", "%#{location}%")
    }



  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_location?

  def address
    location
  end

end
