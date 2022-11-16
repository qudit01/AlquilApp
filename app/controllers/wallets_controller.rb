class WalletsController < ApplicationController
  before_action :find_wallet, except: %i[new create]

  def new
    @wallet = Wallet.new
  end

  def create
    @wallet = Wallet.create(wallet_params)
    if @wallet.save
      redirect_to wallet_path, success: 'Billetera creada con éxito'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @wallet.update wallet_params
      redirect_to user_path(@wallet.user), success: 'Dinero cargado!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @wallet.destroy
      redirect_to wallets_path
    else
      render :new
    end
  end

  private

  def finding_params
    params.permit(:id)
  end

  def wallet_params
    params.require(:wallet).permit(:money, :user)
  end

  def find_wallet
    @wallet = Wallet.find_by_id(finding_params[:id])
  end
end
