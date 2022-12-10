class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :car
  has_many :fines
  has_many :feed_backs

  enum state: { travelling: 0, extended: 1, finished: 2 }
  validates :state, presence: true, inclusion: { in: states.keys }

  validates :hours, numericality: { greater_than: 0.1 }
  validate :money?

  scope :right_now, -> { where(state: %w[travelling extended]) }

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

  def estado
    if state=='travelling'
      "#{'En curso'}"
    else
      if state=='extended'
        "#{'Extendido'}"
      else
        "#{'Finalizado'}"
      end
    end
  end

  private

  def money?
    return true if user.wallet.money >= price

    user.errors.add(:wallet, 'No tienes dinero disponible')
    false
  end
end
