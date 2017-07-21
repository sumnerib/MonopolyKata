############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../space.rb"

class Property < Space

    def initialize(location, price, rent)
        super(location)
        @price = price
        @rent = rent
        @owned = false
        @owner = nil 
    end

    attr_reader :owned
    attr_reader :owner
    attr_accessor :rent

    def add_player(player)
        super(player)
        
        if (!@owned)   
            sell_to(player)
        elsif (@owner != player.piece)
            charge_rent(player)
        end 
    end

    # Charges the given player for the rent 
    # This method doesn't check if player is owner
    def charge_rent(player)
        player.subtract_balance(@rent)
    end

    # Sells this property to the given player
    def sell_to(player)
        return if @price > player.balance 
        !player.subtract_balance(@price)
        @owner = player.piece
        @owned = true
    end
end
