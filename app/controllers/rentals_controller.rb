class RentalsController < ApplicationController
  before_action :find_data

  def show; end

  def new
    @rental = Rental.new(user: @user, car: @car)
    if @rental.valid?
      update_user_and_car
      @rental.save
      redirect_to user_path(@user), notice: '¡Alquiler realizado con éxito! Tu auto te está esperando!'
    elsif !@user.can_rent?(@rental.price)
      redirect_to cars_path, alert: 'No tienes suficientes fondos'
    else
      redirect_to cars_path, alert: 'Algo ha salido mal'
    end
  end

  def update_user_and_car
    @rental.user.state = 'travelling'
    @rental.user.wallet.money -= @rental.price
    @rental.user.save
    @rental.car.state = 'taken'
    @rental.car.save
  end

  def create
    @rental = Rental.new(params)
    if @rental.valid?
      @rental.user.state = 'travelling'
      @rental.car.state = 'taken'
      @rental.save
    else
      redirect_to cars_path, alert: 'No tienes suficientes fondos'
    end
  end

  def index; end

  def generate
    redirect_to user_path(current_user), 'Alquiler exitoso!'
  end

  private

  def rental_params
    params.require(:rental).permit(:user, :car, :price)
  end

  def find_data
    @user = User.find(params[:user])
    @car = Car.find(params[:car])
  end
end
