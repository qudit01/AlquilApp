class UserPolicy < ApplicationPolicy
  def new_supervisor?
    admin?
  end

  def edit_supervisor?
    admin?
  end

  def create_supervisor?
    admin?
  end

  def update_supervisor?
    admin?
  end

  def remove_supervisor?
    admin?
  end

  def create_car?
    admin? || supervisor?
  end

  def edit_car?
    admin? || supervisor?
  end

  def remove_car?
    admin? || supervisor?
  end
end
