class AddPositionToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :position, :float
  end
end