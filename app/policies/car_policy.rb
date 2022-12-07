class CarPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def edit?
    supervisor?
  end

  def update?
    admin? || supervisor?
  end

  def remove_car?
    admin?
  end

  def block?
    supervisor?
  end
end
