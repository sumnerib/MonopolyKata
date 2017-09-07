##
#
#
## author: Isaac Sumner
############################

require_relative "../cards/deck.rb"
require "test/unit"

class Deck_Test<Test::Unit::TestCase

    def test_deck 

        deck = Deck.new()

        # Add Card
        deck.add_card(Card.new("Test"))
        assert_equal(1, deck.cards.length)

        # Draw card
        assert_equal("Test", deck.draw_card().description)

        # Shuffle
        deck.add_card(Card.new("Test"))
        deck.add_card(Card.new("Test2"))
        assert_equal("Test2", deck.shuffle_deck(4)[0].description)
    end
end