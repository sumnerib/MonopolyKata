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
        p1.turn=(1)
        p2 = Player.new("Car")
        p2.turn=(2)

        assert_equal(6, p1.roll(1))
        assert_equal(1, p1.roll(2))
    end
end

