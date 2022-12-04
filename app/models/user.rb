class User < ApplicationRecord
  has_one :wallet
  has_many :cards, through: :wallet
  has_one :rental
  has_one :car, through: :rental

  authenticates_with_sorcery!
  has_many :license
  enum role: { client: 0, supervisor: 1, admin: 2 }
  enum state: { stall: 0, travelling: 1 }

  validates :first_name, :last_name, :email, :dni, presence: true
  validates :email, uniqueness: { message: 'El email ingresado ya se encuentra en uso' }
  validates :dni, uniqueness: { message: 'El DNI ingresado ya se encuentra en uso' }
  validates :dni, numericality: { only_integer: true, message: 'Solo se permiten números' }
  validates :email, email: true
  validates :password, length: { minimum: 3, maximum: 300, too_short: 'Debe ser de mas de 3 caractéres' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: { message: 'No puede estar en blanco' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, length: { minimum: 3, maximum: 300, too_short: 'Debe ser de mas de 3 caractéres' }, if: -> { new_record? || changes[:crypted_password] }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates_format_of :first_name, :last_name, with: NAMES_FORMAT, message: 'Debe respetar el formato de nombres'
  validate :age_validation

  def name
    "#{first_name} #{last_name.capitalize}"
  end

  def rol
    if role=='supervisor'
      "#{'Supervisor'}"
    else
      if role=='admin'
        "#{'Administrador'}"
      else
        "#{'Cliente'}"
      end
    end
  end

  def age
    Time.zone.now.year - birthday.year
  end

  def license?
    !license.nil?
  end

  def can_rent?(price)
    wallet.money >= price
  end

  def see_cars?
    license? && stall? && wallet.money >= 1
  end

  def money
    wallet.money
  end

  private

  def age_validation
    return if age > 17

    errors.add(:birthday, '¡Debes ser mayor de 17 para usar la plataforma!')
  end
end
