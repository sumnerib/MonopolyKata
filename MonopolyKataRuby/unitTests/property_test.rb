############################
## Unit Test for Go_Space
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../space.rb"
require_relative "../player.rb"
require "test/unit"

class Property_test<Test::Unit::TestCase

    def test_property
        
        p1 = Player.new("Horse")
        p1.add_balance(100)
        prop = Property.new(1, 60, 2, "Boardwalk")

        prop.sell_to(p1)
        assert_equal(40, p1.balance)
        assert(prop.owned)
        assert_equal("Horse", prop.owner)

        prop.add_player(p1)
        assert_equal(40, p1.balance)

        # Test rent 
        p2 = Player.new("Car")
        p2.add_balance(10)
        prop.charge_rent(p2)
        assert_equal(8, p2.balance)

        # Test copy
        prop2 = Property.new(2, 70, 5, "Boardwalk")
        prop2.copy(prop)
        assert_equal(prop.owner, prop2.owner)
    end
end