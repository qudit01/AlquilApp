class Car < ApplicationRecord
  validates :plate, :insurance, :brand, :model, presence: true
  validates :plate, uniqueness: true
  validates :kilometers, numericality: { only_integer: true }
end
