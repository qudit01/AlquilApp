class RentalsController < ApplicationController
  before_action :find_data
  before_action :find_rental, only: %i[destroy show edit update]

  def show
    destroy
  end

  def new
    @rental = Rental.new
    @car = Car.find params[:car_id]
  end

  def create
    if current_user.travelling?
      flash[:alert] = 'Ya tienes un viaje en curso'
      redirect_to user_path(current_user) and return
    end
    @rental = Rental.new(user: current_user,
                         car: @car,
                         hours: rental_params[:hours],
                         price: rental_params[:hours].to_f * rental_params[:price].to_f)
    if @rental.valid?
      update_user_and_car
      @rental.save
      redirect_to car_path(@car), notice: '¡Alquiler realizado con éxito! Tu auto te está esperando!'
    elsif !current_user.can_rent?(@rental.price)
      redirect_to cars_path, alert: 'No tienes suficientes fondos'
    else
      redirect_to cars_path, alert: 'Algo ha salido mal'
    end
  end

  def update_user_and_car
    current_user.travelling!
    current_user.wallet.money -= @rental.price * @rental.hours
    current_user.wallet.save
    @car.taken!
    @car.save
  end

  def index; end

  def generate
    redirect_to user_path(current_user), 'Alquiler exitoso!'
  end

  def destroy
    @rental.delete
    current_user.stall!
    @car.available!
    redirect_to cars_path, notice: 'Viaje finalizado con éxito!'
  end

  private

  def rental_params
    params.require(:rental).permit(:user, :car, :price, :hours)
  end

  def find_data
    @car = Car.find(params[:car_id])
  end

  def find_rental
    find_data
    @rental = Rental.find params[:id]
  end
end
