##
#
#
## author: Isaac Sumner
############################

require_relative "../board.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../game.rb"
require "test/unit"

class Board_Test<Test::Unit::TestCase

    def test_board

        p1 = Player.new("Car")
        b1 = Board.new()
        b1.get_space(1).add_player(p1)

        assert_equal(1, b1.get_location(p1))

        #Move player
        assert_equal(7, b1.move_player(p1, p1.roll(1)))

        #check special movements
        assert_equal(10, b1.check_special_move(30))

        # check outcomes of landing on or moving past certain spaces
        p2 = Player.new("Horse")
        # go

        # go to Jail
        b1.move_player(p2, 30)
        assert_equal(10, b1.get_location(p2))
        assert_equal(0, p2.balance)
        b1.move_player(p2, 21)
        assert_equal(31, b1.get_location(p2))
        assert_equal(0, p2.balance)

        # income tax
        b1.move_player(p2, 13)
        assert_equal(4, b1.get_location(p2))
        assert_equal(0, p2.balance)
        b1.move_player(p2, 41) # One passed income tax
        p2.balance = 200  # Remove after implementing Go
        assert_equal(200, p2.balance)

        # luxury_tax
        b1.move_player(p2, 33)
        assert_equal(38, b1.get_location(p2))
        assert_equal(125, p2.balance)
        b1.move_player(p2, 41) # One passed luxury tax
        p2.balance = 325  # Remove after implementing Go
        assert_equal(325, p2.balance)
    end
end
