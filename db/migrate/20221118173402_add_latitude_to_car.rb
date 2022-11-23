class AddLatitudeToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :latitude, :float
  end
end
