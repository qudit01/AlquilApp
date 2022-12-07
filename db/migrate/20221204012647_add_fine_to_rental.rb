class AddFineToRental < ActiveRecord::Migration[7.0]
  def change
    add_reference :rentals, :fine, null: true, foreign_key: true
  end
end
