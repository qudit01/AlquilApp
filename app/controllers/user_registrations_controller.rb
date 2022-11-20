class UserRegistrationsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  layout 'login'

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.wallet = Wallet.new
    if @user.save
      auto_login(@user, notice: 'Registro exitoso!')
      redirect_to(users_path, notice: 'Registro exitoso!')
    else
      flash.now[:alert] = 'Registro erróneo...'
      render action: 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :dni, :role, :email, :password, :password_confirmation, :latitude, :longitude)
  end
end
