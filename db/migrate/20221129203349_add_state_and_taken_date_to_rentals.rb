class AddStateAndTakenDateToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :state, :integer
    add_column :rentals, :taken_at, :datetime
    add_column :rentals, :finished_at, :datetime
    change_column_default :rentals, :hours, from: 0.3, to: 1.0
  end
end
