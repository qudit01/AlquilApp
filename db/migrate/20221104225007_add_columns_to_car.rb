class AddColumnsToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :car_number, :integer
    add_column :cars, :color, :string
    add_column :cars, :photo, :string
  end
end
