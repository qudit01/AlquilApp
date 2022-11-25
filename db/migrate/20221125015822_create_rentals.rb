class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.float :price, default: 22.5
      t.float :hours, default: 0.3

      t.timestamps
    end
  end
end
