class CarsController < ApplicationController
  before_action :find_car, except: %i[new create]

  def edit; end

  def update
    authorize Car

    if @car.update car_params
      redirect_to car_path, success: 'Auto modificado exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    if current_user.supervisor? || current_user.client?
      @car = Car.new
    else redirect_to root_path
    end
  end

  def create
    if current_user.supervisor? || current_user.client?  
      @car = Car.new(car_params)
      if @car.save
        flash[:notice] = "Auto agregado exitosamente"
        redirect_to cars_path
      else
        flash[:notice] = "Error al cargar nuevo auto"
        render :new
      end
    else redirect_to cars_path
    end
  end

  private

  def finding_params
    params.permit(:id)
  end

  def car_params
    params.require(:car).permit(:plate, :insurance, :brand, :model, :kilometers, :car_number, :color, :photo)
  end

  def find_car
    @car = Car.find_by_id(finding_params[:id])
  end
end