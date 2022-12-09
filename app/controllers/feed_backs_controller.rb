class FeedBacksController < ApplicationController
  before_action :find_feed_back, except: %i[new create]
  UPDATE_MSG = 'Informe editado con éxito. Muchas gracias por su aporte'.freeze
  CREATE_MSG = 'Informe enviado con éxito. Muchas gracias por su aporte'.freeze

  def new
    @feed_back = FeedBack.new
  end

  def create
    @feed_back = FeedBack.new feed_back_params
    if @feed_back.save
      redirect_to rental_path(feed_back_params[:rental_id], car_id: feed_back_params[:car_id]), notice: CREATE_MSG
    else
      render :new
    end
  end

  def edit; end

  def update
    if @feed_back.udpate(feed_back_params)
      redirect_to rental_path(feed_back_params[:rental_id], car_id: feed_back_params[:car_id]), notice: UPDATE_MSG
    else
      render :edit
    end
  end

  def destroy
    @feed_back.destroy
    redirect_to rental_path(delete_feed_back_params[:rental_id])
  end

  private

  def feed_back_params
    params.require(:feed_back).permit(:comment, :score, :user_id, :car_id, :rental_id)
  end

  def find_feed_back
    @feed_back = FeedBack.find params[:id]
  end

  def delete_feed_back_params
    params.require(:feed_back).permit(:rental_id)
  end
end
