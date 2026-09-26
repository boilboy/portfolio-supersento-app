class AddAverageRatingToFacilities < ActiveRecord::Migration[7.1]
  def change
    add_column :facilities, :average_rating, :decimal, precision: 2, scale: 1, default: 0.0, null: false
  end
end
