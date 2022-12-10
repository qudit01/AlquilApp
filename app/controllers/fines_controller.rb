class FinesController < ApplicationController

  def index
    if current_user.admin? || current_user.supervisor?
      @fines = Fine.all
    else
      @fines = current_user.fines
    end
  end

  def show
    @fine = Fine.find params[:id]
  end

  def new
    @fine = Fine.new
  end

  def edit
  end

  def create
    @fine = Fine.new(rental: @rental, motive: params[:motive], price: params[:price], typefine: params[:typefine])
    @rental = Rental.find params[:rental_id]
    @user = User.find(@rental.user_id)
    @fine.rental = @rental
    @fine.user = @user
      if @fine.save
        redirect_to fine_path(@fine) 
        flash[:notice]= "Se ha generado la multa con exito"
      else
        render :new, notice: "Error al generar la multa"
      end
  end

  def pay_fine
    @fine= Fine.find params[:format]
    if current_user.can_rent_on_money?(@fine.price)
      current_user.wallet.money=current_user.wallet.money-@fine.price
      @fine.state='paid'
      @fine.save
      current_user.wallet.save
      redirect_to fines_path(), notice: 'Multa saldada con exito!'
    else
      redirect_to fines_path(), alert: 'No cuenta con suficiente dinero para este alquiler. Por favor, ingrese más dinero en la billetera virtual y vuelva a intentarlo'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_fine
    @fine = Fine.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def fine_params
    params.require(:fine).permit(:price, :motive, :typefine)
  end
end
