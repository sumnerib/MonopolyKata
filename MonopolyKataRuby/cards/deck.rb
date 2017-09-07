############################
#
## author: Isaac Sumner
############################

require_relative "card.rb"

class Deck 

    def initialize()
        @cards = []
    end

    attr_reader :cards

    # place a card in the deck
    def add_card(card)
        @cards.push(card)
    end

    # TODO: draw the card
    def draw_card
        @cards.pop()
    end

    def place_at_bottom(card)
        @cards.unshift(card)
    end

    # TODO: Shuffle the deck
    def shuffle_deck(seed=time.usec)
        @cards = @cards.shuffle(random: Random.new(seed))
    end
end