############################
## Unit Test for Property_Group 
#
## author: Isaac Sumner
############################

require_relative "../properties/property.rb"
require_relative "../properties/real_estate.rb"
require_relative "../properties/utility.rb"
require_relative "../properties/utility_group.rb"
require_relative "../properties/property_consts.rb"
require "test/unit"

class Utility_Group_test<Test::Unit::TestCase

    def test_real_estate_group

        pg = Utility_Group.new()
        pp = Utility.new(12, 150, "Electric Company")
        bw = Utility.new(28, 150, "Water Works")
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
        assert_equal(4, pp.rent)
        assert_equal(4, bw.rent)

        p1 = Player.new("Horse")
        p1.add_balance(1000)
        pp.add_player(p1)
        bw.add_player(p1)

        pg.update_rent(1)
        assert_equal(10, pp.rent)
        assert_equal(10, bw.rent)
    end
end