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
            @fines -= @fines.select{|fines| fines.typefine == 'Otros'}
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

    def rentals
        @rentals= Rental.all
    end

    def rentals_generate
        @report = Report.new()
        @rentals= Rental.all
         if (params[:travelling]=='0')
             @rentals -= @rentals.select{|rentals| rentals.state == 'travelling'}
         end
         if (params[:extended]=='0')
            @rentals -= @rentals.select{|rentals| rentals.state == 'extended'}
        end
        if (params[:finished]=='0')
            @rentals -= @rentals.select{|rentals| rentals.state == 'finished'}
        end
        if (params[:option_car == 'N° de Auto'])
            if (params[:car_number]!='')
                @rentals -= @rentals.select{|rentals| rentals.car.car_number != params[:car_number].to_i}
            end
        end
        if (params[:option_car == 'Patente'])
            if (params[:patente]!='')
                @rentals -= @rentals.select{|rentals| rentals.car.plate != params[:patente]}
            end
        end
        if (params[:min_horas]!='')
            @rentals -= @rentals.select{|rentals| rentals.hours.to_i < params[:min_horas].to_i}
        end
        if (params[:max_horas]!='')
            @rentals -= @rentals.select{|rentals| rentals.hours.to_i > params[:max_horas].to_i}
        end
        if(params[:fines] == '1')
            @rentals -= @rentals.select{|rentals| rentals.fines.length == 0}
        end


        @rentals -= @rentals.select{|rentals| rentals.created_at < params[:desde]}
        @rentals -= @rentals.select{|rentals| rentals.created_at > params[:hasta]}

        @monto=0
        @rentals.each do |r|
            @monto = @monto + r.price
        end
        @report.rentals = @rentals.length
        @report.save
    end

    def users
        @users= User.all.where(role:'client')
    end

    def users_generate
        @report = Report.new()
        @users= User.all.where(role:'client')

        if (params[:travelling]=='0')
            @users -= @users.select{|users| users.state == 'travelling'}
        end

        if (params[:stall]=='0')
            @users -= @users.select{|users| users.state == 'stall'}
        end

        if (params[:fines]=='0')
            @users -= @users.select{|users| users.fines.length > 0}
        end

        if (params[:no_fines]=='0')
            @users -= @users.select{|users| users.fines.length == 0}
        end

        if (params[:negative_money]=='0')
            @users -= @users.select{|users| users.wallet.money < 0}
        end

        if (params[:no_negative]=='0')
            @users -= @users.select{|users| users.wallet.money >= 0}
        end

        if (params[:blocked]=='0')
            @users -= @users.select{|users| users.blocked?}
        end

        if (params[:no_blocked]=='0')
            @users -= @users.select{|users| !users.blocked?}
        end

        if (params[:first_name]!='' && params[:last_name]!='')
            @users -= @users.select{|users| users.name != (params[:first_name]+' '+params[:last_name])}
        end

        if (params[:email]!='')
            @users -= @users.select{|users| users.email != params[:email]}
        end

        if (params[:dni]!='')
            @users -= @users.select{|users| users.dni != params[:dni].to_i}
        end

        if (params[:min_edad]!='')
            @users -= @users.select{|users| users&.age < params[:min_edad].to_i}
        end

        if (params[:min_edad]!='')
            @users -= @users.select{|users| users&.age < params[:min_edad].to_i}
        end
        if (params[:max_edad]!='')
            @users -= @users.select{|users| users&.age > params[:max_edad].to_i}
        end

        @users -= @users.select{|users| users.created_at < params[:desde]}
        @users -= @users.select{|users| users.created_at > params[:hasta]}

        @monto=0
        @users.each do |u|
            @monto = @monto + u.wallet.money
        end
        @report.users = @users.length
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
