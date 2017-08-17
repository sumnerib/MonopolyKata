############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../space.rb"

class Card_Space < Space

    def initialize(location, cards)
        super(location)
        @cards = cards
    end

    # TODO: Will need to draw a card
    def add_player(player)
        super(player)
    end
end
