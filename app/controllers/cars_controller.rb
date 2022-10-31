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

  private

  def finding_params
    params.permit(:id)
  end

  def car_params
    params.require(:car).permit(:plate, :insurance, :brand, :model, :kilometers)
  end

  def find_car
    @car = Car.find_by_id(finding_params[:id])
  end
end