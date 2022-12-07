class AddFineReferenceToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :fine, null: true, foreign_key: true
  end
end
