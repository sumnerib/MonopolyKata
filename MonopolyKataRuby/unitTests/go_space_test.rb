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
    end
end
