class Fine < ApplicationRecord
    belongs_to :rental

    enum state: { unpaid: 0, paid: 1 }


    def estado
        if state=='unpaid'
          "#{'Pendiente de pago'}"
        else
          "#{'Pagada'}"
        end
    end
end
