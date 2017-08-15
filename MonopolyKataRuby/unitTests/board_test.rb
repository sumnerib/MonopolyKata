##
#
#
## author: Isaac Sumner
############################

require_relative "../board.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require_relative "../game.rb"
require_relative "test_dice.rb"
require "test/unit"

class Board_Test<Test::Unit::TestCase

    def test_board

        p1 = Player.new("Car")
        b1 = Board.new()
        td = Test_Dice.new(1, 1)
        b1.get_space(1).add_player(p1)

        assert_equal(1, b1.get_location(p1))

        #Move player
        assert_equal(13, b1.move_player(p1, p1.roll(td)))

        #check special movements
        assert_equal(-1, b1.check_special_move(30))

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
        assert_equal(-1, b1.get_location(p2))
        assert_equal(0, p2.balance)
        p2 = Player.new("Watch")
        b1.move_player(p2, 31)
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
        b1.move_player(p2, 2)
        assert_equal(1, b1.get_location(p2))
        b1.move_player(p3, 2)
        assert_equal(3, b1.get_location(p3))
        b1.update_property_groups(1)
        assert_equal(4, b1.get_space(1).rent)

        # get space instance
        assert(b1.get_space_instance(0).instance_of? Go_Space)

        # Property
        b1.move_player(p2, 4)
        assert_equal(303, p2.balance)

        p4 = Player.new("Shoe")
        p4.add_balance(10000)
        p2.add_balance(10000)
        b1.move_player(p4, 5)
        assert_equal(9975, p4.balance)

        b1.move_player(p2, 10)
        b1.move_player(p4, 10)
        assert_equal(9925, p4.balance)

        b1.move_player(p2, 10)
        b1.move_player(p4, 10)
        assert_equal(25, b1.get_location(p4))
        assert_equal(100, b1.get_space(25).rent)
        assert_equal(9825, p4.balance)

        b1.move_player(p2, 10)
        b1.move_player(p4, 10)
        assert_equal(9625, p4.balance)  
        
        # Utilities
        b1.move_player(p2, 17)
        b1.move_player(p4, 17)
        assert_equal(9757, p4.balance)

        b1.move_player(p2, 16)
        b1.move_player(p4, 16)
        assert_equal(9597, p4.balance)

        # Jail
        p5 = Player.new("Dog")
        p5.add_balance(10000)
        td1 = Test_Dice.new(1, 2)
        b1.jail.add_player(p5)
        assert_equal(18, b1.do_jail(p5, td))
        assert(!b1.jail.in_jail(p5))
        
        b1.jail.add_player(p5)
        assert_equal(-1, b1.do_jail(p5, td1))
        assert_equal(-1, b1.do_jail(p5, td1))
        assert_equal(-1, b1.do_jail(p5, td1))
        assert_equal(15, b1.do_jail(p5, td1))

        b1.jail.add_player(p5)
        assert_equal(20, b1.do_jail(p5, td))

        assert_equal(10, b1.move_player_dice(p5, td))
       
        # Roll non-doubles, land on Go To Jail, player is in Jail, turn is over, 
        # balance is unchanged.
        b1.move_player(p5, 20)
        assert(b1.jail.in_jail(p5))
        
        # Pass over Go To Jail, nothing happens
        p6 = Player.new("Cat")
        p6.add_balance(10000)
        b1.move_player(p6, 31)
        assert(!b1.jail.in_jail(p6))

        # Send to jail
        b1.send_to_jail(p6)
        assert_equal(-1, b1.get_location(p6))
    end
end
