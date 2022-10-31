class CreateCard < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.integer :number, null: false
      t.integer :pin, null: false
      t.date :expiration, null: false
      t.string :owner, null: false
      t.string :bank, null: false
      t.integer :kind, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true
      t.timestamps
    end
  end
end
