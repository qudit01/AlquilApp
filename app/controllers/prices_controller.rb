$price_per_hour

class PricesController < ApplicationController
    def update_price
        $price_per_hour = params[:price]
        redirect_to edit_price_path, notice: 'Precio por hora actualizado'
    end

    def edit_price; end
end
