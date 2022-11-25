class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validate :money?

  private

  def money?
    return true if user.wallet.money >= price

    user.errors.add(:wallet, 'No tienes dinero disponible')
    false
  end
end
