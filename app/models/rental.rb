class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :fines

  validates :hours, numericality: { greater_than: 0.1 }
  validate :money?

  def total_price
    price*hours
  end

  def timeout
    current_time=((Time.now-(created_at-(3600*3)))/360)/60
    fin=hours-current_time
    return fin.round(1)
  end

  private

  def money?
    return true if user.wallet.money >= price

    user.errors.add(:wallet, 'No tienes dinero disponible')
    false
  end
end
