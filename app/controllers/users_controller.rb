class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new]
  before_action :find_user, except: %i[new create new_supervisor create_supervisor]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    return if @user.save

    render :new, status: :unprocessable_entity
  end

  def edit; end

  def index
    if current_user.admin?
      @user = User.where(role: 'supervisor', blocked: false)
    else
      redirect_to root_path, success: 'No podes'
    end
  end

  def update
    if @user.update user_params
      redirect_to users_path, notice: 'Sus datos se modificaron exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new_supervisor
    if current_user.admin?
      @user = User.new
    else
      render :root_path
    end
  end

  def create_supervisor
    authorize User
    @user = User.new user_params
    @user.role = 'supervisor'
    @user.wallet = Wallet.new
    if @user.save
      redirect_to users_path, notice: 'Usuario supervisor creado con exito'
    else
      render :new_supervisor, status: :unprocessable_entity
    end
  end

  def delete_supervisor
    if current_user.admin?
      @user.blocked = true
      if @user.save
        redirect_to users_path, notice: 'Usuario eliminado con exito'
      end
    else
      render :root_path
    end
  end

  def edit_supervisor
    authorize User
    if @user.supervisor?
      render :edit_supervisor
    else
      redirect_to root_path, alert: 'El usuario no es superusuario'
    end
  end

  def update_supervisor
    authorize User
    if @user.update user_params
      redirect_to show_supervisor_user_path(@user), notice: 'Usuario editado con éxito'
    else
      render :edit_supervisor
    end
  end

  private

  def find_user
    @user = User.find_by_id(finding_params[:id])
  end

  def finding_params
    params.permit(:id)
  end

  def user_params_edit
    params.require(:user).permit(:name, :last_name)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role, :dni, :birthday, :latitude, :longitude)
  end

end
