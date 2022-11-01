class LicensesController < ApplicationController
    def index
        @licenses = License.all
    end

    def show
        @license = License.find(params[:id])
    end

    def new
        @license = License.new
    end

    def create
        @license = License.new(license_params)
        @license.user = current_user
        current_user.license = @license
        if @license.save
            redirect_to licenses_path
        else
            render :new
        end
    end

    def edit
        @license = License.find(params[:id])
    end

    def update
        @license = License.find(params[:id])
            if @license.update(license_params)
                redirect_to licenses_path
            else
                render :edit
            end
    end

    private
    def license_params
        params.require(:license).permit(:photo, :expire, :state, :motive)
    end
end
