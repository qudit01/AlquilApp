class RentalsController < ApplicationController
  before_action :find_data, except: %i[show index]
  before_action :find_rental, only: %i[destroy show]

  def delete
    destroy
  end

  def show
    @rental_actual = Rental.find(current_user.rentals.last.id)
    @rental_viejos = current_user.rentals.where(state: 2)
  end

  def new
    @rental = Rental.new
    @car = Car.find params[:car_id]
  end

  def edit
    @rental = current_user.rentals.last
  end

  def update
    @rental = current_user.rentals.last
    hr = @rental.hours
    h = rental_params[:hours].to_f
    if current_user.can_rent_on_money?(rental_params[:hours].to_f * rental_params[:price].to_f)
      if @rental.update rental_params
        update_user_and_car
        @rental.hours = hr + h
        @rental.extended!
        @rental.save
        redirect_to user_path(current_user), notice: '¡Alquiler extendido con exito!'
      else
        render :edit, alert: 'Ocurrio un error inesperado, por favor intente nuevamente'
      end
    else
      redirect_to user_path(current_user), alert: 'No cuenta con suficiente dinero para este alquiler. Por favor, ingrese más dinero en la billetera virtual y vuelva a intentarlo'
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
    if current_user.can_rent_on_time? @car
      if current_user.can_rent_on_money? @rental.price
        @rental.taken_at = DateTime.now
        @rental.travelling!
        if @rental.valid?
          update_user_and_car
          @rental.save
          redirect_to rental_path(@rental, car_id: @rental.car), notice: '¡Alquiler realizado con éxito! ¡Tu auto te está esperando!'
        end
      else
        redirect_to cars_path, alert: 'No cuenta con suficiente dinero para este alquiler. Por favor, ingrese más dinero en la billetera virtual y vuelva a intentarlo'
      end
    else
      redirect_to cars_path, alert: 'No han pasado mas de 3 horas desde tu último alquiler, vuelva a intentarlo mas tarde.'
    end
  end

  def update_user_and_car
    current_user.travelling!
    @car.taken!
    @car.save
  end

  def index
    @rentals = Rental.right_now
  end

  def generate
    redirect_to user_path(current_user), 'Alquiler exitoso!'
  end

  def destroy
    current_user.wallet.money -= @rental.price * @rental.hours * (@rental.time_passed? ? 3 : 1)
    @rental.update(finished_at: DateTime.now, state: 'finished')
    current_user.stall!
    @car.available!
    redirect_to cars_path, notice: 'Viaje finalizado con éxito!'
  end

  private

  def rental_params
    params.require(:rental).permit(:user, :car, :price, :hours)
  end

  def find_data
    @car = Car.find(current_user.rentals.last.car_id)
  end

  def find_rental
    find_data
    @rental = Rental.find params[current_user.rentals.last.id]
  end
end
