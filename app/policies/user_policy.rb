class UserPolicy < ApplicationPolicy
  def create_supervisor?
    admin?
  end

  def edit_supervisor?
    admin?
  end

  def remove_supervisor?
    admin?
  end
end
