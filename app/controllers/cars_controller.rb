class CarsController < ApplicationController
  before_action :find_car, except: %i[new create]

  def edit; end

  def delete; end

  def remove_car
    authorize Car
    @car.remove = true
    if @car.save
      redirect_to cars_path, notice: "Auto eliminado con exito"
    end
  end


  def index
    if current_user.admin? || current_user.supervisor?
      @cars = Car.where(remove:false)
    else
      if current_user.license.state == "ok" || current_user.license.state == "toexpire"
        @cars = Car.where(remove:false)
        @cars.each do |c|
          if c.latitude != nil && c.longitude != nil
            c1 = current_user.latitude - c.latitude
            c2 = current_user.longitude - c.longitude
            c.position = Math.sqrt((c1 * c1) + (c2 * c2))
            c.save
          end
        @cars = Car.where(position: 0..5)
        end
      else 
          flash[:notice] = 'Por favor cargue una foto de su licencia de conducir valida para poder utilizar la app, si ya lo hizo, por favor verifique que no haya sido rechazada, o bien espere a que un supervisor la verifique a la brevedad.'
      end
    end
  end

  def index_ver_mas_autos
    if current_user.license.state == "ok" || current_user.license.state == "toexpire"
      @cars = Car.where(remove:false)
    else
      flash[:notice] = "No hay autos"
    end
  end


  def show
      @car = Car.find(params[:id])
  end


  def update
    authorize Car

    if @car.update car_params
      redirect_to cars_path, notice: 'Auto modificado exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    if current_user.supervisor? || current_user.admin?
      @car = Car.new
    else
      redirect_to users_path
    end
  end

  def create
    authorize Car
    @car = Car.new(car_params)
    @car.photo = image_params
    if @car.save
      flash[:notice] = 'Auto agregado exitosamente'
      redirect_to cars_path
    else
      render :new, notice: 'Error al cargar nuevo auto'
    end
  end

  private

  def finding_params
    params.permit(:id)
  end

  def car_params
    params.require(:car).permit(:plate, :insurance, :brand, :model, :kilometers, :car_number, :color, :photo, :latitude, :longitude, :position)
  end

  def find_car
    @car = Car.find_by_id(finding_params[:id])
  end

  def image_params
    params[:car][:photo]
  end
end