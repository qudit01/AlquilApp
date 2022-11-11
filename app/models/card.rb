class Card < ApplicationRecord
  belongs_to :user
  belongs_to :wallet

  enum kind: { credit: 0, debit: 1, pre_paid: 2 }

  validates :number, :pin, :expiration, :owner, :bank, :kind, :user,
            presence: { message: 'No puede quedar vacío!' }
  validates :number, numericality: { only_integer: true, message: 'Solo se admiten números' },
                     length: { maximum: 16, minimun: 4,
                               too_long: 'El máximo de números para una tarjeta es de 16' }
  validates :number, uniqueness: { message: 'Ya se encuentra en uso' }
  validates :pin, numericality: { only_integer: true, message: 'Solo se admiten números' }
  validates :pin,
            length: {
              maximum: 12,
              minimum: 3,
              too_long: 'El máximo de números para el pin es de 12',
              too_short: 'El mínimo de números para el pin es de 3'
            }
  validates :kind, presence: true, inclusion: { in: kinds.keys }
  validates_format_of :owner, with: NAMES_FORMAT
  validate :expiration_after_now

  private

  def expiration_after_now
    return if expiration.nil?
    return unless expiration < Time.zone.now

    errors.add(:expiration, 'La fecha debe ser mayor a la actual')
  end
end
