############################
## Unit Test for Jail 
#
## author: Isaac Sumner
############################

require_relative "../jail.rb"
require_relative "../player.rb"
require_relative "test_dice.rb"
require "test/unit"

class Jail_test<Test::Unit::TestCase

    def test_jail

        j = Jail.new()
        p1 = Player.new("Horse")
        td = Test_Dice.new(2, 1)
        td1 = Test_Dice.new(1, 1)
        
        j.add_player(p1)

        # roll to leave
        assert(j.in_jail(p1))
        assert_equal(-1, j.roll_to_leave(p1, td))

        assert_equal(22, j.roll_to_leave(p1, td1))

        # pay to leave
        j.add_player(p1)
        j.pay_to_leave(p1, td)
        assert(j.in_jail(p1))        

        p1.add_balance(1000)
        assert_equal(20, j.pay_to_leave(p1, td))
        assert(!j.in_jail(p1))

        # Read in option
        assert_equal(1, j.read_in_option())
        assert_equal(2, j.read_in_option())
        assert_equal(3, j.read_in_option())
        assert_equal(1, j.read_in_option())

        # Turns taken
        j.add_player(p1)
        j.roll_to_leave(p1, td)
        j.roll_to_leave(p1, td)
        assert_equal(2, j.turns_taken(p1))
    end
end