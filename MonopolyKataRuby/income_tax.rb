############################
#
## author: Isaac Sumner
############################

require_relative "player.rb"
require_relative "space.rb"

class Income_Tax < Space

    def initialize()
        super(4)
    end

    def add_player(player)
        collect(player)
        super(player)
    end

    # Collects the income tax from the given player
    def collect(player)

        amount = player.balance * 0.1
        amount = amount < 200 ? amount : 200
        player.subtract_balance(amount)
        return amount
    end
end
