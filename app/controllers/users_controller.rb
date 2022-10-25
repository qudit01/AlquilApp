class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new]
  before_action :find_user, except: %i[new create]

  def edit; end

  def update
    return unless @user.save! notice: 'Usuario modificado exitosamente'
  end

  private

  def find_user
    @user = User.find_by_id(finding_params)
  end

  def finding_params
    params.require(:user).permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
