class CarPolicy < ApplicationPolicy
  def create?
    admin? || supervisor?
  end

  def edit?
    admin? || supervisor?
  end

  def update?
    admin? || supervisor?
  end

  def remove_car?
    admin? || supervisor?
  end
end
