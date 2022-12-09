class CreateFeedBack < ActiveRecord::Migration[7.0]
  def change
    create_table :feed_backs do |t|
      t.text :comment, default: ''
      t.integer :score, null: false
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true

      t.timestamps
    end
  end
end
