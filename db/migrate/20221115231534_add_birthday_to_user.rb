class AddBirthdayToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birthday, :datetime, null: false
  end
end
