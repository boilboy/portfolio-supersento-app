class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.boolean :admin, default: false, null: false

      t.timestamps
    end
  end
end
