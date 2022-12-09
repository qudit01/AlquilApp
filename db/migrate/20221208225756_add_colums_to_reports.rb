class AddColumsToReports < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :users, :integer
    add_column :reports, :fines, :integer
    add_column :reports, :rentals, :integer
  end
end
