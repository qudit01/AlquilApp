class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :first_name, :last_name, :email, :dni, presence: true
  validates :email, :dni, uniqueness: true
  validates :dni, numericality: { only_integer: true }
  validates :email, email: true
end
