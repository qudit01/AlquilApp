class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :require_login
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include Pundit
  include Pundit::Authorization

  private

  def not_authenticated
    redirect_to login_path, alert: 'Debes tener una sesión iniciada!'
  end

  def user_not_authorized
    flash[:error] = 'No tienes permisos para realizar esa acción'
    redirect_to root_path
  end
end
