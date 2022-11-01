class AddLicenseToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :license, null: true, foreign_key: true
  end
end
