class User < ApplicationRecord
  has_one :wallet
  has_many :cards, through: :wallet

  authenticates_with_sorcery!
  has_one :license
  enum role: { client: 0, supervisor: 1, admin: 2 }

  validates :first_name, :last_name, :email, :dni, presence: true
  validates :email, uniqueness: { message: 'El email ingresado ya se encuentra en uso' }
  validates :dni, uniqueness: { message: 'El dni ingresado ya se encuentra en uso' }
  validates :dni, numericality: { only_integer: true, message: 'Solo se permiten números!' }
  validates :email, email: true
  validates :password, length: { minimum: 3, maximum: 300, too_short: 'Debe ser de mas de 3 caractéres' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: { message: 'No puede estar en blanco' }, if: -> { new_record? || changes[:crypted_password] }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates_format_of :first_name, :last_name, with: NAMES_FORMAT, message: 'Debe respetar el formato de nombres'

  def name
    "#{first_name} #{last_name.capitalize}"
  end
end
