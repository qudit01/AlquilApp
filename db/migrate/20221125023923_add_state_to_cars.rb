class AddStateToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :state, :integerm, default: 0
  end
end
