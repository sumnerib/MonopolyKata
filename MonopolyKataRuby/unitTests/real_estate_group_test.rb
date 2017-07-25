############################
## Unit Test for Property_Group 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/real_estate.rb"
require_relative "../properties/real_estate_group.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Real_Estate_Group_test<Test::Unit::TestCase

    def test_real_estate_group

        pg = Real_Estate_Group.new()
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

        # Update rent
        pg.update_rent(1)
        assert_equal(35, pp.rent)
        assert_equal(50, bw.rent)

        p1 = Player.new("Horse")
        p1.add_balance(1000)
        pp.add_player(p1)
        bw.add_player(p1)

        pg.update_rent(1)
        assert_equal(70, pp.rent)
        assert_equal(100, bw.rent)
    end
end