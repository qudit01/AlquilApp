class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car

  enum state: { travelling: 0, extended: 1, finished: 2 }
  validates :state, presence: true, inclusion: { in: states.keys }

  validates :hours, numericality: { greater_than: 0.1 }
  validate :money?

  def total_price
    price * hours
  end

  def timeout
    current_time = ((Time.now - (created_at - (3600 * 3))) / 360) / 60
    fin = hours - current_time
    fin.round(1)
  end

  def time_passed?
    (taken_at.hour + hours - DateTime.now.hour).negative?
  end

  private

  def money?
    return true if user.wallet.money >= price

    user.errors.add(:wallet, 'No tienes dinero disponible')
    false
  end
end
