class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  layout 'login'

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user.present? && @user.role? && !@user.blocked
      redirect_to(users_path, notice: 'Ingreso de sesion exitoso')
    else
      flash.now[:alert] = 'Ingreso erróneo...'
      render action: 'show', status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, notice: 'Sesión cerrada!'
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
