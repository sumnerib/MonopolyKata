############################
#
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "test_dice.rb"
require "test/unit"

class Player_Test<Test::Unit::TestCase

    def test_player

        p1 = Player.new("Horse")
        p2 = Player.new("Car")
        td1 = Test_Dice.new(1)
        td2 = Test_Dice.new(2)

        assert_equal(12, p1.roll(td1))
        assert_equal(2, p1.roll(td2))

        #Balance changes
        p1.add_balance(20)
        assert_equal(20, p1.balance)
        p1.subtract_balance(10)
        assert_equal(10, p1.balance)
        p1.subtract_balance(20)
        assert_equal(0, p1.balance)
    end
end
