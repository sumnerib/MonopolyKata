############################
#
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require "test/unit"

class Player_Test<Test::Unit::TestCase

    def test_player

        p1 = Player.new("Horse")
        p2 = Player.new("Car")

        assert_equal(6, p1.roll(1))
        assert_equal(1, p1.roll(2))

        #Balance changes
        p1.add_balance(20)
        assert_equal(20, p1.balance)
        p1.subtract_balance(10)
        assert_equal(10, p1.balance)
        p1.subtract_balance(20)
        assert_equal(0, p1.balance)
    end
end
