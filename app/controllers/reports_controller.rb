class ReportsController < ApplicationController

    def index
        Report.delete_all
    end
    
    def fines
        @fines= Fine.all
    end

    def fines_generate
        @report = Report.new()
        @fines= Fine.all
        if (params[:pagas]=='0')
            @fines -= @fines.select{|fines| fines.state == 'paid'}
        end
        if (params[:inpagas]=='0')
            @fines -= @fines.select{|fines| fines.state == 'unpaid'}
        end
        if (params[:tanque]=='0')
            @fines -= @fines.select{|fines| fines.typefine == 'Tanque no lleno'}
        end
        if (params[:transito]=='0')
            @fines -= @fines.select{|fines| fines.typefine == 'Transito'}
        end
        if (params[:terceros]=='0')
            @fines -= @fines.select{|fines| fines.typefine == "Daños a terceros"}
        end
        if (params[:vehiculo]=='0')
            @fines -= @fines.select{|fines| fines.typefine == 'Daños al vehiculo'}
        end
        if (params[:indebido]=='0')
            @fines -= @fines.select{|fines| fines.typefine == 'Uso indebido'}
        end
        if (params[:otros]=='0')
            @fines -= @fines.select{|fines| fines.typefine == 'Daños a terceros'}
        end
        @fines -= @fines.select{|fines| fines.created_at < params[:desde]}
        @fines -= @fines.select{|fines| fines.created_at > params[:hasta]}
        @monto=0
        @fines.each do |f|
            @monto = @monto + f.price
        end
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
