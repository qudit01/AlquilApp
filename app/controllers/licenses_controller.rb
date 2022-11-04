class LicensesController < ApplicationController
  
  def index
    if current_user.admin? || current_user.supervisor?
      @licenses = License.where(state:0)
    else redirect_to root_path
    end
  end
  
  def show
      @license = License.find(params[:id])
  end

  def new
    if current_user.client?
      @license = License.new
    else redirect_to root_path
    end
  end

  def create
    @license = License.new(license_params)
    @license.user = current_user
    current_user.license = @license
    if @license.save
      flash[:notice] = "Licencia subida con exito!"
      redirect_to licenses_path
    else
      flash[:notice] = "Por favor, subir un formato de imagen admitido (JPG, JPEG o PNG)"
      render :new
    end
  end

  def edit
    @license = License.find(params[:id])
  end

  def update
    @license = License.find(params[:id])
    if current_user.client?
      @license.state="pending"
        if @license.update(license_params)
          redirect_to licenses_path
        else
          flash[:notice] = "Por favor, subir un formato de imagen admitido (JPG, JPEG o PNG)"
          render :edit
        end
    else
        if @license.update(license_params)
          redirect_to licenses_path
        else
          render :edit
        end
    end
  end

  private
  def license_params
      params.require(:license).permit(:photo, :expire, :state, :motive)
  end
end
