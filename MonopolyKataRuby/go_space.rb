############################
#
## author: Isaac Sumner
############################

require_relative "player.rb"
require_relative "space.rb"

class Go_Space < Space

    def initialize()
        super(0)
    end

    def add_player(player)
        pay_player(player)
        super(player)
    end

    # Returns the number of times a player passed go
    def times_passing_go(old_loc, roll)
        times = (old_loc + roll) / 40
        return (old_loc + roll) % 40 == 0 ? times - 1 : times 
    end

    # Collects the income tax from the given player
    def pay_player(player)
        player.add_balance(200)
    end
end
