##
#
#
## author: Isaac Sumner
############################

require_relative "../board.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../game.rb"
require_relative "test_dice.rb"
require "test/unit"

class Board_Test<Test::Unit::TestCase

    def test_board

        p1 = Player.new("Car")
        b1 = Board.new()
        td = Test_Dice.new(1, 1)
        b1.get_space(1).add_player(p1)

        assert_equal(1, b1.get_location(p1))

        #check special movements
        assert_equal(-1, b1.check_special_move(30))

        # check outcomes of landing on or moving past certain spaces
        p2 = Player.new("Horse")
        p3 = Player.new("Hat")

        # Send to jail
        b1.send_to_jail(p3)
        assert_equal(-1, b1.get_location(p3))

        # Community Chest
        p2.add_balance(1000)
        p2.move(b1, 2)
        assert_equal(1100, p2.balance)

        # Chance
        p2.move(b1, 5)
        assert_equal(1200, p2.balance)        
    end
end
