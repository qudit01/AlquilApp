class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, alert: 'Debes tener una sesión iniciada!'
  end
end
