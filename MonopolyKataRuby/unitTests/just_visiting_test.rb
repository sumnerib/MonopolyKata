############################
## Unit Test for Just_Visiting
#
## author: Isaac Sumner
############################

require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../board.rb"
require "test/unit"

class Just_Visiting_test<Test::Unit::TestCase

    def test_just_visiting

        #gtj = Go_To_Jail.new()
        p = Player.new("Horse")
        b = Board.new()

        #check that players go to Just Visiting when landing on Go to Jail
        b.move_player(p, 10)
        assert(!b.jail.in_jail(p))
    end
end
