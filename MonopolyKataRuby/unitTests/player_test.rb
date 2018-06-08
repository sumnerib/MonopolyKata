############################
#
#
## author: Isaac Sumner
############################

require_relative "../player.rb"
require_relative "test_dice.rb"
require_relative "../board.rb"
require "test/unit"

class Player_Test<Test::Unit::TestCase

    def test_player

        p1 = Player.new("Horse")
        p2 = Player.new("Car")
        b = Board.new()
        td1 = Test_Dice.new(1, 2)
        td2 = Test_Dice.new(7, 1)
        td = Test_Dice.new(1, 1)

        assert_equal(7, p1.roll(td1))
        assert_equal(11, p1.roll(td2))

        #Balance changes
        p1.add_balance(20)
        assert_equal(20, p1.balance)
        p1.subtract_balance(10)
        assert_equal(10, p1.balance)
        p1.subtract_balance(20)
        assert_equal(0, p1.balance)

        #Move player
        assert_equal(12, p1.move(b, p1.roll(td)))

        # go
        p2.move(b, 5)
        assert_equal(0, p2.balance)

        p3 = Player.new("Hat")
        p3.move(b, 38)
        p3.move(b, 3)
        assert_equal(140, p3.balance)
        p3.move(b, 80)
        assert_equal(540, p3.balance)

        # go to Jail
        p2.move(b, 25)
        assert_equal(-1, b.get_location(p2))
        assert_equal(0, p2.balance)
        p2 = Player.new("Watch")
        p2.move(b, 31)
        assert_equal(31, b.get_location(p2))
        assert_equal(0, p2.balance)

        # income tax
        p2.move(b, 13)
        assert_equal(4, b.get_location(p2))
        assert_equal(180, p2.balance)
        p2.move(b, 41) # One passed income tax
        assert_equal(180, p2.balance)

        # luxury_tax
        p2.move(b, 33)
        assert_equal(38, b.get_location(p2))
        assert_equal(105, p2.balance)
        p2.add_balance(200)
        p2.move(b, 41) # One passed luxury tax
        assert_equal(105, p2.balance)

        # update property groups
        p2.move(b, 2)
        assert_equal(1, b.get_location(p2))
        p3.move(b, 2)
        assert_equal(3, b.get_location(p3))
        b.update_property_groups(1)
        assert_equal(4, b.get_space(1).rent)

        # get space instance
        assert(b.get_space_instance(0).instance_of? Go_Space)

        # Property
        p2.move(b, 4)
        assert_equal(303, p2.balance)

        p4 = Player.new("Shoe")
        p4.add_balance(10000)
        p2.add_balance(10000)
        p4.move(b, 5)
        assert_equal(9975, p4.balance)

        p2.move(b, 10)
        p4.move(b, 10)
        assert_equal(9925, p4.balance)

        p2.move(b, 10)
        p4.move(b, 10)
        assert_equal(25, b.get_location(p4))
        assert_equal(100, b.get_space(25).rent)
        assert_equal(9825, p4.balance)

        p2.move(b, 10)
        p4.move(b, 10)
        assert_equal(9625, p4.balance)  
        
        # Utilities
        p2.move(b, 17)
        p4.move(b, 17)
        assert_equal(9757, p4.balance)

        p2.move(b, 16)
        p4.move(b, 16)
        assert_equal(9597, p4.balance)

        # Jail
        p5 = Player.new("Dog")
        p5.add_balance(10000)
        td1 = Test_Dice.new(1, 2)
        b.jail.add_player(p5)
        assert_equal(18, b.do_jail(p5, td))
        assert(!b.jail.in_jail(p5))
        
        b.jail.add_player(p5)
        assert_equal(-1, b.do_jail(p5, td1))
        assert_equal(-1, b.do_jail(p5, td1))
        assert_equal(-1, b.do_jail(p5, td1))
        assert_equal(15, b.do_jail(p5, td1))

        b.jail.add_player(p5)
        assert_equal(20, b.do_jail(p5, td))

        #assert_equal(10, p5.take_turn(b, td1))
        p5.move(b, 10)
        p5.move(b, 20)
        # Roll non-doubles, land on Go To Jail, player is in Jail, turn is over, 
        # balance is unchanged.
        assert(b.jail.in_jail(p5))
        
        # Pass over Go To Jail, nothing happens
        p6 = Player.new("Cat")
        p6.add_balance(10000)
        p6.move(b, 31)
        assert(!b.jail.in_jail(p6))
    end
end
