class ResetPasswordsController < ApplicationController
  skip_before_action :require_login

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    not_authenticated && return if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      flash[:success] = 'Se ha cambiado la contraseña de manera exitosa'
      redirect_to login_path
    else
      render :edit
    end
  end

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.generate_reset_password_token!
      # @user.deliver_reset_password_instructions!
      redirect_to login_path, notice: 'Se han enviado instrucciones a tu mail'
    else
      flash[:alert] = 'El mail ingresado no está registrado'
      render :new
    end
  end
end
