############################
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../space.rb"

class Card_Space < Space

    def initialize(location, deck)
        super(location)
        @deck = deck
    end

    # TODO: Will need to draw a card
    def add_player(player)
        super(player)
        card = @deck.draw_card
        card.perform(player)
        @deck.place_at_bottom(card)
    end
end
