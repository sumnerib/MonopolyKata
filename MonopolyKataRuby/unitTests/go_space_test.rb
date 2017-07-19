############################
## Unit Test for Go_Space
#
## author: Isaac Sumner
############################

require_relative "../go_space.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require "test/unit"

class Go_Space_test<Test::Unit::TestCase
    
    def test_go_space
        
        gs = Go_Space.new()
        p = Player.new("Horse")

        gs.add_player(p)

        assert_equal(200, p.balance)

        p2 = Player.new("Car")
        gs.pay_player(p2)

        assert_equal(200, p2.balance)

        # Check pass go
        assert_equal(1, gs.times_passing_go(25, 20))
        assert_equal(0, gs.times_passing_go(30, 4))
        assert_equal(0, gs.times_passing_go(20, 20))
        assert_equal(3, gs.times_passing_go(10, 120))
    end
end
