##
#
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "../cards/get_out_of_jail.rb"
require "test/unit"

class Get_Out_of_Jail_Test<Test::Unit::TestCase

    def test_get_out_of_jail 

        player = Player.new("Thimble")
        gooj = Get_Out_of_Jail.new("Get Out of Jail Free")

        gooj.perform(player)
        assert_equal(gooj, player.get_out_of_jail)
    end
end