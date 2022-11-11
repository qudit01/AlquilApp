class Car < ApplicationRecord
  mount_uploader :photo, ImageUploader
  validates :car_number, :plate, :insurance, :brand, :model, presence: { message: 'No puede estar en blanco' }
  validates :plate, uniqueness: { message: 'Ya está en uso!' }
  validates :car_number, uniqueness: { message: 'Ya está en uso!' }
  validates :kilometers, numericality: { only_integer: true, message: 'Solo se admiten números' }
end
