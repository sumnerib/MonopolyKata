############################
## Unit Test for Space
#
## author: Isaac Sumner
############################

require_relative "../space.rb"
require_relative "../player.rb"
require "test/unit"

class Space_test<Test::Unit::TestCase

    def test_space

        s1 = Space.new(20)
        s2 = Space.new(30)
        p1 = Player.new("Horse")
        p2 = Player.new("Car")

        s1.add_player(p1)
        s2.add_player(p2)

        # has_player
        assert(s1.has_player(p1))
        assert(!s2.has_player(p1))
        assert(!s1.has_player(p2))
        assert(s2.has_player(p2))

        #remove_player
        s1.remove_player(p1.piece)
        assert(!s1.has_player(p1.piece))
    end
end
