class CreateFacilities < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.text :introduction

      t.timestamps
    end
  end
end
