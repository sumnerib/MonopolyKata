############################
## Unit Test for Property_Group 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/property_group.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Property_Group_test<Test::Unit::TestCase

    def test_property_group

        pg = Property_Group.new(Property_Consts::DARK_BLUE)
        pp = Real_Estate.new(37, 350, 35, "Park Place", Property_Consts::DARK_BLUE)
        bw = Real_Estate.new(39, 400, 50, "Boardwalk", Property_Consts::DARK_BLUE)
        pg.add_property(pp)
        pg.add_property(bw)
        assert(pg.properties.include?(pp))
        assert(pg.properties.include?(bw))
        assert(!pg.properties.include?(Real_Estate.new(
            31,
            300,
            26,
            "Pacific Ave.",
            Property_Consts::DARK_GREEN
        )))

        pg.update_rent()
        assert_equal(35, pp.rent)
        assert_equal(50, bw.rent)

        p1 = Player.new("Horse")
        p2 = Player.new("Car")
        p1.add_balance(1000)
        p2.add_balance(1000)
        pp.add_player(p1)
        bw.add_player(p2)

        pg.update_rent()
        assert_equal(70, pp.rent)
        assert_equal(100, bw.rent)
    end
end
