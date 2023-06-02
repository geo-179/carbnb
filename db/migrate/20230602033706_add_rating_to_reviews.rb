class AddRatingToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :cleanliness_rating, :integer
    add_column :reviews, :maintenence_rating, :integer
    add_column :reviews, :accuracy_rating, :integer
  end
end
