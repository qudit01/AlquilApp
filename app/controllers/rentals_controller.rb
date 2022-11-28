class RentalsController < ApplicationController
  before_action :find_data
  before_action :find_rental, only: %i[destroy show]

  def delete
    destroy
  end

  def show
    @rental = Rental.find params[:id]
  end

  def new
    @rental = Rental.new
    @car = Car.find params[:car_id]
  end

  def edit
    @rental=current_user.rental
  end

  def update
    @rental=current_user.rental
    hr=@rental.hours
    h=rental_params[:hours].to_f
    if current_user.can_rent?(rental_params[:hours].to_f * rental_params[:price].to_f)
      if @rental.update rental_params
        update_user_and_car
        @rental.hours= hr+h
        @rental.save
        redirect_to user_path(current_user), notice: '¡Alquiler extendido con exito!'
      else
        render :edit, alert: 'Ocurrio un error inesperado, por favor intente nuevamente'
      end
    else
      redirect_to user_path(current_user), alert:'No cuenta con suficiente dinero para este alquiler. Por favor, ingrese más dinero en la billetera virtual y vuelva a intentarlo'
    end
  end

  def create
    if current_user.travelling?
      flash[:alert] = 'Ya tienes un viaje en curso, finaliza el actual y vuelve a intentarlo'
      redirect_to rental_path(@rental, car_id: @rental.car) and return
    end
    @rental = Rental.new(user: current_user,
                         car: @car,
                         hours: rental_params[:hours],
                         price: rental_params[:hours].to_f * rental_params[:price].to_f)
    if current_user.can_rent?(@rental.price)
      if @rental.valid?
        update_user_and_car
        @rental.save
        redirect_to rental_path(@rental, car_id: @rental.car), notice: '¡Alquiler realizado con éxito! ¡Tu auto te está esperando!'
      end
    else
      redirect_to cars_path, alert: 'No cuenta con suficiente dinero para este alquiler. Por favor, ingrese más dinero en la billetera virtual y vuelva a intentarlo'
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
