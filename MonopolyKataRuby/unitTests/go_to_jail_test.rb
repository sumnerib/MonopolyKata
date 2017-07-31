############################
## Unit Test for Go_o_jail
#
## author: Isaac Sumner
############################

require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../go_to_jail.rb"
require_relative "../jail.rb"
require "test/unit"

class Go_To_Jail_test<Test::Unit::TestCase

    def test_go_to_jail

        p = Player.new("Horse")
        j = Jail.new()
        g2j = Go_To_Jail.new(j)

        g2j.add_player(p)
        assert(j.in_jail(p))
    end
end