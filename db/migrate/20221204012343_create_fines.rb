class CreateFines < ActiveRecord::Migration[7.0]
  def change
    create_table :fines do |t|
      t.integer :price
      t.string :motive
      t.string :typefine

      t.timestamps
    end
  end
end
