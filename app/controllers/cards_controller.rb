class CardsController < ApplicationController
  before_action :find_card, except: %i[new create]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new card_params
    if @card.save
      redirect_to card_path @card, success: 'Tarjeta cargada con éxito'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if current_user.cards.include? self
      render :edit
    else
      redirect_to root_path, alert: 'No tienes permitido realizar esta acción'
    end
  end

  def update
    if @card.update card_params
      redirect_to card_path, success: 'Tarjeta modificada con éxito'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @card.destroy
      redirect_to cards_path
    else
      render :new
    end
  end

  private

  def finding_params
    params.permit(:id)
  end

  def card_params
    params.require(:card).permit(:number, :pin, :expiration, :owner, :bank, :kind, :user_id, :wallet_id)
  end

  def find_card
    @card = Card.find_by_id(finding_params[:id])
  end
end
