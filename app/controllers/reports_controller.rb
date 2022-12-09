class ReportsController < ApplicationController

    def index
    end
    
    def fines
        @fines= Fine.all
    end

    def fines_generate
        @report = Report.new()
        @fines = fines.where(created_at: params[:desde]..params[:hasta])
        @report.fines = @fines.length
        @report.save
        
    end

    def create
    end

    def new
    end

    def delete
    end

    def destroy
    end

    def show
    end

    def update
    end
end
