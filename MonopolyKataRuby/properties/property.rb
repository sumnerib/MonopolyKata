############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../space.rb"

class Property < Space

    def initialize(location, price, rent, name)
        super(location)
        @price = price
        @rent = rent
        @name = name
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

    # Copies the attributes of other into this
    def copy(other)
        other.instance_variables.each do |v| 
          instance_variable_set v, other.instance_variable_get(v)
        end
    end

    # Sells this property to the given player
    def sell_to(player)
        return if @price > player.balance 
        !player.subtract_balance(@price)
        @owner = player.piece
        @owned = true
    end
end
