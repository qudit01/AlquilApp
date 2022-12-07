class FinesController < ApplicationController

  def index
    @fines = Fine.all
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
    @fine.rental = @rental
      if @fine.save
        redirect_to fine_path(@fine) 
        flash[:notice]= "Se ha generado la multa con exito"
      else
        render :new, notice: "Error al generar la multa"
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
