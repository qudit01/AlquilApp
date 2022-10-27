class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :plate, null: false
      t.string :insurance, null: false
      t.string :brand, null: false
      t.string :model, null: false
      t.integer :kilometers, default: 0

      t.timestamps
    end
  end
end
