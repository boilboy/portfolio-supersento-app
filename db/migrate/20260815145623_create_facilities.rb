class CreateFacilities < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :address
      t.text :introduction

      t.timestamps
    end
  end
end
