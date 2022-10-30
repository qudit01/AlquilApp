class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    if login session_params[:email], session_params[:password]
      redirect_back_or_to(root_path, success: 'Sesión iniciada!')
    else
      redirect_back_or_to(:new, 'Email o contraseña incorrecto')
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, notice: "Sesión cerrada!"
  end
  private

  def session_params
    params.permit(:email, :password)
  end
end
