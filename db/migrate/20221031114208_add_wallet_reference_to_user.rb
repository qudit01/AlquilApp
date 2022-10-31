class AddWalletReferenceToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :wallet, null: false, foreign_key: true
  end
end
