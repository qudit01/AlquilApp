class Car < ApplicationRecord
  mount_uploader :photo, ImageUploader
  belongs_to :rental, required: false
  has_one :user, through: :rental
  has_many :feed_backs
  enum state: { available: 0, taken: 1 }
  validates :car_number, :plate, :insurance, :brand, :model, presence: { message: 'No puede estar en blanco' }
  validates :car_number, :plate, uniqueness: { message: '¡Ya está en uso!', scope: :remove }
  validates :kilometers, numericality: { only_integer: true, message: 'Solo se admiten números' }

  scope :availables, -> { where(state: 0, remove: false) }
end
