##
#
#
## author: Isaac Sumner
############################

require_relative "../cards/deck.rb"
require_relative "../cards/card_space.rb"
require_relative "../player.rb"
require_relative "../board.rb"
require_relative "../cards/movement_card.rb"
require_relative "../cards/transaction_card.rb"
require_relative "../cards/get_out_of_jail.rb"
require "test/unit"

class Card_Space_Test<Test::Unit::TestCase

    def test_card_space 

        board = Board.new()        
        deck = Deck.new()
        reader = File_Reader.new("C:\\Users\\IBSUMNE\\MonopolyKata\\MonopolyKataRuby\\cards\\chance.in")
        while (reader.has_next)
            line = reader.next()
            case line[0]
            when "Transaction"
                deck.add_card(Transaction_Card.new(line[3], line[1].to_i, 
                                                   line[2] == "true"))
            when "Movement"
                deck.add_card(Movement_Card.new(line[2], line[1].to_i, board))
            else
                deck.add_card(Get_Out_of_Jail.new(line[0]))
            end
        end

        deck.shuffle_deck(4)
        card_space = Card_Space.new(7, deck)
        player = Player.new("Car")
        player.add_balance(1000)

        card_space.add_player(player)
        assert_equal(39, board.get_location(player))
        card_space.add_player(player)
        #assert_equal(-1, board.get_location(player))
        card_space.add_player(player)
        assert_equal(1050, player.balance)
        card_space.add_player(player)
        assert_equal(24, board.get_location(player))
    end
end