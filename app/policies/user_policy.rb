class UserPolicy < ApplicationPolicy
  def create_supervisor?
    admin?
  end

  def update_supervisor?
    admin?
  end

  def remove_supervisor?
    admin?
  end
end
