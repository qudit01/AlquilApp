class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :plate
      t.date :vtv
      t.string :insurance
      t.string :brand
      t.string :model
      t.integer :kilometeres

      t.timestamps
    end
  end
end
