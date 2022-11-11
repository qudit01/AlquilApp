class CreateLicenses < ActiveRecord::Migration[7.0]
  def change
    create_table :licenses do |t|
      t.date :expire
      t.string :photo
      t.integer :state, default: 0
      t.string :motive

      t.timestamps
    end
  end
end
