class AddDetailsToFacilities < ActiveRecord::Migration[7.1]
  def change
    add_column :facilities, :sauna_temperature_male, :decimal, precision: 4, scale: 1
    add_column :facilities, :sauna_temperature_female, :decimal, precision: 4, scale: 1
    add_column :facilities, :water_temperature_male, :decimal, precision: 4, scale: 1
    add_column :facilities, :water_temperature_female, :decimal, precision: 4, scale: 1
    add_column :facilities, :price, :integer, null: false
  end
end
