class Car < ApplicationRecord
  mount_uploader :photo, ImageUploader
  validates :plate, :insurance, :brand, :model, presence: true
  validates :plate, uniqueness: true
  validates :kilometers, numericality: { only_integer: true }
end
