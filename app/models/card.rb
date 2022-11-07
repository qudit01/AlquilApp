class Card < ApplicationRecord
  belongs_to :user
  belongs_to :wallet

  enum kind: { credit: 0, debit: 1, pre_paid: 2 }

  validates :number, :pin, :expiration, :owner, :bank, :kind, :user, presence: true
  validates :number, numericality: { only_integer: true }, length: { maximum: 16 }
  validates :number, uniqueness: true
  validates :pin, numericality: { only_integer: true }
  validates :pin, length: { maximum: 12 }
  validates :kind, presence: true, inclusion: { in: kinds.keys }
  validates_format_of :owner, with: NAMES_FORMAT
  validate :expiration_after_now

  private

  def expiration_after_now
    return unless expiration < Time.zone.now

    errors.add(:expiration, 'La fecha debe ser mayor a la actual')
  end
end
