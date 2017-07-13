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

        b1 = Board.new()
        b1.get_space(1).add_player(Player.new("Car"))

        assert_equal(1, b1.get_location("Car"))
    end
end
