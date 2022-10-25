class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new]
  before_action :find_user, except: %i[new create]

  def edit; end

  def update
    return unless @user.save! notice: 'Usuario modificado exitosamente'
  end

  def edit_supervisor; end

  def update_supervisor
    authorize @user
    if @user.update user_params
      redirect_to @user
    else
      render :edit_supervisor
    end
  end

  private

  def find_user
    @user = User.find_by_id(finding_params)
  end

  def finding_params
    params.permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
  end
end
