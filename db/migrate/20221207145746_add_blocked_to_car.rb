class AddBlockedToCar < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :blocked, :boolean, default: false
  end
end