class CarPolicy < ApplicationPolicy
  def create?
    admin? || supervisor?
  end

  def edit?
    admin? || supervisor?
  end

  def remove?
    admin? || supervisor?
  end
end
