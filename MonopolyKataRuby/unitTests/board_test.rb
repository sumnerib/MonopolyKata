##
#
#
## author: Isaac Sumner
############################

require_relative "../board.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../game.rb"
require "test/unit"

class Board_Test<Test::Unit::TestCase

    def test_board

        p1 = Player.new("Car")
        b1 = Board.new()
        b1.get_space(1).add_player(p1)

        assert_equal(1, b1.get_location(p1))

        #Move player
        assert_equal(7, b1.move_player(p1, p1.roll(1)))

        #check special movements
        assert_equal(10, b1.check_special_move(30))

        # check outcomes of landing on or moving past certain spaces
        p2 = Player.new("Horse")
        p3 = Player.new("Hat")

        # go
        b1.move_player(p2, 5)
        assert_equal(0, p2.balance)
        b1.move_player(p3, 38)
        b1.move_player(p3, 3)
        assert_equal(140, p3.balance)
        b1.move_player(p3, 80)
        assert_equal(540, p3.balance)

        # go to Jail
        b1.move_player(p2, 25)
        assert_equal(10, b1.get_location(p2))
        assert_equal(0, p2.balance)
        b1.move_player(p2, 21)
        assert_equal(31, b1.get_location(p2))
        assert_equal(0, p2.balance)

        # income tax
        b1.move_player(p2, 13)
        assert_equal(4, b1.get_location(p2))
        assert_equal(180, p2.balance)
        b1.move_player(p2, 41) # One passed income tax
        assert_equal(180, p2.balance)

        # luxury_tax
        b1.move_player(p2, 33)
        assert_equal(38, b1.get_location(p2))
        assert_equal(105, p2.balance)
        p2.add_balance(200)
        b1.move_player(p2, 41) # One passed luxury tax
        assert_equal(105, p2.balance)

        # update property groups
        b1.get_space(1).add_player(p2)
        b1.get_space(3).add_player(p3)
        b1.update_property_groups(1)
        assert_equal(4, b1.get_space(1).rent)

        # get space instance
        assert(b1.get_space_instance(0).instance_of? Go_Space)
    end
end
