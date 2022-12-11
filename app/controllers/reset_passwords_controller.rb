class ResetPasswordsController < ApplicationController
  skip_before_action :require_login

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated if @user.blank?
  end

  def update
    @token = user_token_param[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated && return if @user.blank?

    @user.password_confirmation = user_params[:password_confirmation]
    if @user.change_password(user_params[:password])
      flash.now[:notice] = 'Se ha cambiado la contraseña de manera exitosa'
      redirect_to login_path
    else
      render action: :edit, status: :unprocessable_entity
    end
  end

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions! if @user
      flash.now[:notice] = 'Se han enviado instrucciones a tu mail'
      redirect_to login_path
    else
      flash.now[:alert] = 'El mail ingresado no está registrado'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :id)
  end

  def user_token_param
    params.permit(:id)
  end
end
