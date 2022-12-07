class AddUserIdToFine < ActiveRecord::Migration[7.0]
  def change
    add_column :fines, :user_id, :integer
  end
end
