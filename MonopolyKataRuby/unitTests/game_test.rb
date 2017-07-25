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

class Game_Test<Test::Unit::TestCase

    def test_game

        td = Test_Dice.new(1)
        g = Game.new(20)
        g.add_player("Horse")
        g.add_player("Car")

        assert_equal(["Horse", "Car"], g.create_order(1))
        assert_equal(["Car", "Horse"], g.create_order(2))

        assert_equal("Car: 12, Horse: 8", g.play_round(td))
        assert_equal("Car: 22, Horse: 10", g.play_round(td))
        assert_equal("Car: 26, Horse: 18", g.play_round(td))

        g2 = Game.new(20)
        g2.add_player("Horse")

        assert_equal("Not enough players", g2.play_round(td))
    end
end
