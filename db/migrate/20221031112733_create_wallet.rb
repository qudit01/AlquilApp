class CreateWallet < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :money, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
