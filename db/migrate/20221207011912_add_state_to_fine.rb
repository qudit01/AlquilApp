class AddStateToFine < ActiveRecord::Migration[7.0]
  def change
    add_column :fines, :state, :integer, default: 0
  end
end
