class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new]

  def new; end

  def create
    if login session_params
      redirect_back_or_to(home_path, success: 'Sesión iniciada!')
    else
      redirect_back_or_to(:new, 'Email o contraseña incorrecto')
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
