class Wallet < ApplicationRecord
  belongs_to :user
  has_many :cards

  validates :money, numericality: { only_integer: false }
  validates :user, presence: true
end
