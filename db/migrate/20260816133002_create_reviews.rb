class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :facility, null: false, foreign_key: true
      t.text :body, null: false, default: ""

      t.decimal :cleanliness_rating, null: false, precision: 2, scale: 1
      t.decimal :relaxation_rating, null: false, precision: 2, scale: 1
      t.decimal :bedrock_bath_rating, precision: 2, scale: 1
      t.decimal :food_rating, precision: 2, scale: 1
      t.decimal :rest_space_rating, precision: 2, scale: 1
      t.decimal :service_rating, null: false, precision: 2, scale: 1

      t.timestamps
    end
  end
end
