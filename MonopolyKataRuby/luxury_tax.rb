############################
#
## author: Isaac Sumner
############################

require_relative "player.rb"
require_relative "space.rb"

class Luxury_Tax < Space

    def initialize()
        super(38)
    end

    def add_player(player)
        collect(player)
        super(player)
    end

    # Collects the income tax from the given player
    def collect(player)
        player.subtract_balance(75)
    end
end
